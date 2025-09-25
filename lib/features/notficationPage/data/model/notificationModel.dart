class NotificationModel {
  final int id;
  final String title;
   String email;
  final String body;
  final int isActive;
  final bool isRead;
  final DateTime sendingOn;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
    required this.isActive,
    required this.sendingOn,
    required this.email
  });

  // لتحويل JSON إلى كائن Dart
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      isActive: json['isActive']??0,
      email: json['email']??'',
      body: json['body'],
      isRead: json['isRead'],
      sendingOn: DateTime.parse(json['sendingOn']),
    );
  }


}