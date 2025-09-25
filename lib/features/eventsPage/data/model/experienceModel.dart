class ExperiencesModel {
  final int id;
  final String name;
  final String appointment;
  final String fromTime;
  final String toTime;
  final double longitude;
  final double latitude;
  final int reservationCount;

  ExperiencesModel({
    required this.id,
    required this.name,
    required this.appointment,
    required this.fromTime,
    required this.toTime,
    required this.longitude,
    required this.latitude,
    required this.reservationCount,
  });

  // تحويل JSON إلى كائن Dart مع معالجة القيم null
  factory ExperiencesModel.fromJson(Map<String, dynamic> json) {
    return ExperiencesModel(
      id: json['id'] ?? 0, // إذا كان `null` يتم تعيين 0 كقيمة افتراضية
      name: json['name'] ?? 'غير معروف', // نص افتراضي عند عدم توفر الاسم
      appointment: json['appointment'] ?? 'غير محدد',
      fromTime: json['fromTime'] ?? '00:00',
      toTime: json['toTime'] ?? '00:00',
      longitude: json['longitude'] != null ? double.tryParse(json['longitude'].toString()) ?? 0.0 : 0.0,
      latitude: json['latitude'] != null ? double.tryParse(json['latitude'].toString()) ?? 0.0 : 0.0,
      reservationCount: json['reservationCount'] ?? 0,
    );
  }

  // تحويل كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'appointment': appointment,
      'fromTime': fromTime,
      'toTime': toTime,
      'longitude': longitude.toString(),
      'latitude': latitude.toString(),
      'reservationCount': reservationCount,
    };
  }
}