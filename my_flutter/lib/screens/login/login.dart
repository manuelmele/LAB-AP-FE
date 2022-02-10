import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';
import 'body.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "/login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //title: Text("Login"),
      //),
      backgroundColor: kBackground,
      body: Body(),
    );
  }
}
