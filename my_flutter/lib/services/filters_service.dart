// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:wefix/models/user_model.dart';

import '../constants.dart';

String baseUrl = BASE_URL;

Future<List<UserModel>> filterByCategory(String _jwt, String _category) async {
  return filterByQuery(_jwt, "", _category);
}

Future<List<UserModel>> filterByQuery(
    String _jwt, String _value, String _category) async {
  final queryParameters = {
    'value': _value,
    'category': _category,
  };

  final uri =
      Uri.http(baseUrl, '/wefix/account/workers-filter', queryParameters);
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $_jwt',
    },
  );

  //print(response.body);

  List<UserModel> results = json
      .decode(response.body)
      .map<UserModel>((data) => UserModel.fromJson(data))
      .toList();

  //for (UserModel result in results) {
  //  print(result.toString());
  //}

  //print("msg:" + response.body.toString());
  return results;
}
