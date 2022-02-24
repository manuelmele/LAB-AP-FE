import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/screens/navigator/navigator.dart';
import 'package:wefix/screens/payment/confirmation/failed.dart';
import 'package:wefix/services/auth_service.dart';
import '/../constants.dart';
import 'package:wefix/size_config.dart';
import 'package:http/http.dart' as http;

class PaymentSuccessScreen extends StatelessWidget {
  static String routeName = "/successPayment";

  Future<String> successPaypal() async {
    print("inizio successPaypal");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString('paypalUrl');
    String? jwt = prefs.getString('jwt');
    print(url);
    var regexPaymentID = RegExp(r'(?<=paymentId=)(.*)(?=&token)');
    var regexPayerID = RegExp(r'(?<=PayerID=)(.*)');
    String? _paymentID = regexPaymentID.stringMatch(url!);
    String? _payerID = regexPayerID.stringMatch(url);
    print("mo stampo le sottostringhe");
    print(_payerID);
    print(_paymentID);
    final queryParameters = {
      'paymentId': _paymentID,
      'PayerID': _payerID,
    };

    final uri =
        Uri.http(baseUrl, '/wefix/account/payment-success', queryParameters);
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );
    print(response.body);
    if (response.body.length > 40) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('jwt', response.body.toString());
      return "";
    } else {
      return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    successPaypal();
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
                "SUCCESS PAYMENT",
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
