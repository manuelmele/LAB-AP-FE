import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/models/meeting_model.dart';
import 'package:wefix/screens/calendar/calendar_page.dart';
import 'package:wefix/screens/homepage/home_page.dart';
import 'package:wefix/screens/profile/profile_page.dart';
import 'package:wefix/services/meetings_service.dart';
import 'package:wefix/services/user_service.dart';
import 'package:wefix/utilis/allert_dialogs.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class BookedRequestsWorker extends StatefulWidget {
  final String? userJWT;

  const BookedRequestsWorker({Key? key, this.userJWT}) : super(key: key);
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<BookedRequestsWorker> {
  List<MeetingModel> results = [];
  bool disposed = false;
  bool initialResults = false;
  bool sendingPosition = false;
  Timer? timer;

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    disposed = true;
    super.dispose();
  }

  void loadMeeting() {
    if (initialResults) return;

    SharedPreferences.getInstance().then((prefs) {
      String jwt = prefs.getString('jwt')!;
      getUserDataService(jwt).then((userResult) {
        getAllWorkerMeetings(jwt, userResult.email).then((newResults) {
          if (!disposed) {
            setState(() {
              results = newResults;
              initialResults = true;
            });
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    loadMeeting();

    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ExpansionTile(
              initiallyExpanded: false,
              title: const Text(
                "Booked Requests",
                style: TextStyle(
                  fontSize: 14,
                  color: kOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight / 2,
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, i) {
                      if (isBookedMeeting(results[i])) {
                        int meetingId = results[i].idMeeting;
                        String jwt = widget.userJWT!;

                        return ListAppointment(
                            name: results[i].firstName +
                                " " +
                                results[i].secondName,
                            service: results[i].category,
                            date: results[i].dateTime.substring(0, 10),
                            slotTime: results[i].slotTime,
                            description: results[i].description,
                            image: results[i].photoProfile,
                            press: () {
                              timer = Timer.periodic(Duration(seconds: 2),
                                  (Timer t) {
                                shareLoadedPosition(jwt, meetingId, true);
                              });

                              showSendingPosDialog(
                                  context, jwt, meetingId, timer!);
                            });
                      } else {
                        return const SizedBox(height: 0);
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

showSendingPosDialog(
    BuildContext context, String _jwt, int _idMeeting, Timer timer) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("Address Reached!"),
    onPressed: () {
      timer.cancel();
      approveMeeting(_jwt, _idMeeting, false);
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Sending position.."),
    content: const Text(
        "Do not close the app, we are sending your live position to the customer. "),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class ListAppointment extends StatelessWidget {
  const ListAppointment({
    Key? key,
    required this.name,
    required this.service,
    required this.slotTime,
    required this.date,
    required this.description,
    required this.image,
    required this.press,
  }) : super(key: key);

  final String name;
  final String service;
  final String slotTime;
  final String date;
  final String description;
  final String image;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    String infomessage =
        "Description: $description \n\n Date: $date \n\n Slot Time: $slotTime";

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
        trailing: Container(
            height: double.infinity,
            child: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                DialogsUI()
                    .showInfoDialog(context, "Appointment Info", infomessage);
              },
            )),
        leading: CircleAvatar(
            radius: 32,
            child: ClipOval(child: Image.memory(base64Decode(image)))),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        subtitle: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                service,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () => {press()},
              style: OutlinedButton.styleFrom(
                backgroundColor: kOrange,
                minimumSize: Size.zero,
                padding: EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              child: const Text(
                "Start",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
