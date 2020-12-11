import 'package:flutter/material.dart';
import 'alert.dart';
import 'mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'submit.dart';
import 'package:geolocator/geolocator.dart';

//import 'alert.dart';
class Loginform extends StatefulWidget {
  @override
  _LoginformState createState() => _LoginformState();
}

class _LoginformState extends State<Loginform> {
  bool alreadySaved = true, isLoading = false, dialog = false;
  String confirm;
  bool circle = false;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final userController = TextEditingController();
  bool signup = false;
  final _formKey = GlobalKey<FormState>();
  GlobalKey _scaffold = GlobalKey();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passController.dispose();
    userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 2, 130, 121),
            ),
          ),
          circle == true
              ? Center(child: CircularProgressIndicator())
              : Form(
                  key: _formKey,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "Hey!",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "We missed you!",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                width: 250,
                                child: Divider(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SingleChildScrollView(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Card(
                                elevation: 10,
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 30),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 20, 0, 20),
                                    child: signup == false
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              ListTile(
                                                title: TextFormField(
                                                  validator: (value) {
                                                    if (value.length < 1) {
                                                      return 'Please enter valid enail address';
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: 'Username',
                                                    prefixIcon: Icon(
                                                        Icons.verified_user),
                                                  ),
                                                  controller: emailController,
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: ListTile(
                                                      title: TextFormField(
                                                        validator: (value) {
                                                          if (value.length <
                                                              6) {
                                                            return 'Required';
                                                          }
                                                          return null;
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: 'Password',
                                                          prefixIcon: Icon(
                                                              Icons.vpn_key),
                                                        ),
                                                        controller:
                                                            passController,
                                                        obscureText:
                                                            alreadySaved,
                                                      ),
                                                      trailing: new Icon(
                                                        alreadySaved
                                                            ? Icons
                                                                .visibility_off
                                                            : Icons.visibility,
                                                      ),
                                                      onTap: () {
                                                        // Add 9 lines from here...
                                                        setState(() {
                                                          if (!alreadySaved) {
                                                            alreadySaved = true;
                                                          } else {
                                                            alreadySaved =
                                                                false;
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              RaisedButton(
                                                elevation: 7,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                color: Color.fromARGB(
                                                    255, 255, 145, 77),
                                                textColor: Colors.white,
                                                disabledColor: Colors.grey,
                                                disabledTextColor: Colors.black,
                                                splashColor: Colors.blueAccent,
                                                onPressed: () async {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    var email =
                                                        emailController.text;
                                                    var pass =
                                                        passController.text;
                                                    setState(() {
                                                      circle = true;
                                                    });
                                                    var rsp = await postRequest(
                                                        email, pass);

                                                    setState(() {
                                                      circle = false;
                                                    });
                                                    if (rsp == 200) {
                                                      // ignore: unused_local_variable
                                                      Position position =
                                                          await Geolocator()
                                                              .getCurrentPosition(
                                                                  desiredAccuracy:
                                                                      LocationAccuracy
                                                                          .high);
                                                      final prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      prefs.setString(
                                                          "username", email);
                                                      Navigator.pushAndRemoveUntil(
                                                          context,
                                                          new MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      MainPage()),
                                                          (_) => false);
                                                    } else {
                                                      showAlertDialog(context);
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                    height: 30,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text("Login"),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 20,
                                                child: Text("Or"),
                                              ),
                                              RaisedButton(
                                                elevation: 7,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                color: Color.fromARGB(
                                                    255, 255, 145, 77),
                                                textColor: Colors.white,
                                                disabledColor: Colors.grey,
                                                disabledTextColor: Colors.black,
                                                splashColor: Colors.blueAccent,
                                                onPressed: () {
                                                  setState(() {
                                                    signup = true;
                                                  });
                                                },
                                                child: Container(
                                                    height: 30,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text("Sign Up"),
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              ListTile(
                                                title: TextFormField(
                                                  validator: (value) {
                                                    if (!RegExp(
                                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                        .hasMatch(value)) {
                                                      return 'Please enter valid enail address';
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: 'Email',
                                                    prefixIcon:
                                                        Icon(Icons.email),
                                                  ),
                                                  controller: userController,
                                                ),
                                              ),
                                              ListTile(
                                                title: TextFormField(
                                                  validator: (value) {
                                                    if (value.length < 1) {
                                                      return 'Please enter valid username';
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: 'Username',
                                                    prefixIcon: Icon(
                                                        Icons.verified_user),
                                                  ),
                                                  controller: emailController,
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: ListTile(
                                                      title: TextFormField(
                                                        validator: (value) {
                                                          if (value.length <
                                                              6) {
                                                            return 'Required';
                                                          }
                                                          return null;
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: 'Password',
                                                          prefixIcon: Icon(
                                                              Icons.vpn_key),
                                                        ),
                                                        controller:
                                                            passController,
                                                        obscureText:
                                                            alreadySaved,
                                                      ),
                                                      trailing: new Icon(
                                                        alreadySaved
                                                            ? Icons
                                                                .visibility_off
                                                            : Icons.visibility,
                                                      ),
                                                      onTap: () {
                                                        // Add 9 lines from here...
                                                        setState(() {
                                                          if (!alreadySaved) {
                                                            alreadySaved = true;
                                                          } else {
                                                            alreadySaved =
                                                                false;
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              RaisedButton(
                                                elevation: 7,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                color: Color.fromARGB(
                                                    255, 255, 145, 77),
                                                textColor: Colors.white,
                                                disabledColor: Colors.grey,
                                                disabledTextColor: Colors.black,
                                                splashColor: Colors.blueAccent,
                                                onPressed: () async {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    var username =
                                                        emailController.text;
                                                    var pass =
                                                        passController.text;
                                                    var email =
                                                        userController.text;
                                                    setState(() {
                                                      circle = true;
                                                    });
                                                    var rsp =
                                                        await postsignupRequest(
                                                            username,
                                                            email,
                                                            pass);

                                                    if (rsp == 201) {
                                                      setState(() {
                                                        circle = false;
                                                        signup = false;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        circle = false;
                                                      });
                                                      showAlertDialog(context);
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                    height: 30,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text("Sign Up"),
                                                      ],
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 20,
                                                child: Text("Or"),
                                              ),
                                              RaisedButton(
                                                elevation: 7,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                color: Color.fromARGB(
                                                    255, 255, 145, 77),
                                                textColor: Colors.white,
                                                disabledColor: Colors.grey,
                                                disabledTextColor: Colors.black,
                                                splashColor: Colors.blueAccent,
                                                onPressed: () {
                                                  setState(() {
                                                    signup = false;
                                                  });
                                                },
                                                child: Container(
                                                    height: 30,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text("Login"),
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
