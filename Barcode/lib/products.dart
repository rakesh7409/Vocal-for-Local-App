import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Products extends StatelessWidget {
  final String texty;
  final int productid;
  Products({this.texty, this.productid});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text('Vocal For Local'),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 2, 130, 121),
          ),
          body: Productspage(
            number: productid,
            name: texty,
          )),
    );
  }
}

class Productspage extends StatefulWidget {
  final int number;
  final String name;

  Productspage({Key key, @required this.name, @required this.number})
      : super(key: key);
  @override
  _ProductspageState createState() =>
      _ProductspageState(number: number, name: name);
}

class _ProductspageState extends State<Productspage>
    with TickerProviderStateMixin {
  final number, name;
  _ProductspageState({this.number, this.name});
  List confirm, confirmf;
  var confirmed = 1;
  int totallength;
  String stringValue, messwish;
  var map, maplength;
  var addedlist = new List();
  List<bool> _isFavoritedind, _isFavoritedfor;
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.75, end: 2);

  Future<List> confirmData() async {
    var response = await http.get(
        'http://3.132.212.67:8000/category/subimage/$number/1',
        headers: {"Accept": "application/json"});
    this.setState(() {
      confirm = json.decode(response.body);
    });
    _isFavoritedind = List<bool>.generate(confirm.length, (_) => false);
    return confirm;
  }

  Future<String> wishlist(String token, int id) async {
    var message;
    var response = await http
        .post('http://3.132.212.67:8000/category/wishlist/$id/', headers: {
      "Accept": "application/json",
      "Authorization": "Token $token"
    }, body: {});
    setState(() {
      message = json.decode(response.body);
      messwish = message["message"];
      print(messwish);
    });
    return messwish;
  }

  Future favourite() async {
    var message;
    final prefs = await SharedPreferences.getInstance();
    stringValue = prefs.getString('token');
    var response = await http.get(
      'http://3.132.212.67:8000/category/wishlist/view',
      headers: {
        "Accept": "application/json",
        "Authorization": "Token $stringValue",
      },
    );

    message = await json.decode(response.body);

    maplength = await message.length;
    var addedtolist = new List(maplength);
    for (var i = 0; i < maplength; i++) {
      addedtolist[i] = await message[i]["main_product"]["id"];
    }
    addedlist = addedtolist;
    print(addedlist);
    return addedtolist;
  }

  Future<List> confirmfData() async {
    var response = await http.get(
        'http://3.132.212.67:8000/category/subimage/$number/2',
        headers: {"Accept": "application/json"});

    this.setState(() {
      confirmf = json.decode(response.body);
    });
    _isFavoritedfor = List<bool>.generate(confirmf.length, (_) => false);

    return confirmf;
  }

  @override
  void initState() {
    super.initState();
    this.favourite();
    this.confirmData();
    this.confirmfData();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "$name",
                  style: TextStyle(
                      color: Colors.grey[850],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              )),
        ),
        Center(
          child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Text(
                "Showing Products",
                style: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              )),
        ),
        SizedBox(
          height: 20,
          width: 350,
          child: Divider(
            color: Colors.black,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: new Border.all(
                              color: Colors.transparent,
                              width: 1.0,
                              style: BorderStyle.solid),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(10.0)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(255, 255, 145, 77),
                              Color.fromARGB(255, 2, 130, 121),
                            ],
                            stops: [0.5, 0.7],
                          )),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GridView.builder(
                                itemCount: confirm == null ? 0 : confirm.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  if (addedlist
                                      .contains(confirm[index]["id"])) {
                                    _isFavoritedind[index] =
                                        !_isFavoritedind[index];
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Container(
                                          height: 200,
                                          width: 200,
                                          color: Colors.white,
                                        ),
                                        Align(
                                          widthFactor: 30,
                                          alignment: Alignment.center,
                                          child: Image.network(
                                            '${confirm[index]["Image_url"]}',
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace stackTrace) {
                                              return Text("Error");
                                            },
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent
                                                        loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes
                                                      : null,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0.0,
                                          left: 0.0,
                                          right: 0.0,
                                          child: Card(
                                            elevation: 8.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Center(
                                                child: Text(
                                                  '${confirm[index]["name"]}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Card(
                                            elevation: 8.0,
                                            shape: CircleBorder(),
                                            child: _isFavoritedind[index]
                                                ? ScaleTransition(
                                                    scale: _tween.animate(
                                                        CurvedAnimation(
                                                            parent: _controller,
                                                            curve: Curves
                                                                .elasticOut)),
                                                    child: IconButton(
                                                      iconSize: 20,
                                                      icon:
                                                          Icon(Icons.favorite),
                                                      color: Colors.red,
                                                      onPressed: () async {
                                                        var id = confirm[index]
                                                            ["id"];
                                                        setState(() {
                                                          _isFavoritedind[
                                                                  index] =
                                                              !_isFavoritedind[
                                                                  index];
                                                        });
                                                        var result =
                                                            await wishlist(
                                                                stringValue,
                                                                id);
                                                        final snackBar = SnackBar(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    300),
                                                            content: Text(
                                                                '$result'));
                                                        Scaffold.of(context)
                                                            .showSnackBar(
                                                                snackBar);
                                                      },
                                                    ),
                                                  )
                                                : IconButton(
                                                    iconSize: 30,
                                                    icon: Icon(
                                                        Icons.favorite_border),
                                                    color: Colors.red,
                                                    onPressed: () async {
                                                      var id =
                                                          confirm[index]["id"];
                                                      setState(() {
                                                        _isFavoritedind[index] =
                                                            !_isFavoritedind[
                                                                index];
                                                      });
                                                      var result =
                                                          await wishlist(
                                                              stringValue, id);
                                                      final snackBar = SnackBar(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  300),
                                                          content:
                                                              Text('$result'));
                                                      Scaffold.of(context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    },
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Container(
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GridView.builder(
                                itemCount:
                                    confirmf == null ? 0 : confirmf.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  if (addedlist
                                      .contains(confirmf[index]["id"])) {
                                    _isFavoritedfor[index] =
                                        !_isFavoritedfor[index];
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Container(
                                          height: 200,
                                          width: 200,
                                          color: Colors.white,
                                        ),
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Card(
                                            child: Image.network(
                                              '${confirmf[index]["Image_url"]}',
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace stackTrace) {
                                                return Text("Error");
                                              },
                                              fit: BoxFit.fill,
                                              alignment: Alignment.topCenter,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent
                                                          loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes
                                                        : null,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0.0,
                                          left: 0.0,
                                          right: 0.0,
                                          child: Card(
                                            elevation: 8.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Center(
                                                child: Text(
                                                  '${confirmf[index]["name"]}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Card(
                                            elevation: 8.0,
                                            shape: CircleBorder(),
                                            child: _isFavoritedfor[index]
                                                ? ScaleTransition(
                                                    scale: _tween.animate(
                                                        CurvedAnimation(
                                                            parent: _controller,
                                                            curve: Curves
                                                                .elasticOut)),
                                                    child: IconButton(
                                                      iconSize: 20,
                                                      icon:
                                                          Icon(Icons.favorite),
                                                      color: Colors.red,
                                                      onPressed: () async {
                                                        var id = confirmf[index]
                                                            ["id"];
                                                        setState(() {
                                                          _isFavoritedfor[
                                                                  index] =
                                                              !_isFavoritedfor[
                                                                  index];
                                                        });
                                                        var result =
                                                            await wishlist(
                                                                stringValue,
                                                                id);
                                                        final snackBar = SnackBar(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    300),
                                                            content: Text(
                                                                '$result'));
                                                        Scaffold.of(context)
                                                            .showSnackBar(
                                                                snackBar);
                                                      },
                                                    ),
                                                  )
                                                : IconButton(
                                                    iconSize: 30,
                                                    icon: Icon(
                                                        Icons.favorite_border),
                                                    color: Colors.red,
                                                    onPressed: () async {
                                                      var id =
                                                          confirmf[index]["id"];
                                                      setState(() {
                                                        _isFavoritedfor[index] =
                                                            !_isFavoritedfor[
                                                                index];
                                                      });
                                                      var result =
                                                          await wishlist(
                                                              stringValue, id);
                                                      final snackBar = SnackBar(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  300),
                                                          content:
                                                              Text('$result'));
                                                      Scaffold.of(context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    },
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
