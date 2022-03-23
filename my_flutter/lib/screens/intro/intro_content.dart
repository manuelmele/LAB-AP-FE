import 'package:flutter/material.dart';
import 'package:wefix/size_config.dart';
import 'package:wefix/constants.dart';

class IntroContent extends StatelessWidget {
  const IntroContent({
    Key? key,
    this.title,
    this.text,
    this.image,
  }) : super(key: key);
  final String? title, text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title!,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(36),
              color: kOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            child: Image.asset(
              image!,
              height: getProportionateScreenHeight(400),
              width: getProportionateScreenWidth(400),
            ),
          ),
          Text(
            text!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(17),
            ),
          ),
        ]);
  }
}
