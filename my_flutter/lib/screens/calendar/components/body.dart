import 'package:flutter/material.dart';
import 'package:wefix/screens/calendar/components/appointments/new_requests.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(40)),
        const Center(
          child: Text(
            "Your Appointments",
            style: TextStyle(
                fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),

        NewRequests(
          userID: "iduserblbla",
        ),
        //Booked Appointments

        //Completed Appointments
        SizedBox(height: getProportionateScreenWidth(30)),
      ],
    );
  }
}
