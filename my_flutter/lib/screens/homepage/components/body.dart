import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/screens/login/login.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'home_header.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(30)),
        Text(
          "What do you need?",
          style: TextStyle(
            color: kOrange,
            fontSize: getProportionateScreenWidth(28),
            fontWeight: FontWeight.normal,
          ),
        ),
        const Text(
          "Start your search by choosing the category",
          textAlign: TextAlign.center,
        ),
        Categories(),
      ],
    );
  }
}
