import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wefix/screens/calendar/calendar_page.dart';
import 'package:wefix/screens/homepage/home_page.dart';
import 'package:wefix/screens/profile/profile_page.dart';

import '../../../../size_config.dart';

class NewRequests extends StatefulWidget {
  final String? userID;

  const NewRequests({Key? key, this.userID}) : super(key: key);
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<NewRequests> {
  @override
  Widget build(BuildContext context) {
    String userID = widget.userID!;

    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(20)),
        Container(
          padding: EdgeInsets.only(left: 20),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "New Requests",
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        ListAppointment(
            name: 'Marco Prova',
            service: "Type of service: Gardener",
            image: Icon(Icons.person),
            press: () {}),
        ListAppointment(
            name: 'Marco Prova2',
            service: "Type of service: Gardener",
            image: Icon(Icons.person),
            press: () {}),
        SizedBox(height: getProportionateScreenWidth(30)),
      ],
    );
  }
}

class ListAppointment extends StatelessWidget {
  const ListAppointment({
    Key? key,
    required this.name,
    required this.service,
    required this.image,
    required this.press,
  }) : super(key: key);

  final String name;
  final String service;
  final Icon image;
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
        trailing:
            Container(height: double.infinity, child: Icon(Icons.info_outline)),
        leading: const CircleAvatar(
          radius: 32,
          backgroundImage: NetworkImage(
              "http://apollo2.dl.playstation.net/cdn/UP0151/CUSA09971_00/dqyZBn0kprLUqYGf0nDZUbzLWtr1nZA5.png"),
        ),
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
            Row(
              children: [
                OutlinedButton(
                  onPressed: () => {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size.zero,
                    padding: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: const Text(
                    "Accept",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.only(left: 5),
                  child: OutlinedButton(
                    onPressed: () => {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.grey[400],
                      minimumSize: Size.zero,
                      padding: EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    child: const Text(
                      "Decline",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
