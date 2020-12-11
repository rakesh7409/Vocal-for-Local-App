import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:qr_ecommerce/products.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Categorybody(),
    );
  }
}

class Categorybody extends StatefulWidget {
  @override
  _CategorybodyState createState() => _CategorybodyState();
}

class _CategorybodyState extends State<Categorybody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "We Show you a comparison between everything Indian and non-Indian",
                      style: TextStyle(
                          color: Colors.grey[850],
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
              width: 350,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Carduse(),
          ],
        ),
      ),
    );
  }
}

class Carduse extends StatefulWidget {
  @override
  _CarduseState createState() => _CarduseState();
}

class _CarduseState extends State<Carduse> {
  List data, subdata, prodata, confirm;
  var indexedp = 0;
  var value, id = 0, sub = 0, confirmed = 0;

  Future<List> getData() async {
    var response = await http.get('http://3.132.212.67:8000/category/only',
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    return data;
  }

  Future<List> subcat(int id) async {
    List subdata;
    var response = await http.get('http://3.132.212.67:8000/category/sub/$id',
        headers: {"Accept": "application/json"});
    subdata = await json.decode(response.body);
    return subdata;
  }

  Future<List> product(int sub) async {
    List prodata;
    var response = await http.get(
        'http://3.132.212.67:8000/category/product/$sub',
        headers: {"Accept": "application/json"});
    prodata = await json.decode(response.body);
    return prodata;
  }

  @override
  void initState() {
    this.getData();
    this.subcat(id);
    this.product(sub);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    indexedp = indexedp + 1;
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Color.fromARGB(255, 2, 130, 121),
          semanticContainer: false,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 75,
                  child: Center(
                    child: ListTile(
                      enabled: true,
                      title: Text(
                        '${data[index]["category_name"]}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontStyle: FontStyle.italic),
                      ),
                      trailing: Image(
                        image: AssetImage('images/$index.png'),
                        height: 100,
                        width: 100,
                      ),
                      onTap: () async {
                        id = data[index]["id"];
                        List tedt;
                        tedt = await subcat(id);
                        if (tedt.isEmpty) {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 200,
                                color: Colors.amber,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Comparison Not Available'),
                                      Text('We are adding up!'),
                                      RaisedButton(
                                        child: const Text(
                                            'Compare other products'),
                                        onPressed: () => Navigator.pop(context),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          showModalBottomSheet<void>(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              backgroundColor: Color.fromRGBO(2, 130, 121, 0.7),
                              context: context,
                              builder: (BuildContext context) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            child: ListView.builder(
                                                itemCount: tedt == null
                                                    ? 0
                                                    : tedt.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Card(
                                                    elevation: 7,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(8.0),
                                                      ),
                                                    ),
                                                    margin: EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                    child: ListTile(
                                                      title: Text(
                                                        '${tedt[index]["subcategory_name"]}',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      trailing: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Color.fromARGB(
                                                            255, 255, 145, 77),
                                                      ),
                                                      onTap: () async {
                                                        sub = tedt[index]["id"];

                                                        List productlist;
                                                        productlist =
                                                            await product(sub);
                                                        Navigator.pop(context);
                                                        if (productlist
                                                            .isEmpty) {
                                                          showModalBottomSheet<
                                                              void>(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Container(
                                                                height: 200,
                                                                color: Colors
                                                                    .amber,
                                                                child: Center(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                          'Comparison Not Available'),
                                                                      Text(
                                                                          'We are adding up!'),
                                                                      RaisedButton(
                                                                        child: const Text(
                                                                            'Compare other products'),
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.pop(context),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        } else {
                                                          showModalBottomSheet<
                                                                  void>(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          20.0),
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  Color
                                                                      .fromRGBO(
                                                                          2,
                                                                          130,
                                                                          121,
                                                                          0.7),
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child:
                                                                      Container(
                                                                          child:
                                                                              ListView.builder(
                                                                    itemCount: productlist ==
                                                                            null
                                                                        ? 0
                                                                        : productlist
                                                                            .length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      return Container(
                                                                        child:
                                                                            Card(
                                                                          elevation:
                                                                              7,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                const BorderRadius.all(
                                                                              Radius.circular(8.0),
                                                                            ),
                                                                          ),
                                                                          margin: EdgeInsets.fromLTRB(
                                                                              10,
                                                                              10,
                                                                              10,
                                                                              10),
                                                                          child:
                                                                              ListTile(
                                                                            title:
                                                                                Text(
                                                                              '${productlist[index]["product_name"]}',
                                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontStyle: FontStyle.italic),
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                            trailing:
                                                                                Icon(
                                                                              Icons.arrow_forward,
                                                                              color: Color.fromARGB(255, 255, 145, 77),
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              String proname = productlist[index]["product_name"];
                                                                              int productid = productlist[index]["id"];
                                                                              Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: (context) => Products(
                                                                                          texty: proname,
                                                                                          productid: productid,
                                                                                        )),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  )),
                                                                );
                                                              });
                                                        }
                                                      },
                                                    ),
                                                  );
                                                }),
                                          )),
                                    ),
                                  ),
                                );
                              });
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/*
Card(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        color: Colors.pink[50],
ListTile(
          title: ExpansionTile(
            title: Text(
              '${data[indexedp]["Categories"]}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontStyle: FontStyle.italic),
            ),
            subtitle: Text("Staples,Household Care .."),
            children: <Widget>[
              ListTile(
                title: Text('Staples'),
              ),
              ListTile(
                title: Text('Household Care'),
              ),
              ListTile(
                title: Text('Dairy'),
              ),
              ExpansionTile(
                title: Text('Personal Care'),
                children: <Widget>[
                  ListTile(
                    title: Text('Toothbrush'),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Products()),
                        );
                      });
                    },
                  ),
                ],
              ),
            ],
            trailing: Image(
              image: AssetImage("images/Groceries-Transparent-Images-PNG.png"),
            ),
          ),
        ),

*/
