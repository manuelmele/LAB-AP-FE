import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class UserModel {
  final String firstName;
  final String secondName;
  final String email;
  final String bio;
  final String photoProfile;
  final String identityCardNumber;
  final String userRole;
  final String category;
  final String piva;

  UserModel({
    required this.firstName,
    required this.secondName,
    required this.email,
    required this.bio,
    required this.photoProfile,
    required this.identityCardNumber,
    required this.userRole,
    required this.category,
    required this.piva,
  });

  factory UserModel.fromJson(Map<dynamic, dynamic> data) {
    return UserModel(
      firstName: data['firstName'],
      secondName: data['secondName'],
      email: data['email'],
      bio: data['bio'] ?? "No description yet.",
      photoProfile: data['photoProfile'] ?? "",
      identityCardNumber: data['identityCardNumber'] ?? "Not provided",
      userRole: data['userRole'],
      category: data['category'] ?? "",
      piva: data['piva'] ?? "Not provided",
    );
  }

  String toString() {
    return "firstName: $firstName, secondName: $secondName, identityCardNumber: $identityCardNumber, category: $category,";
  }
}
