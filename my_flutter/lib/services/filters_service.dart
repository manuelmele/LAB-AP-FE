// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:wefix/models/user_model.dart';

//[BE] server.port must be localhost:8000
String baseUrl = '10.0.2.2:8000'; //indirizzo per emulatore
//String baseUrl = '192.168.1.9:8000'; //indirizzo IP laura

Future<List<UserModel>> filterByCategory(String _jwt, String _category) async {
  final queryParameters = {
    'category': _category,
  };

  final uri = Uri.http(baseUrl, '/wefix/account/workers', queryParameters);
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $_jwt',
    },
  );

  print(response.body);

  List<UserModel> results = json
      .decode(response.body)
      .map<UserModel>((data) => UserModel.fromJson(data))
      .toList();

  for (UserModel result in results) {
    print(result.toString());
  }

  //print("msg:" + response.body.toString());
  return results;
}
