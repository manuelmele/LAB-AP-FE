import 'package:flutter/material.dart';
import '/../constants.dart';
import 'package:wefix/size_config.dart';

import 'signup_form_optional.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Image.asset(
                  'assets/images/parrot_contrast.jpg',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 0.04),
                Text(
                  "Sign up",
                  style: TextStyle(
                    color: kOrange,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const Text(
                  "Complete your profile",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignUpFormOptional(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  'By continuing your confirm that you agree \nwith our Term and Condition',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
