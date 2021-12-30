import 'package:flutter/material.dart';

import 'body.dart';

class SignUpOptionalScreen extends StatelessWidget {
  static String routeName = "/signup_optional";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Body(),
    );
  }
}
