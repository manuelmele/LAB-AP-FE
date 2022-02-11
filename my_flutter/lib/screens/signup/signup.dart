import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';

import 'body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/signup";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Body(),
    );
  }
}
