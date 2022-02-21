import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wefix/screens/payment/payment.dart';
import 'subscription_content.dart';

import 'package:wefix/size_config.dart';
//import 'package:shop_app/components/no_account_text.dart';
//import 'package:shop_app/components/socal_card.dart';
import '../../../size_config.dart';

class Subscription extends StatefulWidget {
  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  int currentPage = 0;

  //pageController lets us choose which page of the pageviwe to see
  final PageController _pageController = PageController();
  @override //non so a che serve l'ho preso dalle api di flutter
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(30),
          ),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/parrot_contrast.jpg',
                height: 70,
                width: 70,
              ),
              const SizedBox(height: 1),
              Text(
                "Your Subscription",
                style: TextStyle(
                  color: kOrange,
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.normal,
                ),
              ),
              const Text(
                "Manage your payments and subscription",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getProportionateScreenWidth(60)),
              Container(
                //box with image and text
                child: SubscriptionContent(
                  state: "State: " + "Active",
                  plan: "Monthly Plan",
                  cost: "5/month",
                  expiration: "Expiration date: " + "21/03/22",
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(30)),
              Align(
                alignment: Alignment.topCenter,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kLightOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text('Renew Subscription'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext ctx) => PaymentPage()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
