import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => Twittermain(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => Second(),
      },
    ),
  );
}

class Twittermain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome',
                  style: TextStyle(
                      fontFamily: 'Halvetica',
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Select your interests',
                  style: TextStyle(
                      fontFamily: 'Halvetica',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 4.0, // gap between lines
                    children: <Widget>[
                      Chip(
                        backgroundColor: Colors.white,
                        label: Text('Celebrity'),
                        avatar: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Chip(
                        backgroundColor: Colors.white,
                        avatar: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.blue,
                          ),
                        ),
                        label: Text('Nature'),
                      ),
                      Chip(
                        backgroundColor: Colors.white,
                        avatar: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.blue,
                          ),
                        ),
                        label: Text('Science and Technology'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 300,
              height: 10,
              child: Divider(color: Colors.teal[100]),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 4.0, // gap between lines
                    children: <Widget>[
                      Chip(
                        backgroundColor: Colors.white,
                        avatar: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                        label: Text('Wildlife'),
                      ),
                      Chip(
                        backgroundColor: Colors.white,
                        avatar: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                        label: Text('Photography'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  color: Colors.white,
                  textColor: Colors.black,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(12.0),
                  splashColor: Colors.red,
                  onPressed: () {
                    Navigator.pushNamed(context, '/second');
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.favorite_border,
                        color: Colors.blue,
                      ),
                      Text(
                        "Proceed",
                        style: TextStyle(fontFamily: 'he', fontSize: 15.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.amber,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Hello Welcome",
              style: TextStyle(
                backgroundColor: Colors.amber,
                color: Colors.white,
                fontFamily: 'Helvetica',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
