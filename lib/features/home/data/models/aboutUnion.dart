class AboutUnionModel {
  final int id;
  final int langId;
  final String title;
  final String description1;
  final String description2;
  final String description3;
  final String img;

  // Constructor
  AboutUnionModel({
    required this.id,
    required this.langId,
    required this.title,
    required this.description1,
    required this.description2,
    required this.description3,
    required this.img,
  });

  // لتحويل JSON إلى كائن Dart
  factory AboutUnionModel.fromJson(Map<String, dynamic> json) {
    return AboutUnionModel(
      id: json['id'],
      langId: json['langId'],
      title: json['title'],
      description1: json['description1'],
      description2: json['description2'],
      description3: json['description3'],
      img: json['img'],
    );
  }

  // لتحويل كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'langId': langId,
      'title': title,
      'description1': description1,
      'description2': description2,
      'description3': description3,
      'img': img,
    };
  }
}