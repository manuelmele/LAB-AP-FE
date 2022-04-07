import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';

import 'body.dart';

class BookAppointmentPage extends StatefulWidget {
  static String routeName = "/booking";
  final String emailWorker;

  const BookAppointmentPage({Key? key, required this.emailWorker})
      : super(key: key);
  @override
  BookAppointmentState createState() => BookAppointmentState();
}

class BookAppointmentState extends State<BookAppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Body(emailWorker: widget.emailWorker),
    );
  }
}
