class OrderModel {
  final String id;
  final String displayName;
  final String email;
  final String image;
  final String birthDate;
  final String teamName;
  final String nationalityName;

  OrderModel({
    required this.id,
    required this.email,
    required this.displayName,
    required this.image,
    required this.birthDate,
    required this.teamName,
    required this.nationalityName,
  });

  // Factory constructor to create a OrderModel object from JSON
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      email:json["email"]??'',
      id: json['id'] ?? '',
      displayName: json['displayName'] ?? '',
      image: json['image'] ?? '',
      birthDate: json['birthDate'] ?? '',
      teamName: json['teamName'] ?? '',
      nationalityName: json['nationalityName'] ?? '',
    );
  }

// Method to convert a OrderModelModel object to JSON

}