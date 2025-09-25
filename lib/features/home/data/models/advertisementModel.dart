class AdvertisementModel {
  final int id;
  final int langId;
  final String img;

  // Constructor
  AdvertisementModel({
    required this.id,
    required this.langId,
    required this.img,
  });

  // لتحويل JSON إلى كائن Dart
  factory AdvertisementModel.fromJson(Map<String, dynamic> json) {
    return AdvertisementModel(
      id: json['id'],
      langId: json['langId'],
      img: json['img'],
    );
  }


}