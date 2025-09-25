class TeamMMModel {
  final int id;
  final String img;
  final String name;

  TeamMMModel({required this.id, required this.img, required this.name});

  // تحويل JSON إلى كائن TeamModel
  factory TeamMMModel.fromJson(Map<String, dynamic> json) {
    return TeamMMModel(
      id: json['id'],
      img: json['img'],
      name: json['name'],
    );
  }



}