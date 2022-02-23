/*import 'package:flutter/material.dart';
import 'package:wefix/size_config.dart';
import 'package:wefix/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/main.dart';
import 'package:wefix/screens/book_appointment/confirmation.dart';
import 'package:wefix/screens/homepage/home_page.dart';
import 'package:wefix/screens/navigator/navigator.dart';
import 'package:wefix/screens/signup_optional/signup_optional.dart';
import 'package:wefix/services/auth_service.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

import 'package:wefix/services/user_service.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Summary extends StatelessWidget {
  Summary({
    Key? key,
    this.title,
    this.discount,
    this.cost,
    this.image,
    this.pay,
  }) : super(key: key);
  final String? title, discount, cost, image, pay;
  String? _chosenCategory;
  List<String> category = ["Plumber", "Painter", "Electrician", "Blacksmith", "Gardener", "Carpenter"];
  List<String?> errors = [];



  Future<String> selectCategory() async {
    if (_chosenCategory == null) {
      return "Error: date field is required";
    }
    errors = [];
    return '';
    //print(response);
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




  @override
  Widget build(BuildContext context) {
    return Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title!,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(25),
              color: kOrange,
              fontWeight: FontWeight.normal,
            ),
          ),

          Text(
          discount!,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(15),
              color: kOrange,
              fontWeight: FontWeight.normal,
            ),
          ),
          Container(
              margin: EdgeInsets.all(15),
              height: getProportionateScreenHeight(330),
              width: getProportionateScreenWidth(330),
              //padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: kBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                ),
                boxShadow: [
                  BoxShadow(
                    color: kLightOrange.withOpacity(0.7),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
            child: new Column (
              children: [
                  new Container(
                    margin: const EdgeInsets.only(top:30),
                    child: new Text(
                      cost!,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(35),
                        color: kOrange,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ),
                  

                  new Container(
                    //margin: EdgeInsets.all(40),
                    child: Image.asset(
                      image!,
                      height: getProportionateScreenHeight(120),
                      width: getProportionateScreenWidth(120),
                    ),
                  ),



                  new Container(
                    margin: const EdgeInsets.only(bottom:30, left:45, right:45),
                    child: new Text(
                      pay!,
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ]);
  }



   DropdownButtonHideUnderline buildTimeSlotFormField() {
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
}*/
