import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';

import 'body.dart';

class SignUpOptionalScreen extends StatelessWidget {
  static String routeName = "/signup_optional";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Body(),
    );
  }
}
