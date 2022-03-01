import 'dart:ffi';

class MeetingModel {
  final int idMeeting;
  final String firstName;
  final String secondName;
  final String email;
  final String photoProfile;
  final String category;
  final String description;
  final String dateTime;
  final String slotTime;
  final bool? accepted;
  final bool? started;
  final double? lat;
  final double? lng;

  MeetingModel({
    required this.idMeeting,
    required this.firstName,
    required this.secondName,
    required this.email,
    required this.photoProfile,
    required this.category,
    required this.description,
    required this.dateTime,
    required this.slotTime,
    required this.accepted,
    required this.started,
    required this.lat,
    required this.lng,
  });

  factory MeetingModel.fromJson(Map<dynamic, dynamic> data) {
    String defaultAvatarBase64 =
        "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";

    return MeetingModel(
      idMeeting: data['idMeeting'],
      firstName: data['firstName'],
      secondName: data['secondName'],
      email: data['email'],
      photoProfile: data['photoProfile'] ?? defaultAvatarBase64,
      category: data['category'] ?? "Customer",
      description: data['description'],
      dateTime: data['date'],
      slotTime: data['slot_time'],
      accepted: data['accepted'],
      started: data['started'],
      lat: data['latPositionWorker'],
      lng: data['lngPositionWorker'],
    );
  }
}
