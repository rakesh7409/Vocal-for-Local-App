import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class Listscroll extends StatefulWidget {
  @override
  _ListscrollState createState() => _ListscrollState();
}

class _ListscrollState extends State<Listscroll> {
  int numbert;
  var added = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: <Widget>[
                          Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Color.fromARGB(255, 2, 66, 130),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Understanding why is",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "#VocalforLocal",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "important?",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Image(
                                        image: AssetImage("images/two.png"),
                                        height: 70,
                                        width: 70,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Color.fromARGB(255, 2, 130, 121),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Indian Industries",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "A history in making",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Image(
                                        image: AssetImage("images/one.png"),
                                        height: 70,
                                        width: 70,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
              width: 250,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Text(
              "Handpicked favourites for you",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            Container(child: Imagesgrid())
          ],
        ),
      ),
    );
  }
}

class Imagesgrid extends StatefulWidget {
  @override
  _ImagesgridState createState() => _ImagesgridState();
}

class _ImagesgridState extends State<Imagesgrid> with TickerProviderStateMixin {
  List<dynamic> data;
  String stringValue;
  var len;
  Map<String, dynamic> map, message;
  String messwish;
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.75, end: 2);

  Future<List> getData() async {
    Random random = new Random();
    int randomNumber = random.nextInt(18);
    randomNumber = randomNumber + 1;
    var response = await http.get(
        'http://3.132.212.67:8000/category/mainbody/1/?page=$randomNumber',
        headers: {"Accept": "application/json"});
    setState(() {
      Map<String, dynamic> map = json.decode(response.body);
      data = map["results"];
      len = data.length;
    });
    return data;
  }

  wishlist(String token, int id) async {
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

  token() async {
    final prefs = await SharedPreferences.getInstance();
    stringValue = prefs.getString('token');
    print(stringValue);
  }

  List<bool> _isFavorited =
      List<bool>.generate(8, (_) => false); //add to wishlist logic

  var added = false;
  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    _controller.repeat(reverse: true);
    super.initState();
    this.getData();
    this.token();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: len == null ? 0 : len,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Card(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Image.network(
                        '${data[index]['Image_url']}',
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace stackTrace) {
                          return Text("Error");
                        },
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
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
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Text(
                            '${data[index]["name"]}',
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
                      child: _isFavorited[index]
                          ? ScaleTransition(
                              scale: _tween.animate(CurvedAnimation(
                                  parent: _controller,
                                  curve: Curves.elasticOut)),
                              child: IconButton(
                                iconSize: 20,
                                icon: Icon(Icons.favorite),
                                color: Colors.red,
                                onPressed: () async {
                                  var id = data[index]["id"];
                                  setState(() {
                                    _isFavorited[index] = !_isFavorited[index];
                                  });
                                  wishlist(stringValue, id);
                                },
                              ),
                            )
                          : IconButton(
                              iconSize: 30,
                              icon: Icon(Icons.favorite_border),
                              color: Colors.red,
                              onPressed: () async {
                                var id = data[index]["id"];
                                setState(() {
                                  _isFavorited[index] = !_isFavorited[index];
                                });
                                wishlist(stringValue, id);
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/*
class Listscroll extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 120,
            child: Card(
              borderOnForeground: true,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.orange,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "HYGIENICALLY PACKED,",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "SAFELY DELIVERED.",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
            width: 250,
            child: Divider(
              color: Colors.black,
            ),
          ),
          
        ],
      ),
    );
  }
}

class Imagesgrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/grid.jpg'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Positioned(
          bottom: 10.0,
          left: 0.0,
          right: 0.0,
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Text(
                  "Gucci T-Shirt",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
*/
