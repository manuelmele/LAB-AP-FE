import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';
import 'body.dart';

/*import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/screens/intro/intro.dart';
import 'package:wefix/screens/navigator/navigator.dart';
import 'package:wefix/screens/signup/signup.dart';
import 'package:wefix/services/auth_service.dart'; */


class SummaryPage extends StatelessWidget {
  static String routeName = "/summary";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Summary(),
    );
  }
}