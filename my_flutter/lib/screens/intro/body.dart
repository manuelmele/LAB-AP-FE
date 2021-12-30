import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/screens/login/login.dart';
import 'intro_content.dart';
import 'package:wefix/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> introData = [
    {
      "text": "Welcome to WeFix, Let's Start!",
      "image": "assets/images/intro1.jpg"
    },
    {
      "text":
          "We help people solve their problems \nconnecting them to local artisans",
      "image": "assets/images/intro2.jpg"
    },
    {
      "text":
          "We give visibility to small local enterpreneurs \nby offering an easy-to-use platform",
      "image": "assets/images/intro3.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Spacer(),
            Expanded(
              //box with image and text
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: introData.length,
                itemBuilder: (context, index) => IntroContent(
                  image: introData[index]["image"],
                  text: introData[index]['text'],
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
                    Spacer(flex: 1),
                    Row(
                      //riga che mostra a quale swipe sono nella home
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        introData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 1),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        child: const Text('Continue'),
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                      ),
                    ),
                    Spacer(),
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
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : kGrey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
