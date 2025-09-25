// To parse this JSON data, do
//
//     final matchModel = matchModelFromJson(jsonString);

import 'dart:convert';

MatchModel matchModelFromJson(String str) => MatchModel.fromJson(json.decode(str));

String matchModelToJson(MatchModel data) => json.encode(data.toJson());

class MatchModel {
  int id;
  DateTime appointment;
  String firstTeamName;
  String firstTeamImage;
  String totalFirstTeamGoals;
  String secondTeamName;
  String secondTeamImage;
  String totalSecondTeamGoals;

  MatchModel({
    required this.id,
    required this.appointment,
    required this.firstTeamName,
    required this.firstTeamImage,
    required this.totalFirstTeamGoals,
    required this.secondTeamName,
    required this.secondTeamImage,
    required this.totalSecondTeamGoals,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
    id: json["id"],
    appointment: DateTime.parse(json["appointment"]),
    firstTeamName: json["firstTeamName"],
    firstTeamImage: json["firstTeamImage"],
    totalFirstTeamGoals: json["totalFirstTeamGoals"]??"",
    secondTeamName: json["secondTeamName"]??"",
    secondTeamImage: json["secondTeamImage"]??"",
    totalSecondTeamGoals: json["totalSecondTeamGoals"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "appointment": appointment.toIso8601String(),
    "firstTeamName": firstTeamName,
    "firstTeamImage": firstTeamImage,
    "totalFirstTeamGoals": totalFirstTeamGoals,
    "secondTeamName": secondTeamName,
    "secondTeamImage": secondTeamImage,
    "totalSecondTeamGoals": totalSecondTeamGoals,
  };
}
