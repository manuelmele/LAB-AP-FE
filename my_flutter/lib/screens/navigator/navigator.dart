import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wefix/screens/calendar/calendar_page.dart';
import 'package:wefix/screens/homepage/home_page.dart';
import 'package:wefix/screens/profile/profile_page.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import '../../constants.dart';
import '../../size_config.dart';

class NavigatorScreen extends StatefulWidget {
  static String routeName = "/navigator";

  const NavigatorScreen({Key? key}) : super(key: key);
  @override
  _NavigatorState createState() => _NavigatorState();
}

class _NavigatorState extends State<NavigatorScreen> {
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
    CalendarPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
          onItemSelected: (index) => setState(() {
            currentIndex = index;
            //_pageController.animateToPage(index,
            //duration: Duration(milliseconds: 300), curve: Curves.ease);
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home_rounded),
              title: Text('Home Page'),
              activeColor: kOrange,
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.account_circle),
                title: Text('User Page'),
                activeColor: kOrange),
            BottomNavyBarItem(
                icon: Icon(Icons.date_range),
                title: Text('Calendar'),
                activeColor: kOrange),
            BottomNavyBarItem(
                icon: Icon(Icons.toc),
                title: Text('Settings'),
                activeColor: kOrange),
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
        ],
      ),*/
        );
  }
}
