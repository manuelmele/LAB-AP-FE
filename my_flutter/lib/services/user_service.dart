import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wefix/models/product_model.dart';
import 'package:wefix/models/review_model.dart';
import 'package:wefix/models/user_model.dart';
import 'dart:convert';
import 'package:http_parser/src/media_type.dart';

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

Future<String> updateProfileService(
    String _jwt, String _firstName, String _secondName, String _bio) async {
  final uri = Uri.http(baseUrl, '/wefix/account/update-profile');
  final response = await http.put(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $_jwt',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'firstName': _firstName,
      'secondName': _secondName,
      'bio': _bio,
    }),
  );

  //String message = jsonDecode(response.body)["message"].toString();

  if (response.body.isNotEmpty && response.body != "null") {
    return "Error: " + response.body.toString();
  } else if (response.statusCode == 200) {
    return "";
  } else {
    return "Unknown Error";
  }
}

Future<String> updatePhotoService(String _jwt, XFile? _photoProfile) async {
  final uri = Uri.http(baseUrl, '/wefix/account/update-photo-profile');

  var request = http.MultipartRequest("PUT", uri);
  if (_photoProfile == null) {
  } else {
    request.files.add(http.MultipartFile.fromBytes(
        'photoProfile', File(_photoProfile.path).readAsBytesSync(),
        contentType: MediaType(
            'image', 'jpeg'), //MediaType.parse('multipart/form-data'),
        filename: _photoProfile.path.split("/").last));
  }
  request.headers.addAll({
    'Authorization': "Bearer " + _jwt,
    'Content-Type': 'application/json',
  });

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200) {
    print("Uploaded photo! ");
  } else if (response.statusCode == 400) {
    return 'Error: Operation Failed' +
        jsonDecode(response.body)["message"].toString();
  } else {
    //case statuscode is 403
    return 'Error: Authentication Failure' +
        jsonDecode(response.body)["message"].toString();
  }
  return '';
}

Future<List<ProductModel>> getProductService(String _jwt) async {
  final uri = Uri.http(baseUrl, '/wefix/worker/all-product');
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Authorization': 'Bearer $_jwt',
      'Content-Type': 'application/json',
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

Future<String> insertNewProductService(String _jwt, XFile? _photoProduct,
    String _price, String _description, String _title) async {
  final queryParameters = {
    "price": _price,
    "description": _description,
    "title": _title,
  };

  final uri =
      Uri.http(baseUrl, '/wefix/worker/insert-new-product/', queryParameters);

  var request = http.MultipartRequest("POST", uri);
  if (_photoProduct == null) {
  } else {
    request.files.add(http.MultipartFile.fromBytes(
        'photoProfile', File(_photoProduct.path).readAsBytesSync(),
        contentType: MediaType(
            'image', 'jpeg'), //MediaType.parse('multipart/form-data'),
        filename: _photoProduct.path.split("/").last));
  }
  request.headers.addAll({
    'Authorization': "Bearer " + _jwt,
    'Content-Type': 'application/json',
  });

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200) {
    print("Uploaded product! ");
  } else if (response.statusCode == 400) {
    return 'Error: Operation Failed' +
        jsonDecode(response.body)["message"].toString();
  } else {
    //case statuscode is 403
    return 'Error: Authentication Failure' +
        jsonDecode(response.body)["message"].toString();
  }
  return '';
}
