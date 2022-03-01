import 'package:flutter/material.dart';
import 'package:wefix/screens/navigator/navigator.dart';
import '/../constants.dart';
import 'package:wefix/size_config.dart';

class PaymentFailedScreen extends StatelessWidget {
  static String routeName = "/failedPayment";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
              Image.asset(
                'assets/images/parrot_contrast.jpg',
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 0.04),
              Text(
                "FAILED PAYMENT",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kOrange,
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),

              SizedBox(height: getProportionateScreenHeight(30)),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kLightOrange,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, NavigatorScreen.routeName);
                  },
                  child: const Text("OK"))
            ],
          ),
        ),
      ),
    );
  }
}
