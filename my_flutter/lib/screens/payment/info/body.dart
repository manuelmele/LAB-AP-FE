import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';
//import 'package:shop_app/components/no_account_text.dart';
//import 'package:shop_app/components/socal_card.dart';
import '../../../size_config.dart';
import 'info_form.dart';

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
                Image.asset(
                  'assets/images/parrot_contrast.jpg',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 0.04),
                Text(
                  "Enter your data before proceeding",
                  style: TextStyle(
                    color: kOrange,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const Text(
                  "Upgrade to PRO by selecting your work's category, entering your partita IVA and confirming your email and password",

                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                InfoForm(),
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
