import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';
import 'body.dart';

/*import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/screens/intro/intro.dart';
import 'package:wefix/screens/navigator/navigator.dart';
import 'package:wefix/screens/signup/signup.dart';
import 'package:wefix/services/auth_service.dart'; */

class SubscriptionPage extends StatelessWidget {
  static String routeName = "/subscription";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Subscription(),
    );
  }
}
