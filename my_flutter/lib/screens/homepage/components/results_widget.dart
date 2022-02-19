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
import 'package:wefix/services/filters_service.dart';

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

  void searchByQuery(String value) {
    SharedPreferences.getInstance().then((prefs) {
      String jwt = prefs.getString('jwt')!;
      filterByQuery(jwt, value).then((newResults) {
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
        body: Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(20)),
        HomeHeader(
          onSubmit: (String value) {
            print("Searching for value: $value");
            searchByQuery(value);
          },
        ),
        Expanded(
            child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, i) {
            return ListProfile(
                name: results[i].firstName + " " + results[i].secondName,
                description: results[i].bio,
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
    required this.description,
    required this.image,
    required this.press,
  }) : super(key: key);

  final String name;
  final String description;
  final String image;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.grey[200];
    return Container(
      margin: EdgeInsets.only(top: 20, right: 20, left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.grey[200],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 16),
        trailing: Icon(Icons.arrow_forward_ios),
        leading: CircleAvatar(
            radius: 32,
            child: ClipOval(
                child: image == null || image.isEmpty
                    ? const Image(
                        image: AssetImage('assets/avatar/default_avatar.jpg'))
                    : Image.memory(base64Decode(image)))),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
