import 'dart:convert';

import 'package:http/http.dart' as http;
import '../constants.dart';

String baseUrl = BASE_URL;

void addReview(String _jwt, String emailReceive, String contentReview,
    int starNumber) async {
  final uri = Uri.http(baseUrl, '/wefix/account/add-review');
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_jwt',
    },
    body: jsonEncode(<String, String>{
      'email_receive': emailReceive,
      'content': contentReview,
      'star': starNumber.toString(),
    }),
  );

  //print(response.body);

  if (response.statusCode == 200) {
    print("Ok! Review sent");
  } else {
    print("Unable to send review");
  }
}
