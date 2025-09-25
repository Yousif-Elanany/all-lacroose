import 'dart:convert';

teamModels teamModelFromMap(String str) => teamModels.fromJson(json.decode(str));

String teamModelToMap(teamModels data) => json.encode(data.toMap());

class teamModels
{
  int id;
  String img;
  String name;

  teamModels({
    required this.id,
    required this.img,
    required this.name,
  });

  factory teamModels.fromJson(Map<String, dynamic> json) => teamModels(
    id: json["id"],
    img: json["img"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "img": img,
    "name": name,
  };
}
