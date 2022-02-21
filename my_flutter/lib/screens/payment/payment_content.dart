import 'package:flutter/material.dart';
import 'package:wefix/size_config.dart';
import 'package:wefix/constants.dart';

class IntroContent extends StatelessWidget {
  const IntroContent({
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
          Container(
              margin: EdgeInsets.all(5),
              height: getProportionateScreenHeight(350),
              width: getProportionateScreenWidth(350),
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
