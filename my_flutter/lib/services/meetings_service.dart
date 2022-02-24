// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:wefix/models/meeting_model.dart';
import 'package:wefix/models/user_model.dart';
import 'package:wefix/screens/calendar/calendar_page.dart';
import 'package:wefix/screens/navigator/navigator.dart';

import '../constants.dart';

String baseUrl = BASE_URL;

Future<List<MeetingModel>> getAllCustomerMeetings(
    String _jwt, String _emailCustomer) async {
  final queryParameters = {
    'emailCustomer': _emailCustomer,
  };

  final uri =
      Uri.http(baseUrl, '/wefix/account/customer-meetings', queryParameters);
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $_jwt',
    },
  );

  //print(response.body);

  List<MeetingModel> results = json
      .decode(response.body)
      .map<MeetingModel>((data) => MeetingModel.fromJson(data))
      .toList();

  for (MeetingModel result in results) {
    print(result.toString());
  }

  //print("msg:" + response.body.toString());
  return results;
}

Future<List<MeetingModel>> getAllWorkerMeetings(
    String _jwt, String _emailWorker) async {
  final queryParameters = {
    'emailWorker': _emailWorker,
  };

  final uri =
      Uri.http(baseUrl, '/wefix/account/worker-meetings', queryParameters);
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $_jwt',
    },
  );

  //print(response.body);

  List<MeetingModel> results = json
      .decode(response.body)
      .map<MeetingModel>((data) => MeetingModel.fromJson(data))
      .toList();

  for (MeetingModel result in results) {
    print(result.toString());
  }

  //print("msg:" + response.body.toString());
  return results;
}

void approveMeeting(String _jwt, int _idMeeting, bool _accept) async {
  print(_idMeeting);

  final queryParameters = {
    'idMeeting': _idMeeting.toString(),
    'accept': _accept.toString(),
  };

  final uri =
      Uri.http(baseUrl, '/wefix/account/approve-meeting', queryParameters);
  final response = await http.put(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $_jwt',
    },
  );

  //print(response.body);

  if (response.statusCode == 200) {
    print("Ok! Approved");
  } else {
    print("Unable to approve the meeting");
  }
}

void sharePosition(
    String _jwt, int _idMeeting, bool _start, double _lat, double _lng) async {
  final queryParameters = {
    'idMeeting': _idMeeting.toString(),
    'start': _start.toString(),
    'latitude': _lat.toString(),
    'longitude': _lng.toString(),
  };

  final uri =
      Uri.http(baseUrl, '/wefix/account/share-position', queryParameters);
  final response = await http.put(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $_jwt',
    },
  );

  //print(response.body);

  if (response.statusCode == 200) {
    print("Ok! ");
  } else {
    print("Unable to share position");
  }
}

bool isNewMeeting(MeetingModel meeting) {
  final now = DateTime.now();
  final expirationDate =
      DateFormat('dd/MM/yyyy').parse(meeting.dateTime.substring(0, 10));
  final bool isDateExpired = expirationDate.isBefore(now);

  if (meeting.accepted == null && !isDateExpired) return true;

  return false;
}

bool isBookedMeeting(MeetingModel meeting) {
  final now = DateTime.now();
  final expirationDate =
      DateFormat('dd/MM/yyyy').parse(meeting.dateTime.substring(0, 10));
  final bool isDateExpired = expirationDate.isBefore(now);

  if (meeting.accepted == true && !isDateExpired) return true;

  return false;
}

bool isCompletedMeeting(MeetingModel meeting) {
  final now = DateTime.now();
  final expirationDate =
      DateFormat('dd/MM/yyyy').parse(meeting.dateTime.substring(0, 10));
  final bool isDateExpired = expirationDate.isBefore(now);

  if (meeting.accepted == false || meeting.started == false || isDateExpired) {
    return true;
  }

  return false;
}

void refreshCalendar(BuildContext context) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (BuildContext ctx) =>
              const NavigatorScreen(initialIndex: 2)));
}

void shareLoadedPosition(String _jwt, int _idMeeting, bool _start) async {
  await Geolocator.requestPermission().then((permission) {
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Geolocator.getCurrentPosition().then((position) {
        sharePosition(
            _jwt, _idMeeting, _start, position.latitude, position.longitude);
      });
    }
  });
}
