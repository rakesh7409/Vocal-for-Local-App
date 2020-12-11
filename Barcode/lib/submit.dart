import 'dart:convert';

import 'package:http/http.dart' as http;
// ignore: unused_import
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> postRequest(String email, String pass) async {
  List data;
  String url = 'http://3.132.212.67:8000/login/';
  final response = await http.post(url,
      headers: {"Accept": "Application/json"},
      body: {'password': pass, 'username': email});
  Map<String, dynamic> map = json.decode(response.body);
  if (map.containsKey('non_field_errors')) {
    data = map['non_field_errors'];
    data.add(response.statusCode);
  } else {
    String data = map['auth_token'];

    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", data);
  }
  int statusCode = response.statusCode;
  return statusCode;
}

Future<dynamic> postsignupRequest(
    String email, String username, String pass) async {
  String url = 'http://3.132.212.67:8000/login/auth/users/';
  http.Response response = await http.post(url,
      headers: {"Accept": "Application/json"},
      body: {'email': username, "username": email, "password": pass});
  // ignore: unused_local_variable
  Map<String, dynamic> map = json.decode(response.body);

  int statusCode = response.statusCode;
  return statusCode;
}

Future logout() async {
  final prefs = await SharedPreferences.getInstance();
  // ignore: unused_local_variable
  String stringValue = prefs.getString('token');
  prefs.remove('username');
  prefs.remove('token');
  return "done";
}

Future<String> getPref(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final String name = prefs.getString(key);
  return name;
}
