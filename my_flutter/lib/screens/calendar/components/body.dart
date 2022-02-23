// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:wefix/screens/calendar/components/appointments_worker/booked_requests.dart';
import 'package:wefix/screens/calendar/components/appointments_worker/completed_requests.dart';
import 'package:wefix/screens/calendar/components/appointments_worker/new_requests.dart';

import '../../../size_config.dart';
import 'appointments_customer/booked_requests.dart';
import 'appointments_customer/completed_requests.dart';
import 'appointments_customer/new_requests.dart';

class Body extends StatelessWidget {
  Widget workerAppointments = ListView(
    children: [
      NewRequestsWorker(
        userID: "iduserblbla",
      ),
      BookedRequestsWorker(
        userID: "iduserblbla",
      ),
      CompletedRequestsWorker(
        userID: "iduserblbla",
      ),
    ],
  );

  Widget customerAppointments = ListView(
    children: [
      NewRequestsCustomer(
        userID: "iduserblbla",
      ),
      BookedRequestsCustomer(
        userID: "iduserblbla",
      ),
      CompletedRequestsCustomer(
        userID: "iduserblbla",
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    bool userIsCustomer = false;
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(10)),
        Expanded(
          child: userIsCustomer ? customerAppointments : workerAppointments,
        ),
      ],
    );
  }
}
