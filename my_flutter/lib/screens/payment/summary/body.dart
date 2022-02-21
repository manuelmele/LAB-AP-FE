import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/screens/payment/body.dart';
import 'package:wefix/screens/payment/payment.dart';
import 'summary_content.dart';

import 'package:wefix/size_config.dart';
//import 'package:shop_app/components/no_account_text.dart';
//import 'package:shop_app/components/socal_card.dart';
import '../../../size_config.dart';
import 'dart:convert';
import 'package:wefix/models/user_model.dart';
import 'package:wefix/services/user_service.dart';


class Summary extends StatefulWidget {
  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {

  String? jwt;
  var role;
  var data;
  UserModel? userData;
  bool initialResults = false;

  String? oldPassword;
  String? newPassword;
  bool _oldPasswordVisible = false;
  bool _newPasswordVisible = false;
  List<String?> errors = [];


  //CODICE PRESO DA MANUEL
  void getUserData() {
    //search by category just the first time
    if (initialResults) return;

    SharedPreferences.getInstance().then((prefs) {
      String jwt = prefs.getString('jwt')!;
      getUserDataService(jwt).then((newResults) {
        setState(() {
          userData = newResults;
          initialResults = true;
          print(userData);
        });
      });
    });
  }

  Future getPlan() {
      return SharedPreferences.getInstance().then((m) {
      int plan=m.getInt('plan')!;
    });
  }


  @override
  Widget build(BuildContext context) {
    getUserData();
    
      return SafeArea(
         child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              decoration: BoxDecoration(
              color: kLightOrange,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(60.0),
                bottomLeft: Radius.circular(60.0),
              )),

              child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(30),
                    ),
                  child: Column(
                    children: [
                      Text("Summary of your payment plan!",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(27),
                          fontWeight: FontWeight.bold,
                          //color: kOrange,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20),
                          vertical: getProportionateScreenHeight(30),
                        ),
                      ),
                      CircleAvatar(
                        backgroundImage: userData == null ? null : Image.memory(base64Decode(userData!.photoProfile)).image,
                        radius: getProportionateScreenHeight(60),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Text(userData == null ? "" : userData!.firstName + " " + userData!.secondName,
                        style: TextStyle(
                          fontSize: 18,
                          //color: kOrange,
                        ),
                      ),
                    ]),
                  ),  
              ),
            ),
            const SizedBox(height: 20),
            Text(
              getPlan()==0 ? "Choosen payment plan: Montly plan" : "Choosen payment plan: Yearly plan" ,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: kOrange,
                fontSize: getProportionateScreenWidth(25),
              ),
            ),
            const Text(
              "Subscription expiration:",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: kOrange,
                fontSize: 25,
              )
            ),

            const Text(
              "Total:",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: kOrange,
                fontSize: 25,
              )
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
                child: const Text('Proceed to PayPal',
                  style: TextStyle(
                    //color: kOrange,
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, PaymentPage.routeName);
                }
              ),
            ),
          ]),
      );
         

 
  }
}
