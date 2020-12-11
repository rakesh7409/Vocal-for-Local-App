import 'dart:async';
import 'package:flutter/material.dart';
import 'login.dart';
import 'mainpage.dart';
/*import 'package:qr_ecommerce/login.dart';
import 'mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
*/
import 'submit.dart';

void main() => runApp(new MaterialApp(
      home: new SplashScreen(),
    ));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String name = "";
  bool checkif;
  @override
  void didChangeDependencies() {
    getPref('username').then(_updateName);
    super.didChangeDependencies();
  }

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    name == null
        ? Navigator.push(
            context, new MaterialPageRoute(builder: (context) => Loginform()))
        : Navigator.pushReplacement(
            context,
            new MaterialPageRoute(builder: (context) => MainPage()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Card(
                    elevation: 10,
                    child: new Image.asset('images/landing.jpg'))),
          ],
        ),
      ),
    );
  }

  void _updateName(String name) {
    setState(() {
      this.name = name;
    });
  }
}

/*
child : GridView.count(
        padding: const EdgeInsets.all(20.0),
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: <Widget>[
          Container(
            height: 20,
            color: Colors.amber[600],
            child: const Center(
            child: Text('Entry A')),
          ),
          Container(
            height: 50,
            color: Colors.amber[600],
            child: const Center(child: Text('Entry A')),
          ),
          Container(
            height: 50,
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child: const Center(child: Text('Entry C')),
          ),
          Container(
            height: 50,
            color: Colors.amber[600],
            child: const Center(child: Text('Entry A')),
          ),
          Container(
            height: 50,
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child: const Center(child: Text('Entry C')),
          ),
        ],
      ),
      void main() async {
  // Set default home.
  Widget _defaultHome = new LoginPage();

  // Get result of the login function.
  bool _result = await appAuth.login();
  if (_result) {
    _defaultHome = new HomePage();
  }

  // Run app!
  runApp(new MaterialApp(
    title: 'App',
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new HomePage(),
      '/login': (BuildContext context) => new LoginPage()
    },
  ));
}



      import 'package:flutter/material.dart';
import 'package:qr_ecommerce/alert.dart';
import 'package:qr_ecommerce/mainpage.dart';
import 'submit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'alert.dart';

class Loginform extends StatefulWidget {
  @override
  _LoginformState createState() => _LoginformState();
}

class _LoginformState extends State<Loginform> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: const DecorationImage(
                  image: AssetImage('images/flag.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              child: Loginforms(),
            ),
          ],
        ),
      ),
    );
  }
}

class Loginforms extends StatefulWidget {
  @override
  _LoginformsState createState() => _LoginformsState();
}

class _LoginformsState extends State<Loginforms> {
  bool alreadySaved = true, isLoading = false, dialog = false;
  String confirm;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: ListTile(
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
                  border: InputBorder.none,
                  hintText: 'Username',
                  prefixIcon: Icon(Icons.verified_user),
                ),
                controller: emailController,
              ),
            ),
          ),
          Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: TextFormField(
                      validator: (value) {
                        if (value.length < 6) {
                          return 'Required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.vpn_key),
                      ),
                      controller: passController,
                      obscureText: alreadySaved,
                    ),
                    trailing: new Icon(
                      alreadySaved ? Icons.visibility_off : Icons.visibility,
                    ),
                    onTap: () {
                      // Add 9 lines from here...
                      setState(() {
                        if (!alreadySaved) {
                          alreadySaved = true;
                        } else {
                          alreadySaved = false;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          FlatButton(
            color: Colors.white,
            textColor: Colors.black,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            splashColor: Colors.blueAccent,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                var email = emailController.text;
                var pass = passController.text;
                var rsp = await postRequest(email, pass);
                print(rsp);
                if (rsp == 200) {
                  Position position = await Geolocator().getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString('username', email);
                  print(position);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                } else {
                  setState(() {
                    showAlertDialog(context);
                  });
                }
              }
            },
            child: Text("Login"),
          ),
          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}

      */
