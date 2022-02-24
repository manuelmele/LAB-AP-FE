import 'package:shared_preferences/shared_preferences.dart';
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

Future<String> bookAppointmentService(
    String _emailWorker,
    String _emailCustomer,
    String _date,
    String _timeSlot,
    String _description,
    String _jwt) async {
  final uri = Uri.http(baseUrl, '/wefix/account/add-meeting');

  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_jwt',
    },
    body: jsonEncode(<String, String>{
      'emailWorker': _emailWorker,
      'emailCustomer': _emailCustomer,
      'description': _description,
      'date': _date,
      'slot_time': _timeSlot,
    }),
  );
  if (response.statusCode == 200) {
    print("appointment booked!");
    return "";
  } else {
    return 'Error: ' + jsonDecode(response.body)["message"].toString();
  }
}

  Future<String> UpgradeToProService(
    String _chosenCategory,
    String partita_iva, 
    String identity_card,
    String price, 
    String currency,
    String jwt,
  ) async {

  final uri =
      Uri.http(baseUrl, '/wefix/account/upgrade-pro');

   final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    },
    body: jsonEncode(<String, String>{
      'category': _chosenCategory,
      'currency': currency,
      'price': price,
      'identityCard': identity_card,
      'piva': partita_iva,
    }),
  );
  if (response.statusCode == 200) {
    print("Upgrade to PRO successed!");
    print(response.body.substring(9));
    return response.body.substring(9);
  } else {
    return 'Error: ' + jsonDecode(response.body)["message"].toString();
  }
}
