import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';
import 'body.dart';

class InfoPage extends StatelessWidget {
  static String routeName = "/info";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Body(),
    );
  }
}
