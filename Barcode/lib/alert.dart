import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) async {
  // Create button
  Widget okButton = FlatButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    color: Color.fromARGB(255, 255, 145, 77),
    child: Text(
      "Try Again!",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.grey[100],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    title: Text(
      "Wrong Credentials",
      style: TextStyle(color: Colors.black),
      textAlign: TextAlign.center,
    ),
    content: Image(
      image: AssetImage("images/wrong.png"),
      height: 100,
      width: 100,
    ),
    actions: [
      Container(
        child: okButton,
      ),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          alert,
        ],
      );
    },
  );
}
