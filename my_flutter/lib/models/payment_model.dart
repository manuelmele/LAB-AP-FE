import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class PaymentModel {
  final String paymentId;
  final String date;
  final String deadline;
  final String price;
  final String currency;
  final String paymentMethod;

  PaymentModel({
    required this.paymentId,
    required this.date,
    required this.deadline,
    required this.price,
    required this.currency,
    required this.paymentMethod,
  });

  factory PaymentModel.fromJson(Map<dynamic, dynamic> data) {
    return PaymentModel(
      paymentId: data['paymentId'],
      date: data['date'],
      deadline: data['deadline'],
      price: data['price'],
      currency: data['currency'],
      paymentMethod: data['paymentMethod'],
    );
  }

  @override
  String toString() {
    return "id: $paymentId, date: $date, price: $price, currency: $currency, paymentMethod: $paymentMethod";
  }
}
