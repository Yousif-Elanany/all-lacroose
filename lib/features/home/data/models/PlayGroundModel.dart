// To parse this JSON data, do
//
//     final playGroundModel = playGroundModelFromJson(jsonString);

import 'dart:convert';

PlayGroundModel playGroundModelFromJson(String str) => PlayGroundModel.fromJson(json.decode(str));

String playGroundModelToJson(PlayGroundModel data) => json.encode(data.toJson());

class PlayGroundModel {
  int id;
  String name;
  String longitude;
  String latitude;

  PlayGroundModel({
    required this.id,
    required this.name,
    required this.longitude,
    required this.latitude,
  });

  factory PlayGroundModel.fromJson(Map<String, dynamic> json) => PlayGroundModel(
    id: json["id"],
    name: json["name"],
    longitude: json["longitude"],
    latitude: json["latitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "longitude": longitude,
    "latitude": latitude,
  };
}
