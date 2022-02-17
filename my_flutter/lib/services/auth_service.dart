// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:http_parser/http_parser.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

//[BE] server.port must be localhost:8000
//String baseUrl = '10.0.2.2:8000'; //indirizzo per emulatore
String baseUrl = '192.168.1.9:8000'; //indirizzo IP laura

Future<String> signUpService(String _firstName, String _secondName,
    String _email, String _userPassword, String _userConfirmPassword) async {
  final uri = Uri.http(baseUrl, '/wefix/public/signup');

  final response = await http.post(
    uri,
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

Future<String> completeSignUpService(
    String _bio, XFile _photoProfile, String _jwt) async {
  final queryParameters = {'bio': _bio};

  final uri =
      Uri.http(baseUrl, '/wefix/account/complete/signup/', queryParameters);

  var request = http.MultipartRequest("PUT", uri);
  request.files.add(http.MultipartFile.fromBytes(
      'photoProfile', File(_photoProfile.path).readAsBytesSync(),
      contentType:
          MediaType('image', 'jpeg'), //MediaType.parse('multipart/form-data'),
      filename: _photoProfile.path.split("/").last));
  request.headers.addAll({
    'Authorization': "Bearer " + _jwt,
  });

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200) {
    print("Uploaded! ");
  } else if (response.statusCode == 500) {
    return 'Error: Image should have maximum size 30KB'; //vedere con mario come gestire meglio questo caso
  } else {
    return 'Error: ' + jsonDecode(response.body)["message"].toString();
  }
  return '';
}

Future<String> signInService(String _email, String _password) async {
  final queryParameters = {
    'email': _email,
    'password': _password,
  };

  final uri = Uri.http(baseUrl, '/wefix/public/login', queryParameters);
  final response = await http.post(
    uri,
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
