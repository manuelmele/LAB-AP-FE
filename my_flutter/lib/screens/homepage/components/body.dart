import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'home_header.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(40)),
        Text(
          "Select category:",
          style: TextStyle(
              fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Categories(),
        SizedBox(height: getProportionateScreenWidth(30)),
      ],
    );
  }
}
