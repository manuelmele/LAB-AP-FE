import 'package:flutter/material.dart';
import 'package:wefix/screens/intro/intro_slides.dart';
import 'package:wefix/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeFix',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: IntroSlides.routeName, //this is set to "/intro"
      routes: routes,
    );
  }
}
