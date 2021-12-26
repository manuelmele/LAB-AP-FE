import 'package:flutter/material.dart';
import 'package:wefix/screens/intro/body.dart';

class IntroSlides extends StatelessWidget {
  //equivalente a SplashScreen
  static String routeName =
      "/intro"; //nell'app di prova questa si chiama splash

  @override
  Widget build(BuildContext context) {
    //you have to call it on your starting screen (?)

    //SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeFix'),
      ),
      body: Body(),
    );
  }
}
