import 'package:flutter/material.dart';
import 'package:wefix/models/user_model.dart';
import 'package:wefix/size_config.dart';
import 'package:wefix/constants.dart';

class PaymentContent extends StatelessWidget {
const PaymentContent({
    Key? key,
    this.title,
    this.discount,
    this.cost,
    this.image,
    this.pay,
  }) : super(key: key);
  final String? title, discount, cost, image, pay;


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
          SizedBox(
            height: getProportionateScreenHeight(400),
            child: Container(
              margin: const EdgeInsets.all(15),
              height: getProportionateScreenHeight(330),
              width: getProportionateScreenWidth(330),
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
                    offset: const Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Text(
                      cost!,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(35),
                        color: kOrange,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ),
                  Image.asset(
                    image!,
                    height: getProportionateScreenHeight(120),
                    width: getProportionateScreenWidth(120),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 30, left: 45, right: 45),
                    child: Text(
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
          ),
        ]);
  }
}
