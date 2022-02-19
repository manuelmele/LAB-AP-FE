import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/models/user_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:wefix/models/user_model.dart';

import '../constants.dart';

//[BE] server.port must be localhost:8000
String baseUrl = BASE_URL;

class Album {
  final String name;
  final String surname;
  final String email;
  final role;

  const Album({
    required this.name,
    required this.surname,
    required this.email,
    required this.role,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    //setUserData(
    //json['firstName'], json['secondName'], json['email'], json['category']);
    return Album(
      name: json['firstName'],
      surname: json['secondName'],
      email: json['email'],
      role: json['category'],
    );
  }

  void setUserData(name, surname, email, role) async {}
}

Future<Album> fetchAlbum() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString('email');
  String? jwt = prefs.getString('jwt');
  final uri = Uri.http(baseUrl, '/wefix/account/profile');
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $jwt',
    },
  );

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

/*
Future<Map<String, String>> getUserDataService(
    String email, String _jwt) async {
  final uri = Uri.http(baseUrl, '/wefix/account/profile');
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $_jwt',
    },
  );

  String name = jsonDecode(response.body)["firstName"].toString();
  String surname = jsonDecode(response.body)["secondName"].toString();
  String role = jsonDecode(response.body)["userRole"].toString();
  String photoProfile = jsonDecode(response.body)["photoProfile"].toString();

  Map<String, String> result = {
    "name": name,
    "surname": surname,
    "role": role,
    "photoProfile": photoProfile,
  };

  //print("msg:" + response.body.toString());
  return result;
}*/
