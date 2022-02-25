import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/models/product_model.dart';
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

Future<List<ReviewModel>> getReviewService(String _jwt) async {
  print("Calling BE");

  final uri = Uri.http(baseUrl, '/wefix/account/reviews');
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $_jwt',
    },
  );

  print(response.body);

  List<ReviewModel> results = json
      .decode(response.body)
      .map<ReviewModel>((data) => ReviewModel.fromJson(data))
      .toList();

  for (ReviewModel result in results) {
    print(result.toString());
  }

  print("msg:" + response.body.toString());
  return results;
}

//funzione che permette di caricare tutti i prodotti di un certo worker
//SOLO PER LA PAGINA: USER PAGE
Future<List<ProductModel>> getPublicWorkerProductService(
    String _jwt, String _emailWorker) async {
  final queryParameters = {
    "emailWorker": _emailWorker,
  };
  print("Calling BE");

  final uri =
      Uri.http(baseUrl, '/wefix/account/worker-products', queryParameters);
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $_jwt',
    },
  );

  print(response.body);

  List<ProductModel> results = json
      .decode(response.body)
      .map<ProductModel>((data) => ProductModel.fromJson(data))
      .toList();

  for (ProductModel result in results) {
    print(result.toString());
  }

  print("msg:" + response.body.toString());
  return results;
}

//SERVE PER PRENDERE I DATI DI UN WORKER TRA I RISULTATI DI RICERCA
Future<UserModel> getPublicWorkerDataService(
    String _jwt, String _emailWorker) async {
  final queryParameters = {
    "emailWorker": _emailWorker,
  };
  final uri =
      Uri.http(baseUrl, '/wefix/account/worker-profile', queryParameters);
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

//PRENDE LE REVIEW DI UN WORKER DA UN RISULTATO DI RICERCA
Future<List<ReviewModel>> getPublicWorkerReviewService(
    String _jwt, String _emailWorker) async {
  final queryParameters = {
    "emailWorker": _emailWorker,
  };

  print("Calling BE");

  final uri =
      Uri.http(baseUrl, '/wefix/account/worker-reviews', queryParameters);
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $_jwt',
    },
  );

  print(response.body);

  List<ReviewModel> results = json
      .decode(response.body)
      .map<ReviewModel>((data) => ReviewModel.fromJson(data))
      .toList();

  for (ReviewModel result in results) {
    print(result.toString());
  }

  print("msg:" + response.body.toString());
  return results;
}

/*
Future<UserModel> updateProfileService(
    String _jwt, String _firstName, String _secondName, String _bio) async {
  final queryParameters = {
    "firstName": _firstName,
    "secondNe": _secondName,
    "bio": _bio,
  };
  final uri =
      Uri.http(baseUrl, '/wefix/account/update-profile', queryParameters);
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $_jwt',
    },
  );

  Map<String, dynamic> map = json.decode(response.body);
  UserModel result = UserModel.fromJson(map);
  return result;
} */


