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
  final _formKey = GlobalKey<FormState>();
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
  String? _chosenCategory;
  String? partita_iva;
  String? identity_card;
  List<String> category = ["Plumber", "Painter", "Electrician", "Blacksmith", "Gardener", "Carpenter"];
  List<String?> errors = [];
  String currency="EUR";


  Future<String> InsertInfo() async {
    if (_chosenCategory == null || partita_iva==null) {
      return "Error: date field is required";
    }
    errors = [];
    return '';
    //print(response);
  }

Future<String> UpgradeToPro() async {
   if (_chosenCategory == null || partita_iva==null) {
      return "Error: manca qualcosa";
    }
    errors = [];
    String price;
    if (plan==0) {
      price="1";
    }
    else {
      price="10";
    }
    SharedPreferences prefs =await SharedPreferences.getInstance();
    jwt = prefs.getString('jwt');
    String response = await UpgradeToProService(_chosenCategory!, partita_iva!, identity_card!, price, currency, jwt!);

    if (response.contains('Error')) {
      String error = response;
      addError(error: error);
    } else {
      return jwt!;
    }
    return '';
  }


  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }


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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Column(
              children: <Widget>[
            const SizedBox(height: 20),
            buildCategoryFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildPartitaIVAFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildIdentityCardFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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

              SizedBox(height: getProportionateScreenHeight(30)),
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
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      print("booking form not valid");
                    } 
                    else {
                      UpgradeToPro();
                      //Navigator.pushReplacementNamed(context, PaymentPage.routeName);
                    }
                  }
                ),
              ),
      
             
          ]),
            ),
          ],
         ),
      );
           
  }

     DropdownButtonHideUnderline buildCategoryFormField() {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        validator: (value) {
          if (value == null) {
            return mandatory;
          }
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: BorderSide(color: kLightOrange),
          ),
          labelText: "Job category",
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        hint: Text("Select your job"),
        value: _chosenCategory,
        isDense: true,
        onChanged: (newValue) {
          setState(() {
            _chosenCategory = newValue;
          });
          print(_chosenCategory);
        },
        items: category.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  TextFormField buildPartitaIVAFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => partita_iva = newValue,
      onChanged: (value) {
          setState(() {
            partita_iva = value;
          });
          print(partita_iva);
        partita_iva = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return mandatory;
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderSide: BorderSide(color: kLightOrange),
        ),
        labelText: "Partita IVA",
        hintText: "Enter your partita IVA",

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
        ),
      ),
    );
  }



  TextFormField buildIdentityCardFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => identity_card = newValue,
      onChanged: (value) {
          setState(() {
            identity_card = value;
          });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return mandatory;
        }
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderSide: BorderSide(color: kLightOrange),
        ),
        labelText: "Identity card",
        hintText: "Enter your identity card number",

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
        ),
      ),
    );
  }
}

