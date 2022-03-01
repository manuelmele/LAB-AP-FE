import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';

import 'body.dart';

class BookAppointmentPage extends StatelessWidget {
  static String routeName = "/booking";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Body(),
    );
  }
}
