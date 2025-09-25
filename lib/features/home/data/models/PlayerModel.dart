class PlayerModel {
  String id;
  String displayName;
  String image;
  String birthDate;
  String nameOfTeam;
  String nameOfNationality;
  String city;
  String email;
  String area;
  String address;
  int userType;
  int teamId;
  int nationalityId;

  PlayerModel({
    required this.id,
    required this.displayName,
    required this.birthDate,
    required this.image,
    required this.nameOfTeam,
    required this.nameOfNationality,
    required this.city,
    required this.email,
    required this.area,
    required this.address,
    required this.userType,
    required this.teamId,
    required this.nationalityId,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'] ?? "",
      displayName: json['displayName'] ?? "empty",
      image: json['image'] ?? "",
      birthDate: json['birthDate'] ?? "",
      nameOfTeam: json['nameOfTeam'] ?? "",
      nameOfNationality: json['nameOfNationality'] ?? "",
      city: json['city'] ?? "",
      email: json['email'] ?? "",
      area: json['area'] ?? "",
      address: json['address'] ?? "",
      userType: json['userType'] ?? 0,
      teamId: json['teamId'] ?? 0,
      nationalityId: json['nationalityId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "displayName": displayName,
      "image": image,
      "birthDate": birthDate,
      "nameOfTeam": nameOfTeam,
      "nameOfNationality": nameOfNationality,
      "city": city,
      "email": email,
      "area": area,
      "address": address,
      "userType": userType,
      "teamId": teamId,
      "nationalityId": nationalityId,
    };
  }

  PlayerModel copyWith({
    String? id,
    String? displayName,
    String? image,
    String? birthDate,
    String? nameOfTeam,
    String? nameOfNationality,
    String? city,
    String? email,
    String? area,
    String? address,
    int? userType,
    int? teamId,
    int? nationalityId,
  }) {
    return PlayerModel(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      image: image ?? this.image,
      birthDate: birthDate ?? this.birthDate,
      nameOfTeam: nameOfTeam ?? this.nameOfTeam,
      nameOfNationality: nameOfNationality ?? this.nameOfNationality,
      city: city ?? this.city,
      email: email ?? this.email,
      area: area ?? this.area,
      address: address ?? this.address,
      userType: userType ?? this.userType,
      teamId: teamId ?? this.teamId,
      nationalityId: nationalityId ?? this.nationalityId,
    );
  }
}
