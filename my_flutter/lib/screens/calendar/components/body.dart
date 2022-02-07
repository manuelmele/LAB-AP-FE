import 'package:flutter/material.dart';
import 'package:wefix/screens/calendar/components/appointments_worker/booked_requests.dart';
import 'package:wefix/screens/calendar/components/appointments_worker/completed_requests.dart';
import 'package:wefix/screens/calendar/components/appointments_worker/new_requests.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(10)),
        Expanded(
          child: ListView(
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
          ),
        ),
      ],
    );
  }
}
