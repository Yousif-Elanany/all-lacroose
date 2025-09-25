class DetailsModel {
  final int id;
  final int langId;
  final String headerLogo;
  final String name;
  final String title;
  final String description;

  // Constructor
  DetailsModel({
    required this.id,
    required this.langId,
    required this.headerLogo,
    required this.name,
    required this.title,
    required this.description,
  });

  // لتحويل JSON إلى كائن Dart
  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      id: json['id'],
      langId: json['langId'],
      headerLogo: json['headerLogo'],
      name: json['name'],
      title: json['title'],
      description: json['description'],
    );
  }

  // لتحويل كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'langId': langId,
      'headerLogo': headerLogo,
      'name': name,
      'title': title,
      'description': description,
    };
  }
}