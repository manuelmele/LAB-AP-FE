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
        SizedBox(height: getProportionateScreenHeight(80)),
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
        ElevatedButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('jwt');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext ctx) => LoginScreen()));
          },
          child: Text('Logout'),
        ),
        //SizedBox(height: getProportionateScreenHeight(20)),
        Categories(),
        //SizedBox(height: getProportionateScreenWidth(30)),
      ],
    );
  }
}
