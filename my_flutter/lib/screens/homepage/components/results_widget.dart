import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wefix/screens/calendar/calendar_page.dart';
import 'package:wefix/screens/homepage/home_page.dart';
import 'package:wefix/screens/profile/profile_page.dart';

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
  @override
  Widget build(BuildContext context) {
    String category = widget.category!;

    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(20)),
        HomeHeader(),
        SizedBox(height: getProportionateScreenWidth(10)),
        ListProfile(
            name: 'Marco Prova',
            description: "Sono un $category",
            image: Icon(Icons.person),
            press: () {}),
        ListProfile(
            name: 'Marco Prova2',
            description: "Sono un $category",
            image: Icon(Icons.person),
            press: () {}),
        ListProfile(
            name: 'Marco Prova',
            description: "Sono un $category",
            image: Icon(Icons.person),
            press: () {}),
        ListProfile(
            name: 'Marco Prova1',
            description: "Sono un $category",
            image: Icon(Icons.person),
            press: () {}),
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
  final Icon image;
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
        leading: const CircleAvatar(
          radius: 32,
          backgroundImage: NetworkImage(
              "http://apollo2.dl.playstation.net/cdn/UP0151/CUSA09971_00/dqyZBn0kprLUqYGf0nDZUbzLWtr1nZA5.png"),
        ),
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
