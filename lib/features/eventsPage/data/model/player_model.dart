class PlayerModel {
  String id;
  String displayName;
  String image;
  String nameOfTeam;
  String nameOfNationality;
  String city;

  PlayerModel({
    required this.id,
    required this.displayName,
    required this.image,
    required this.nameOfTeam,
    required this.nameOfNationality,
    required this.city,
  });



  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'],
      displayName: json['displayName']??"empty",
      image: json['image']??"",
      nameOfTeam: json['nameOfTeam'],
      nameOfNationality: json['nameOfNationality'],
      city: json['city'],
    );
  }


}