// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  String image;
  String displayName;
  String email;
  String phoneNumber;
  String birthDate;
  String city;
  String area;
  String address;
  int nationalityId;
  dynamic teamId;

  UserInfoModel({
    required this.image,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.birthDate,
    required this.city,
    required this.area,
    required this.address,
    required this.nationalityId,
    required this.teamId,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    image: json["image"]??"",
    displayName: json["displayName"]??"",
    email: json["email"]??"",
    phoneNumber: json["phoneNumber"]??"",
    birthDate: json["birthDate"]??"",
    city: json["city"]??"",
    area: json["area"]??"",
    address: json["address"]??"",
    nationalityId: json["nationalityId"]??0,
    teamId: json["teamId"]??"",
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "displayName": displayName,
    "email": email,
    "phoneNumber": phoneNumber,
    "birthDate": birthDate  ,
    "city": city,
    "area": area,
    "address": address,
    "nationalityId": nationalityId,
    "teamId": teamId,
  };
}
