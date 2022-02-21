import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wefix/screens/payment/payment.dart';
import 'payment_content.dart';

import 'package:wefix/size_config.dart';
//import 'package:shop_app/components/no_account_text.dart';
//import 'package:shop_app/components/socal_card.dart';
import '../../../size_config.dart';


class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
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
        "image": "assets/images/card.jpeg",
        "pay": "\u{2713}  Subscribe with your Partita IVA\n\u{2713}  Create your virtual shop\n\u{2713}  Expand your business\n\u{2713}  100% secure payments with PayPal\n\u{2713}  Cancel your subscription at any time"
      },
      {
        "title": "Yearly plan",
        "discount": "*5% discount on the monthly plan",
        "cost": "\$y/year",
        "image": "assets/images/card.jpeg",
        "pay": "\u{2713}  Subscribe with your Partita IVA\n\u{2713}  Create your virtual shop\n\u{2713}  Expand your business\n\u{2713}  100% secure payments with PayPal\n\u{2713}  Cancel your subscription at any time"
      },
    ];


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
              "Choose your payment plan!",
              style: TextStyle(
                color: kOrange,
                fontSize: getProportionateScreenWidth(32),
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Subscribe to enjoy more benefits",
              textAlign: TextAlign.center,
              /*style: TextStyle(
                fontSize: 19,
              )*/
            ),
         

            SizedBox(height: getProportionateScreenWidth(47)),
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
                  image: plan[index]['image'],
                  pay: plan[index]['pay']
                ),
              ),
            ),
            Expanded(
              flex:3,
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

                      
                        SizedBox(height: getProportionateScreenWidth(27))
                      ],
                    ),
       
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: kLightOrange,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text('Get started'),
                        onPressed: () {
                            Navigator.pushReplacementNamed(context, PaymentPage.routeName);
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
      width: currentPage == index ? 6 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kLightOrange : kGrey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
