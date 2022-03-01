import 'package:flutter/material.dart';
import 'package:wefix/services/meetings_service.dart';

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
      backgroundColor: kBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kBackground,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Your Appointments",
          style: TextStyle(
            color: kOrange,
            fontSize: 28,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.refresh_sharp,
              color: kOrange,
            ),
            onPressed: () {
              refreshCalendar(context);
            },
          )
        ],
      ),
    );
  }
}
