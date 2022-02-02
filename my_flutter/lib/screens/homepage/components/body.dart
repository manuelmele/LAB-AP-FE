import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'home_header.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(20)),
        HomeHeader(),
        SizedBox(height: getProportionateScreenWidth(10)),
        Categories(),
        SizedBox(height: getProportionateScreenWidth(30)),
      ],
    );
  }
}
