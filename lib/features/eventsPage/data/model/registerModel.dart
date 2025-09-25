//
// class RegisterModel {
//   final String? image;
//   final DateTime? birthDate;
//   final String city;
//   final String area;
//   final String address;
//   final String? message;
//   final bool isAuthenticated;
//   final String displayName;
//   final String email;
//   final String phoneNumber;
//   final List<String> roles;
//   final String accessToken;
//   final DateTime refreshTokenExpiration;
//
//   RegisterModel({
//     this.image,
//     this.birthDate,
//     required this.city,
//     required this.area,
//     required this.address,
//     this.message,
//     required this.isAuthenticated,
//     required this.displayName,
//     required this.email,
//     required this.phoneNumber,
//     required this.roles,
//     required this.accessToken,
//     required this.refreshTokenExpiration,
//   });
//
//   // Factory method for creating an instance from JSON
//   factory RegisterModel.fromJson(Map<String, dynamic> json) {
//     return RegisterModel(
//       image: json['image'],
//       birthDate: json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
//       city: json['city'],
//       area: json['area'],
//       address: json['address'],
//       message: json['message'],
//       isAuthenticated: json['isAuthenticated'],
//       displayName: json['displayName'],
//       email: json['email'],
//       phoneNumber: json['phoneNumber'],
//       roles: List<String>.from(json['roles']),
//       accessToken: json['accessToken'],
//       refreshTokenExpiration: DateTime.parse(json['refreshTokenExpiration']),
//     );
//   }
//
//   // Convert instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'image': image,
//       'birthDate': birthDate?.toIso8601String(),
//       'city': city,
//       'area': area,
//       'address': address,
//       'message': message,
//       'isAuthenticated': isAuthenticated,
//       'displayName': displayName,
//       'email': email,
//       'phoneNumber': phoneNumber,
//       'roles': roles,
//       'accessToken': accessToken,
//       'refreshTokenExpiration': refreshTokenExpiration.toIso8601String(),
//     };
//   }
// }