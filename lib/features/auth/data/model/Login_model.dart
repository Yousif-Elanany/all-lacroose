class LoginModel {
  LoginModel({
    required this.userId,
    required this.displayName,
    required this.image,
    required this.birthDate,
    required this.city,
    required this.area,
    required this.address,
    this.message,
    required this.isAuthenticated,
    required this.email,
    required this.phoneNumber,
    required this.roles,
    required this.accessToken,
    required this.refreshTokenExpiration,
  });
  late final String userId;
  late final String displayName;
  late final String image;
  late final String birthDate;
  late final String city;
  late final String area;
  late final String address;
  late final Null message;
  late final bool isAuthenticated;
  late final String email;
  late final String phoneNumber;
  late final List<String> roles;
  late final String accessToken;
  late final String refreshTokenExpiration;

  LoginModel.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    displayName = json['displayName'] == null?"":json['displayName'];
    image = json['image']??"";
    birthDate = json['birthDate'];
    city = json['city'];
    area = json['area'];
    address = json['address'];
    message = null;
    isAuthenticated = json['isAuthenticated'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    roles = List.castFrom<dynamic, String>(json['roles']);
    accessToken = json['accessToken'];
    refreshTokenExpiration = json['refreshTokenExpiration'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['displayName'] = displayName;
    _data['image'] = image;
    _data['birthDate'] = birthDate;
    _data['city'] = city;
    _data['area'] = area;
    _data['address'] = address;
    _data['message'] = message;
    _data['isAuthenticated'] = isAuthenticated;
    _data['email'] = email;
    _data['phoneNumber'] = phoneNumber;
    _data['roles'] = roles;
    _data['accessToken'] = accessToken;
    _data['refreshTokenExpiration'] = refreshTokenExpiration;
    return _data;
  }
}