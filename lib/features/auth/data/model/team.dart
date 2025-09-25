class TeamModel {
  final int id;
  final String img;
  final String name;

  TeamModel({required this.id, required this.img, required this.name});

  // تحويل JSON إلى كائن TeamModel
  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'],
      img: json['img'],
      name: json['name'],
    );
  }



}