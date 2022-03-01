import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/models/payment_model.dart';
import 'package:wefix/models/user_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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



 Future<String> renewPaymentService(
    String price, 
    String currency,
    String jwt,
  ) async {
    final queryParameters = {
    "price": price,
    'currency': currency,
  };

  final uri =
      Uri.http(baseUrl, '/wefix/worker/payment', queryParameters);

   final response = await http.post(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $jwt',
    },
    /*body: jsonEncode(<String, dynamic>{
      'currency': currency,
      'price': price,
    }),*/
  );
  if (response.statusCode == 200) {
    print("Upgrade to PRO successed!");
    print(response.body.substring(9));
    //eturn "";
    return response.body.substring(9);
  } else {
    return 'Error: ' + jsonDecode(response.body)["message"].toString();
  }
}


