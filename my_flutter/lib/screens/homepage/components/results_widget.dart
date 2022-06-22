import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/models/user_model.dart';
import 'package:wefix/screens/calendar/calendar_page.dart';
import 'package:wefix/screens/homepage/home_page.dart';
import 'package:wefix/screens/profile/profile_page.dart';
import 'package:wefix/screens/profile/public_worker_page.dart';
import 'package:wefix/services/filters_service.dart';
import 'package:wefix/constants.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'home_header.dart';

class ResultsWidget extends StatefulWidget {
  final String? category;

  const ResultsWidget({Key? key, this.category}) : super(key: key);
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<ResultsWidget> {
  List<UserModel> results = [];
  bool disposed = false;
  bool initialResults = false;

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  void searchByCategory(String category) {
    //search by category just the first time
    if (initialResults) return;

    SharedPreferences.getInstance().then((prefs) {
      String jwt = prefs.getString('jwt')!;
      filterByCategory(jwt, category).then((newResults) {
        if (!disposed) {
          setState(() {
            results = newResults;
            initialResults = true;
          });
        }
      });
    });
  }

  void searchByQuery(String value, String category) {
    SharedPreferences.getInstance().then((prefs) {
      String jwt = prefs.getString('jwt')!;
      filterByQuery(jwt, value, category).then((newResults) {
        if (!disposed) {
          setState(() {
            results = newResults;
            initialResults = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String category = widget.category!;
    searchByCategory(category);

    return Scaffold(
        backgroundColor: kBackground,
        body: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(
              onSubmit: (String value) {
                print("Searching for value: $value");
                searchByQuery(value, category);
              },
            ),
            Expanded(
                child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, i) {
                return ListProfile(
                    name: results[i].firstName + " " + results[i].secondName,
                    description: results[i].bio,
                    email: results[i].email,
                    image: results[i].photoProfile,
                    press: () {});
              },
            )),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ));
  }
}

class ListProfile extends StatelessWidget {
  const ListProfile({
    Key? key,
    required this.name,
    required this.email,
    required this.description,
    required this.image,
    required this.press,
  }) : super(key: key);

  final String name;
  final String description;
  final String image;
  final String email;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.grey[200];
    return Container(
      margin: EdgeInsets.only(top: 20, right: 20, left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.lightBlue[50],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 16),
        trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () async {
              SharedPreferences.getInstance().then((prefs) {
                print(email);
                prefs.setString('emailWorker', email);
                Navigator.pushNamed(context, PublicWorkerPage.routeName);
              });
            }),
        leading: CircleAvatar(
            radius: 32,
            child: CircleAvatar(
              backgroundImage: Image.memory(
                base64Decode(image))
                .image,
                radius: 70,
            )),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            color: kOrange,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
