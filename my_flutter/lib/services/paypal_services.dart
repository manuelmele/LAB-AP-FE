import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http_auth/http_auth.dart';

class PaypalServices {
  String domain = "https://api-m.sandbox.paypal.com"; // for sandbox mode
//  String domain = "https://api.paypal.com"; // for production mode

  // change clientId and secret with your own, provided by paypal
  String clientId =
      'AR0ie5ayCwnX_YxKQAXZs_EZfzbmRAIvwoBuioAnU_Qafjklm6-A0dDwazaDt4RyAJAs2ck-advTtwn9';
  String secret =
      'EEItr4S_7WhNVnGnKV6hflXGpRuVB6j1dhe76RkhUtm3eEvZpMWeKq-98veu20uS275NKpMO-jVGBgaW';

  // for getting the access token from Paypal
  Future<String> getAccessToken() async {
    print("provo a prendere access token");
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post(
          Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials'));
      print(response.body);
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        print(body["access_token"]);
        return body["access_token"];
      }
      return Future.value(null);
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>> createPaypalPayment(
      transactions, accessToken) async {
    print("inizio createPaypalPayment");
    print(convert.jsonEncode(transactions).toString());
    try {
      var response = await http.post(Uri.parse("$domain/v2/payments/payment"),
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });
      print("ho fatto la post");
      print(response.body);

      final body = convert.jsonDecode(response.body);
      print(body);
      if (response.statusCode == 201) {
        print("status code 201");
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return Future.value(null);
      } else {
        print("ho un problema");
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<String> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return body["id"];
      }
      return Future.value(null);
    } catch (e) {
      rethrow;
    }
  }
}
