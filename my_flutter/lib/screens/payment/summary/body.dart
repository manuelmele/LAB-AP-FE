import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/screens/payment/body.dart';
import 'package:wefix/screens/payment/payment.dart';
import 'summary_content.dart';
import 'package:intl/intl.dart';

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
  int? plan;
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

  void getPlan() {
      SharedPreferences.getInstance().then((m) {
      plan=m.getInt('plan')!;
    });
  }


  @override
  Widget build(BuildContext context) {
    getUserData();
    getPlan();
    print(plan);

    //calculate the current date and set the format
    final today = DateTime.now();
    final DateFormat dateFormater = DateFormat('yyyy-MM-dd');
    //get the dates after one month and one year
    final aMonthFromNow = dateFormater.format(today.add(const Duration(days: 31)));
    final aYearFromNow = dateFormater.format(today.add(const Duration(days: 365)));

      return SafeArea(
         child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              decoration: BoxDecoration(
              color: kLightBlue,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(200.0), //60
                bottomLeft: Radius.circular(0.0), //60
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
            Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Row(
              children: <Widget>[
            Text(
              "Choosen payment plan: ",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: kOrange,
                fontSize: getProportionateScreenWidth(23),
                fontWeight: FontWeight.bold,
              ),
            ),
            RichText(
                text: TextSpan(
                  text: plan==0 ? "Montly plan" : "Yearly plan",
                  style: TextStyle(
                    color: kOrange,
                    fontSize: getProportionateScreenWidth(18),
                    fontFamily: 'Ubuntu', 
                  ),
                ),
            )]),            
            Row(
              children: <Widget>[
            Text(
              "Subscription expiration: " ,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: kOrange,
                fontSize: getProportionateScreenWidth(23),
                fontWeight: FontWeight.bold,
                //fontFamily: 'Outfit', 
                
              )
            ),
            RichText(
                text: TextSpan(
                  text: plan==0 ? aMonthFromNow : aYearFromNow,
                  style: TextStyle(
                    color: kOrange,
                    fontSize: getProportionateScreenWidth(18),
                    fontFamily: 'Ubuntu', 
                  ),
                ),
            )]),

            Row(
              children: <Widget>[
            Text(
              "Total cost: ",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: kOrange,
                    fontSize: getProportionateScreenWidth(23),
                    fontWeight: FontWeight.bold,
                    //fontFamily: 'Outfit', 
              )
            ),  
            RichText(
                text: TextSpan(
                  text: plan==0 ? "\$x" : "\$y",
                  style: TextStyle(
                    color: kOrange,
                    fontSize: getProportionateScreenWidth(18),
                    fontFamily: 'Ubuntu', 
                  ),
                ),
            )]),             
              ]),      

              
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kLightBlue,
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
