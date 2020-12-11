import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> with TickerProviderStateMixin {
  String stringValue;
  int len;
  var map;
  String messwish;
  AnimationController _controller;
  Tween<double> _tween = Tween(begin: 0.75, end: 2);
  Map<String, dynamic> message;
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
    setState(() {
      message = json.decode(response.body);
    });
    map = message;
    print(map);
    len = map.length;
    return map;
  }

  Future<String> wishlist(String token, int id) async {
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

  List<bool> _isFavorited = List<bool>.generate(8, (_) => true);
  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    _controller.repeat(reverse: true);
    this.favourite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: map == null ? 0 : len,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Card(
                elevation: 15,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          '${map[index]["main_product"]["Image_url"]}'),
                      alignment: Alignment.center,
                      onError: (exception, stackTrace) => exception,
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
                      child: ScaleTransition(
                        scale: _tween.animate(CurvedAnimation(
                            parent: _controller, curve: Curves.elasticOut)),
                        child: IconButton(
                          iconSize: 20,
                          icon: Icon(Icons.favorite, color: Colors.red),
                          onPressed: () async {
                            var id = map[index]["main_product"]["id"];
                            setState(() {
                              _isFavorited[index] = !_isFavorited[index];
                              wishlist(stringValue, id);
                            });
                            favourite();
                          },
                        ),
                      ))),
            ],
          );
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
