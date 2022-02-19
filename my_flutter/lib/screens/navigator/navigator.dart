import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wefix/screens/calendar/calendar_page.dart';
import 'package:wefix/screens/homepage/home_page.dart';
import 'package:wefix/screens/profile/profile_page.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:wefix/screens/settings/settings.dart';

import '../../constants.dart';
import '../../size_config.dart';
import '../settings/settings.dart';

import 'package:wefix/screens/payment/payment.dart';

class NavigatorScreen extends StatefulWidget {
  static String routeName = "/navigator";

  const NavigatorScreen({Key? key}) : super(key: key);
  @override
  _NavigatorState createState() => _NavigatorState();
}

class _NavigatorState extends State<NavigatorScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int currentIndex = 0;

  List listOfColors = [
    Container(
      color: kBlue,
    ),
    Container(
      color: kOrange,
    ),
    Container(
      color: kYellow,
    ),
    Container(
      color: kPurple,
    )
  ];

  final screens = [
    HomePage(),
    ProfilePage(),
    CalendarPage(),
    //SettingsPage(),
  ];

  void _onItemTapped(int index) {
    if (index == 3) {
      _key.currentState!.openDrawer();
    } else {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        key: _key,
        drawer: SettingsDrawer(),
        body: IndexedStack(
          // to leave the children state alive
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavyBar(
          iconSize: 27,
          backgroundColor: kBackground,

          selectedIndex: currentIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: _onItemTapped,
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home_rounded),
              title: Text('Home Page'),
              activeColor: kOrange,
              inactiveColor: kGrey,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('User Page'),
              activeColor: kOrange,
              inactiveColor: kGrey,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.date_range),
              title: Text('Calendar'),
              activeColor: kOrange,
              inactiveColor: kGrey,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.toc),
              title: Text('Settings'),
              activeColor: kLightGreen,
              inactiveColor: kGrey,
            ),
          ],
        )
        /*
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: kOrange,
        selectedItemColor: kBackground,
        unselectedItemColor: kYellow,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_police_rounded),
            label: 'Upgrade',
          ),
        ],
      ),*/
        );
  }
}
