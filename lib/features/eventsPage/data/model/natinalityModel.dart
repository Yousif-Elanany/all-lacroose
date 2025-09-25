class NationalityModel {
  final int id;
  final String nationalityName;

  NationalityModel({required this.id, required this.nationalityName});

  // لتحويل JSON إلى كائن
  factory NationalityModel.fromJson(Map<String, dynamic> json) {
    return NationalityModel(
      id: json['id'],
      nationalityName: json['nationalityName'],
    );
  }



}