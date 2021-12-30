import 'package:flutter/material.dart';
//import 'package:shop_app/components/no_account_text.dart';
//import 'package:shop_app/components/socal_card.dart';
import '../../../size_config.dart';
import 'login_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(30),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 0.04),
                Text(
                  "Welcome!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in with your email and password",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                LoginForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),

                SizedBox(height: getProportionateScreenHeight(20)),
                //NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
