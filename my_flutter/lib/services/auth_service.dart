// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:http/http.dart' as http;

//[BE] server.port must be localhost:8000

Future<String> signUpService(String _firstName, String _secondName,
    String _email, String _userPassword, String _userConfirmPassword) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8000/wefix/public/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'firstName': _firstName,
      'secondName': _secondName,
      'email': _email,
      'userPassword': _userPassword,
      'userConfirmPassword': _userConfirmPassword,
    }),
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
