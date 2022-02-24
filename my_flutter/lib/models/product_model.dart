import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class ProductModel {
  final String productId;
  final String image;
  final String price;
  final String description;
  final String title;
  //final int deleted;

  ProductModel({
    required this.productId,
    required this.image,
    required this.price,
    required this.description,
    required this.title,
  });

  factory ProductModel.fromJson(Map<dynamic, dynamic> data) {
    return ProductModel(
      productId: data['productId'],
      image: data['image'],
      price: data['price'],
      description: data['description'],
      title: data['title'],
    );
  }

  @override
  String toString() {
    return "productId: $productId, description: $description, price: $price, title: $title";
  }
}
