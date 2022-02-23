// We use name route
// All our routes will be available here

import 'package:wefix/screens/homepage/components/results_widget.dart';
import 'package:wefix/screens/intro/intro.dart';
import 'package:wefix/screens/login/login.dart';
import 'package:wefix/screens/navigator/navigator.dart';
import 'package:wefix/screens/payment/payment.dart';
import 'package:wefix/screens/signup/signup.dart';
import 'package:wefix/screens/signup_optional/signup_optional.dart';
import 'package:wefix/screens/payment/summary/summary.dart';
import 'package:wefix/screens/payment/info/info.dart';

import 'package:flutter/widgets.dart'; //per importare il tipo WidgetBuilder

final Map<String, WidgetBuilder> routes = {
  Intro.routeName: (context) => Intro(),
  LoginScreen.routeName: (context) => LoginScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  SignUpOptionalScreen.routeName: (context) => SignUpOptionalScreen(),
  NavigatorScreen.routeName: (context) => NavigatorScreen(),
  PaymentPage.routeName: (context) => PaymentPage(),
  SummaryPage.routeName: (context) => SummaryPage(),
  //InfoPage.routeName: (context) => InfoPage(),
};
