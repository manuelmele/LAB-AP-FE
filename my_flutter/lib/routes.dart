// We use name route
// All our routes will be available here

import 'package:wefix/screens/book_appointment/booking.dart';
import 'package:wefix/screens/book_appointment/confirmation.dart';
import 'package:wefix/screens/homepage/components/results_widget.dart';
import 'package:wefix/screens/intro/intro.dart';
import 'package:wefix/screens/login/login.dart';
import 'package:wefix/screens/navigator/navigator.dart';
import 'package:wefix/screens/payment/confirmation/failed.dart';
import 'package:wefix/screens/payment/confirmation/success.dart';
import 'package:wefix/screens/payment/payment.dart';
import 'package:wefix/screens/profile/public_worker_page.dart';
import 'package:wefix/screens/payment/paypal/makePayment.dart';
import 'package:wefix/screens/payment/redirect/redirect.dart';
import 'package:wefix/screens/signup/signup.dart';
import 'package:wefix/screens/signup_optional/signup_optional.dart';
import 'package:wefix/screens/payment/summary/summaryCustomer.dart';
import 'package:wefix/screens/payment/summary/summaryWorker.dart';

import 'package:flutter/widgets.dart';
import 'package:wefix/screens/subscription/subscription.dart'; //per importare il tipo WidgetBuilder

final Map<String, WidgetBuilder> routes = {
  Intro.routeName: (context) => Intro(),
  LoginScreen.routeName: (context) => LoginScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  SignUpOptionalScreen.routeName: (context) => SignUpOptionalScreen(),
  NavigatorScreen.routeName: (context) => NavigatorScreen(),
  PaymentPage.routeName: (context) => PaymentPage(),
  PublicWorkerPage.routeName: (context) => PublicWorkerPage(),
  SubscriptionPage.routeName: (context) => SubscriptionPage(),
  BookAppointmentPage.routeName: (context) => BookAppointmentPage(),
  SummaryCustomerPage.routeName: (context) => SummaryCustomerPage(),
  SummaryWorkerPage.routeName: (context) => SummaryWorkerPage(),
  BookingConfirmationScreen.routeName: (context) => BookingConfirmationScreen(),
  RedirectPage.routeName: (context) => RedirectPage(),
  makePayment.routeName: (context) => makePayment(),
  PaymentSuccessScreen.routeName: (context) => PaymentSuccessScreen(),
  PaymentFailedScreen.routeName: (context) => PaymentFailedScreen(),
};
