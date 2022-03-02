import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/models/payment_model.dart';
import 'package:wefix/models/user_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:wefix/models/review_model.dart';

import '../constants.dart';

//[BE] server.port must be localhost:8000
String baseUrl = BASE_URL;

Future<List<PaymentModel>> getPaymentsDataService(String _jwt) async {
  final uri = Uri.http(baseUrl, '/wefix/worker/all-payments');
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $_jwt',
    },
  );

  //print(response.body);

  List<PaymentModel> results = json
      .decode(response.body)
      .map<PaymentModel>((data) => PaymentModel.fromJson(data))
      .toList();

  for (PaymentModel result in results) {
    print(result.toString());
  }

  //print("msg:" + response.body.toString());
  return results;
}

//SERVE PER PRENDERE I DATI DI UN WORKER TRA I RISULTATI DI RICERCA
Future<UserModel> getPublicCustomerDataService(
    String _jwt, String _emailCustomer) async {
  final queryParameters = {
    "emailCustomer": _emailCustomer,
  };
  final uri = Uri.http(baseUrl, '/wefix/worker/get-user-info',
      queryParameters); // cambiare la URL
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
Future<List<ReviewModel>> getPublicCustomerReviewService(
    String _jwt, String _emailCustomer) async {
  final queryParameters = {
    "emailCustomer": _emailCustomer,
  };

  print("Calling BE");

  final uri = Uri.http(baseUrl, '/wefix/account/user-reviews', queryParameters);
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
