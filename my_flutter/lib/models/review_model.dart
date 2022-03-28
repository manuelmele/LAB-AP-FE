import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class ReviewModel {
  final String firstName;
  final String secondName;
  final String contentReview;
  final int star;

  ReviewModel({
    required this.firstName,
    required this.secondName,
    required this.contentReview,
    required this.star,
  });

  factory ReviewModel.fromJson(Map<dynamic, dynamic> data) {
    return ReviewModel(
      firstName: data['firstNameReviewer'],
      secondName: data['lastNameReviewer'],
      contentReview: data['contentReview'],
      star: data['star'],
    );
  }

  @override
  String toString() {
    return "firstName: $firstName, secondName: $secondName, contentReview: $contentReview, star: $star,";
  }
}
