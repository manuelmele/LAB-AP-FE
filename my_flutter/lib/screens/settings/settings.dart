import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/constants.dart';
import 'package:wefix/models/user_model.dart';
import 'package:wefix/screens/login/login.dart';
import 'package:wefix/screens/payment/body.dart';
import 'package:wefix/screens/payment/payment.dart';
import 'package:wefix/services/user_service.dart';
import 'package:wefix/size_config.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({Key? key}) : super(key: key);

  @override
  _SettingsDrawerState createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  String? name;
  String? surname;
  String? email;
  String? jwt;
  var role;
  var data;
  Future<Map<String, String>>? userData;
  Future<Album>? futureAlbum;

  @override
  void initState() {
    super.initState();
    setState(() {
      futureAlbum = fetchAlbum();
    });
  }

/*
  Future<Map<String, String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    jwt = prefs.getString('jwt');

    getUserDataService(email!, jwt!).then((newResults) {
      setState(() {
        userData = newResults;
      });
    });
    return userData;
  }
  */

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
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
                    FutureBuilder<Album>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          data = snapshot.data;
                          name = snapshot.data!.name;
                          surname = snapshot.data!.surname;
                          email = snapshot.data!.email;
                          role = snapshot.data!.role;
                          return Text(name! + " " + surname! + "\n" + email!);
                        }
                        return const SizedBox(
                          height: 0,
                        );
                      },
                    ),

                    //Text(data!.name),
                  ]),
            ),
          ),
          ListTile(
            title: role == null
                ? const Text('Upgrade to PRO')
                : const Text('Manage your subscription'),
            iconColor: kOrange,
            //tileColor: kOrange,
            textColor: kOrange,
            //subtitle: const Text('subscribe now to enjoy all the benefits'),
            trailing: role == null ? Icon(Icons.star) : Icon(Icons.paid),
            onTap: () {
              // Update the state of the app
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) => PaymentPage()));
              // Update the state of the app
              // ...
              // Then close the drawer
              //Navigator.pop(context);
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
            onTap: () async {
              // Update the state of the app
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('jwt');
              prefs.setBool('rememberMe', false);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) => LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
