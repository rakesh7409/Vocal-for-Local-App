import 'dart:convert';
// ignore: unused_import
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Searchitem extends StatefulWidget {
  final String searchitem;
  Searchitem({Key key, @required this.searchitem}) : super(key: key);
  @override
  _SearchitemState createState() => _SearchitemState(searchitem: searchitem);
}

class _SearchitemState extends State<Searchitem> {
  final String searchitem;
  _SearchitemState({this.searchitem});
  List<dynamic> data;
  var len = 0;
  var map;
  bool errorsearch = true;
  Future<List> search() async {
    String url = 'http://3.132.212.67:8000/category/search/';
    http.Response response = await http.post(url,
        headers: {"Accept": "Application/json"}, body: {'search': searchitem});
    setState(() {
      map = json.decode(response.body);
    });
    if (map == 'No results found') {
      errorsearch = false;
    } else {
      data = map;
      len = data.length;
    }

    return data;
  }

  @override
  void initState() {
    this.search();
    super.initState();
  }

  Widget imagePro;
  @override
  Widget build(BuildContext context) {
    return errorsearch == false
        ? Center(
            child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("No Results found"),
                Text("Possible Errors"),
                Text("Try changing first letter to captial or vice versa"),
              ],
            ),
          ))
        : GridView.builder(
            itemCount: len == 0 ? 0 : len,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: imagePro = Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Card(
                          child: Image.network(
                            '${data[index]['Image_url']}',
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
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
                    ],
                  ),
                  onTap: () {
                    var category, product;
                    var iorf;
                    // ignore: unused_local_variable
                    var check = data[index]["product_country"] == "1"
                        ? iorf = "Indian"
                        : iorf = "Foreign";
                    if (data[index]["product_id"] != null) {
                      category = data[index]["product_id"]["category_id"]
                          ["category_name"];
                      product = data[index]["product_id"]["subcategory_id"]
                          ["subcategory_name"];
                    } else {
                      category = "Not Found";
                      product = "Not Found";
                    }

                    showModalBottomSheet<void>(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      context: context,
                      builder: (BuildContext context) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  height: 150,
                                  width: 150,
                                  child: Image.network(
                                    '${data[index]['Image_url']}',
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
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
                                Text("Origin :$iorf"),
                                Text("Subcategory :$product"),
                                Text("Category :$category"),
                                RaisedButton(
                                  child: const Text('Explore More'),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            });
  }
}
