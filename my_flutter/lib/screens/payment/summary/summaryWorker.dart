import 'package:flutter/material.dart';
import 'package:wefix/constants.dart';
import 'bodyWorker.dart';


class SummaryWorkerPage extends StatelessWidget {
  static String routeName = "/summaryWorker";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SummaryWorker(),
    );
  }
}