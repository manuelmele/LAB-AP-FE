import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';

import 'package:wefix/screens/payment/payment.dart';
import 'payment_content.dart';

import 'package:wefix/size_config.dart';
//import 'package:shop_app/components/no_account_text.dart';
//import 'package:shop_app/components/socal_card.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;

  //pageController lets us choose which page of the pageviwe to see
  final PageController _pageController = PageController();
  @override //non so a che serve l'ho preso dalle api di flutter
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

    List<Map<String, String>> plan = [
      {
        "title": "Monthly plan",
        "discount": " ",
        "cost": "\$x/month",
        "pay": "Subscribe with your Partita IVA\nCreate your virtual shop\nExpand your business\nCancel your subscription at any time"
      },
      {
        "title": "Yearly plan",
        "discount": "*5% discount on the monthly plan",
        "cost": "\$y/year",
        "pay": "Subscribe with your Partita IVA\nCreate your virtual shop\nExpand your business\nCancel your subscription at any time"
      },
    ];


  Widget build(BuildContext context) {
      return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(


          children: <Widget>[
            
            Image.asset(
              'assets/images/parrot_contrast.jpg',
              height: 70,
              width: 70,
            ),
            const SizedBox(height: 1),
            Text(
              "Choose your payment plan!",
              style: TextStyle(
                color: kOrange,
                fontSize: getProportionateScreenWidth(32),
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Subscribe and create your virtual shop to enjoy more benefits",
              textAlign: TextAlign.center,
              /*style: TextStyle(
                fontSize: 19,
              )*/
            ),
         

            SizedBox(height: getProportionateScreenWidth(60)),
            Expanded(
              //box with image and text
              flex: 15,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                
                itemCount: plan.length,
                itemBuilder: (context, index) => IntroContent(
                  title: plan[index]['title'],
                  discount: plan[index]['discount'],
                  cost: plan[index]['cost'],
                  pay: plan[index]['pay']
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    //Spacer(flex: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(0)),
                          child: Row(
                            children: List.generate(
                              plan.length,
                              (index) => buildDot(index: index),
                            ),
                          ),
                        ),
                      
                        SizedBox(height: getProportionateScreenWidth(0))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
    AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      //il primo valore di width indica quanto deve essere largo il dot evidenziato, 240 lo fa diventare una barra
      width: currentPage == index ? 200 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kLightOrange : kGrey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
