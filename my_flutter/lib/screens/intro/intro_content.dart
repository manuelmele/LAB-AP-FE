import 'package:flutter/material.dart';

class IntroContent extends StatelessWidget {
  const IntroContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "WEFIX",
          style: TextStyle(
            //fontSize: getProportionateScreenWidth(36),
            //color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        Image.asset(
          image!,
          //height: getProportionateScreenHeight(265),
          //width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
