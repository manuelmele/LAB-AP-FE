// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:wefix/models/meeting_model.dart';
import 'package:wefix/models/user_model.dart';

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

  if (meeting.accepted == false || isDateExpired) return true;

  return false;
}
