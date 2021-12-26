import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> introData = [
    {
      "text": "Welcome to WeFix, Let's Start!",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
          "We help people solve theri problems \nconnecting them to local artisans",
      "image": "assets/images/splash_2.png"
    },
    {
      "text":
          "We give visibility to small local enterpreneurs \nby offering an easy-to-use platform",
      "image": "assets/images/splash_3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        Container(
            color: Colors.blueGrey,
            child: const Center(
                child: Text('Welcome to WeFix, Let\'s Start!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.white)))),
        Container(
            color: Colors.cyan,
            child: const Center(
                child: Text(
                    'We help people solve their problems \nconnecting them to local artisans',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.white)))),
        Container(
            color: Colors.deepPurple,
            child: const Center(
                child: Text(
                    'We give visibility to small local enterpreneurs \nby offering an easy-to-use platform',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.white)))),
      ],
    );
  }

  /*
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
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
                    Spacer(),
                    Row(
                      //riga che mostra a quale swipe sono nella home
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
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

    */
}
