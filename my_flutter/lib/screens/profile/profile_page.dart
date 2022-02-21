import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/screens/homepage/components/results_widget.dart';
import 'package:wefix/screens/login/login.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wefix/models/user_model.dart';
import 'package:wefix/screens/profile/customer_page.dart';
import 'package:wefix/screens/profile/worker_page.dart';
import 'package:wefix/services/user_service.dart';

import '../../../size_config.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  String? jwt;
  UserModel? userData;
  bool initialResults = false;

  void getUserData() {
    //search by category just the first time
    if (initialResults) return;

    SharedPreferences.getInstance().then((prefs) {
      String jwt = prefs.getString('jwt')!;
      getUserDataService(jwt).then((newResults) {
        setState(() {
          userData = newResults;
          initialResults = true;
          print(userData);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getUserData(); // when the page starts it calls the user data

    if (userData != null) {
      // to solve the null check operator used on a null variable
      String role = userData!.userRole;
      if (role == "Customer") {
        return Scaffold(
          backgroundColor: kBackground,
          body: CustomerPage(),
        );
      } else {
        return Scaffold(
          backgroundColor: kBackground,
          body: WorkerPage(),
        );
      }
    } else {
      return Scaffold(
          // if I return an empty scaffold something isn't right...
          );
    }
  }
}
