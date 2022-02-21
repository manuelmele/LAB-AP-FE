import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class CalendarPage extends StatefulWidget {
  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Your Appointments",
            style: TextStyle(
              color: kOrange,
            ),
          )),
    );
  }
}
