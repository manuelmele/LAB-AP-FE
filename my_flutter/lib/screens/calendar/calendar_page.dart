import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Calendar"),
        automaticallyImplyLeading: false,
      ),
      body: const Center(child: Text("My Calendar Page")),
    );
  }
}
