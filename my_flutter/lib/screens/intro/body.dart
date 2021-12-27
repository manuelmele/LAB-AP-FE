import 'package:flutter/material.dart';
import 'intro_content.dart';

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
          "We help people solve theri problems \nconnecting them to local artisans",
      "image": "assets/images/intro2.jpg"
    },
    {
      "text":
          "We give visibility to small local enterpreneurs \nby offering an easy-to-use platform",
      "image": "assets/images/intro3.jpg"
    },
  ];

/*
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
                children: <Widget>[
                  Text(
                    'We give visibility to small local enterpreneurs \nby offering an easy-to-use platform',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.white)),
                  ContainedButton(
                      text: "Continue",
                      press: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
      ],
    );
  }
*/

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
                    //horizontal: getProportionateScreenWidth(20)
                    ),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      //riga che mostra a quale swipe sono nella home
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        introData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    ElevatedButton(
                      child: const Text('Continue'),
                      onPressed: () {},
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
        color: currentPage == index ? Color(0xFFFF7643) : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
