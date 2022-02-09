import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wefix/screens/calendar/calendar_page.dart';
import 'package:wefix/screens/homepage/home_page.dart';
import 'package:wefix/screens/profile/profile_page.dart';
import 'package:wefix/utilis/allert_dialogs.dart';

import '../../../../size_config.dart';

class NewRequestsCustomer extends StatefulWidget {
  final String? userID;

  const NewRequestsCustomer({Key? key, this.userID}) : super(key: key);
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<NewRequestsCustomer> {
  @override
  Widget build(BuildContext context) {
    String userID = widget.userID!;
    String imageUrl =
        "http://apollo2.dl.playstation.net/cdn/UP0151/CUSA09971_00/dqyZBn0kprLUqYGf0nDZUbzLWtr1nZA5.png";

    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ExpansionTile(
              initiallyExpanded: true,
              title: const Text(
                "Pending Requests",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight / 2,
                  child: ListView(
                    children: [
                      ListAppointment(
                          name: 'Marco Prova',
                          service: "Type of service: Gardener",
                          imageUrl: imageUrl,
                          press: () {}),
                      ListAppointment(
                          name: 'Marco Prova2',
                          service: "Type of service: Gardener",
                          imageUrl: imageUrl,
                          press: () {}),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class ListAppointment extends StatelessWidget {
  const ListAppointment({
    Key? key,
    required this.name,
    required this.service,
    required this.imageUrl,
    required this.press,
  }) : super(key: key);

  final String name;
  final String service;
  final String imageUrl;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.grey[200];
    return Container(
      margin: EdgeInsets.only(top: 20, right: 20, left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.grey[200],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 16),
        trailing: Container(
            height: double.infinity,
            child: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                DialogsUI()
                    .showInfoDialog(context, "Appointment Info", service);
              },
            )),
        leading:
            CircleAvatar(radius: 32, backgroundImage: NetworkImage(imageUrl)),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        subtitle: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                service,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
