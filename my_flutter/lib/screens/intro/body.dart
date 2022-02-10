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

  //pageController lets us choose which page of the pageviwe to see
  final PageController _pageController = PageController();
  @override //non so a che serve l'ho preso dalle api di flutter
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Map<String, String>> introData = [
    {
      "title": "WEFIX",
      "text": "Join us and discover our services, \nLet's start!",
      "image": "assets/images/tips.jpg"
    },
    {
      "title": "Our purpose",
      "text":
          "We help people solve their problems \nconnecting them to local artisans",
      "image": "assets/images/handshake.jpg"
    },
    {
      "title": "Look for what you need",
      "text":
          "There are several categories of service available, \nsuch as electrician, plumber, gardener and so much more",
      "image": "assets/images/workers.jpg"
    },
    {
      "title": "Sign up as an expert",
      "text":
          "We give visibility to small local enterpreneurs \nby offering an easy-to-use platform. \nUpdate your showcase with the services you provide.",
      "image": "assets/images/shop.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isLastPage = (currentPage.round() == introData.length - 1);

    //bool isSkipBtn = (!_isSkipPressed && !isLastPage && widget.showSkipButton);

    /*final skipBtn = IntroButton(
      //child: widget.skip,
      //color: widget.skipColor ?? widget.color,
      onPressed: () {
        Navigator.pushNamed(context, LoginScreen.routeName);
      },
    );*/

    final skipBtn = TextButton(
      onPressed: () {
        Navigator.pushNamed(context, LoginScreen.routeName);
      },
      child: const Text("SKIP", style: TextStyle(fontSize: 15, color: kOrange)),
    );

    final nextBtn = TextButton(
      onPressed: () {
        if (_pageController.hasClients) {
          _pageController.animateToPage(currentPage + 1,
              duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
        }
      },
      child: const Text("NEXT", style: TextStyle(fontSize: 15, color: kOrange)),
    );

    final doneBtn = TextButton(
      onPressed: () {
        Navigator.pushNamed(context, LoginScreen.routeName);
      },
      child: const Text("DONE", style: TextStyle(fontSize: 15, color: kOrange)),
    );

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(height: getProportionateScreenWidth(60)),
            Expanded(
              //box with image and text
              flex: 15,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: introData.length,
                itemBuilder: (context, index) => IntroContent(
                  title: introData[index]['title'],
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
                    //Spacer(flex: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        skipBtn,
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(0)),
                          child: Row(
                            children: List.generate(
                              introData.length,
                              (index) => buildDot(index: index),
                            ),
                          ),
                        ),
                        isLastPage ? doneBtn : nextBtn,
                        SizedBox(height: getProportionateScreenWidth(0))
                      ],
                    ),
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
      //il primo valore di width indica quanto deve essere largo il dot evidenziato, 240 lo fa diventare una barra
      width: currentPage == index ? 200 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kLightOrange : kGrey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
