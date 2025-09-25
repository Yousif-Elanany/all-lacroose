
import 'dart:convert';

UserAttendenceModel userAttendenceModelFromMap(String str) => UserAttendenceModel.fromJson(json.decode(str));

String userAttendenceModelToMap(UserAttendenceModel data) => json.encode(data.toMap());
//
class UserAttendenceModel {
  String id;
  String displayName;
  String image;
  String birthDate;
  String teamName;
  String nationalityName;
  bool? status;
  String ?absenceReason;

  UserAttendenceModel({
    required this.id,
    required this.displayName,
    required this.image,
    required this.birthDate,
    required this.teamName,
    required this.nationalityName,
     this.status,
    this.absenceReason
  });

  factory UserAttendenceModel.fromJson(Map<String, dynamic> json) => UserAttendenceModel(
    id: json["id"],
    displayName: json["displayName"],
    image: json["image"],
    birthDate: json["birthDate"],
    teamName: json["teamName"],
    nationalityName: json["nationalityName"],
    status: json["status"] ?? null,
      absenceReason: json["absenceReason"] ?? null,

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "displayName": displayName,
    "image": image,
    "birthDate": birthDate,
    "teamName": teamName,
    "nationalityName": nationalityName,
    "status": status,
    "absenceReason":absenceReason
  };
}
