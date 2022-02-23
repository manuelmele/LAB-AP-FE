// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/models/user_model.dart';
import 'package:wefix/screens/calendar/components/appointments_worker/booked_requests.dart';
import 'package:wefix/screens/calendar/components/appointments_worker/completed_requests.dart';
import 'package:wefix/screens/calendar/components/appointments_worker/new_requests.dart';
import 'package:wefix/services/user_service.dart';

import '../../../size_config.dart';
import 'appointments_customer/booked_requests.dart';
import 'appointments_customer/completed_requests.dart';
import 'appointments_customer/new_requests.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserModel? user;
  String? jwtUser;
  bool disposed = false;
  bool initialResults = false;

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  Widget workerAppointments(String jwt) {
    return ListView(
      children: [
        NewRequestsWorker(
          userID: jwt,
        ),
        BookedRequestsWorker(
          userID: jwt,
        ),
        CompletedRequestsWorker(
          userID: jwt,
        ),
      ],
    );
  }

  Widget customerAppointments(String jwt) {
    return ListView(
      children: [
        NewRequestsCustomer(
          userID: jwt,
        ),
        BookedRequestsCustomer(
          userID: jwt,
        ),
        CompletedRequestsCustomer(
          userID: jwt,
        ),
      ],
    );
  }

  void loadUser() {
    if (initialResults) return;

    SharedPreferences.getInstance().then((prefs) {
      String jwt = prefs.getString('jwt')!;
      getUserDataService(jwt).then((userResult) {
        if (!disposed) {
          setState(() {
            jwtUser = jwt;
            user = userResult;
            initialResults = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    loadUser();

    if (user != null && jwtUser != null) {
      return Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          Expanded(
            child: user!.userRole == "Customer"
                ? customerAppointments(jwtUser!)
                : workerAppointments(jwtUser!),
          ),
        ],
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
