// We use name route
// All our routes will be available here

import 'package:wefix/screens/intro/intro_slides.dart';
import 'package:wefix/screens/login/login.dart';
import 'package:flutter/widgets.dart'; //per importare il tipo WidgetBuilder

final Map<String, WidgetBuilder> routes = {
  IntroSlides.routeName: (context) => IntroSlides(),
  LoginScreen.routeName: (context) => LoginScreen(),
};
