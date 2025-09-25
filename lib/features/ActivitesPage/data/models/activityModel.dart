// To parse this JSON data, do
//
//     final eventModel = eventModelFromMap(jsonString);

import 'dart:convert';

EventModel eventModelFromMap(String str) => EventModel.fromJson(json.decode(str));

String eventModelToMap(EventModel data) => json.encode(data.toMap());

class EventModel {
  int id;
  int langId;
  String name;
  String img;
  String location;
  String description;
  String notes;
  String mapLink;
  String fromDay;
  String toDay;
  String fromTime;
  String toTime;

  EventModel({
    required this.id,
    required this.langId,
    required this.name,
    required this.img,
    required this.location,
    required this.description,
    required this.notes,
    required this.mapLink,
    required this.fromDay,
    required this.toDay,
    required this.fromTime,
    required this.toTime,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    id: json["id"],
    langId: json["langId"],
    name: json["name"],
    img: json["img"],
    location: json["location"],
    description: json["description"],
    notes: json["notes"],
    mapLink: json["mapLink"],
    fromDay: json["fromDay"],
    toDay: json["toDay"],
    fromTime: json["fromTime"],
    toTime: json["toTime"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "langId": langId,
    "name": name,
    "img": img,
    "location": location,
    "description": description,
    "notes": notes,
    "mapLink": mapLink,
    "fromDay":fromDay,
    "toDay": toDay,
    "fromTime": fromTime,
    "toTime": toTime,
  };
}
