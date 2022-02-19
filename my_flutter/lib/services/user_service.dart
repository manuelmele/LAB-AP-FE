import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/models/user_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:wefix/models/user_model.dart';

//[BE] server.port must be localhost:8000
//String baseUrl = '10.0.2.2:8000'; //indirizzo per emulatore
String baseUrl = '192.168.1.9:8000'; //indirizzo IP laura

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

/*
  UserModel result = json.decode(response.body).map<UserModel>(
      UserModel.fromJson(response)); //.map((data) => UserModel.fromJson(data));
*/
  //print(result.toString());

  //print("msg:" + response.body.toString());
  return result;
}


/* //PARTE DI CODICE CHE SERVE PER L'IMPLEMENTAZIONE CON FUTURE ALBUM
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
*/

/* // BOH MI SA CHE NON FUNZIONA
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
