import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/models/review_model.dart';
import 'package:wefix/models/user_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:wefix/models/user_model.dart';

import '../constants.dart';

//[BE] server.port must be localhost:8000
String baseUrl = BASE_URL;

Future<UserModel> getUserDataService(String _jwt) async {
  final uri = Uri.http(baseUrl, '/wefix/account/profile');
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $_jwt',
    },
  );

  //print(response.body);

  Map<String, dynamic> map = json.decode(response.body);
  UserModel result = UserModel.fromJson(map);
  return result;
}

Future<String> changePasswordService(
    String _jwt, String _oldPw, String _newPw) async {
  final queryParameters = {
    "oldPassword": _oldPw,
    'newPassword': _newPw,
  };
  final uri =
      Uri.http(baseUrl, '/wefix/account/change-password', queryParameters);
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $_jwt',
    },
  );

  String jwt = jsonDecode(response.body)["jwt"].toString();
  String message = jsonDecode(response.body)["message"].toString();

  if (message.isNotEmpty && message != "null") {
    return "Error: " + message;
  } else if (jwt.isNotEmpty && jwt != "null") {
    return jwt;
  } else {
    return "Unknown Error";
  }
}

Future<List<ReviewModel>> getReviewService(String _email) async {
  final queryParameters = {
    "emailCustomer": _email,
  };
  final uri = Uri.http(baseUrl, '/wefix/account/user-reviews', queryParameters);
  final response = await http.get(
    uri,
    //headers: <String, String>{
    //  'Authorization': 'Bearer $_jwt',
    //},
  );

  print(response.body);

  List<ReviewModel> results = json
      .decode(response.body)
      .map<ReviewModel>((data) => ReviewModel.fromJson(data))
      .toList();

  for (ReviewModel result in results) {
    print(result.toString());
  }

  //print("msg:" + response.body.toString());
  return results;
}
