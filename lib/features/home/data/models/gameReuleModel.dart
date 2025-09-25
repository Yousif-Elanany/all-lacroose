class GameRuleModel {
  final int id;
  final int langId;
  final String header;
  final String content;

  // Constructor
  GameRuleModel({
    required this.id,
    required this.langId,
    required this.header,
    required this.content,
  });

  // لتحويل JSON إلى كائن Dart
  factory GameRuleModel.fromJson(Map<String, dynamic> json) {
    return GameRuleModel(
      id: json['id'],
      langId: json['langId'],
      header: json['header'],
      content: json['content'],
    );
  }

  // لتحويل كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'langId': langId,
      'header': header,
      'content': content,
    };
  }
}