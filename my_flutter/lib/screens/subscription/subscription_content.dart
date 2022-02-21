import 'package:flutter/material.dart';
import 'package:wefix/size_config.dart';
import 'package:wefix/constants.dart';

class SubscriptionContent extends StatelessWidget {
  const SubscriptionContent({
    Key? key,
    this.state,
    this.plan,
    this.cost,
    this.expiration,
  }) : super(key: key);
  final String? state, plan, cost, expiration;

  @override
  Widget build(BuildContext context) {
    return Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Your current plan:",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(20),
              color: kOrange,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Container(
            margin: EdgeInsets.all(5),
            //padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: kBackground,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: kLightOrange.withOpacity(0.7),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(3, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: 30,
                      bottom: 10,
                      left: getProportionateScreenWidth(60),
                      right: getProportionateScreenWidth(60)),
                  child: Text(
                    plan!,
                    textAlign: TextAlign.center,
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(25),
                      //color: kOrange,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    cost!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(35),
                      color: kOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 20, left: 30, right: 45, top: 20),
                  child: Text(
                    state!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: getProportionateScreenWidth(20),
                      color: kOrange,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(bottom: 30, left: 30, right: 45),
                  child: Text(
                    expiration!,
                    textAlign: TextAlign.left,
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
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
}
