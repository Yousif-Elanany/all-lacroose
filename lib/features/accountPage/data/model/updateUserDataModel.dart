
class UserUpdateDataModel {
  final String? image;
  final String? displayName;
  final String? phoneNumber;

  UserUpdateDataModel({
    this.image,
    this.displayName,
    this.phoneNumber,
  });

  // Factory constructor to create an instance from JSON
  factory UserUpdateDataModel.fromJson(Map<String, dynamic> json) {
    return UserUpdateDataModel(
      image: json['image'], // Nullable, so no default value needed
      displayName: json['displayName'],
      phoneNumber: json['phoneNumber'],
    );
  }

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
    };
  }
}