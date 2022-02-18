import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/size_config.dart';

class SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      backgroundColor: kBackground,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: getProportionateScreenHeight(200),
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: kLightGreen,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          const AssetImage("assets/images/profile.jpeg"),
                      radius: getProportionateScreenHeight(40),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Text("Laura Papi"),
                    Text("laura@test.com"),
                  ]),
            ),
          ),
          ListTile(
            title: true
                ? const Text('Upgrade to PRO')
                : const Text('Manage your subscription'),
            iconColor: kOrange,
            //tileColor: kOrange,
            textColor: kOrange,
            //subtitle: const Text('subscribe now to enjoy all the benefits'),
            trailing: true ? Icon(Icons.star) : Icon(Icons.paid),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Change your password'),
            //trailing: Icon(Icons.maps_home_work_outlined),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Log Out'),
            trailing: Icon(Icons.logout),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
