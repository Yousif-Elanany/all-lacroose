class ReservationModel {
  final List<Reservation> reservations;
  final int countOfParticipants;

  ReservationModel({
    required this.reservations,
    required this.countOfParticipants,
  });

  // تحويل JSON إلى كائن Dart
  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      reservations: (json['reservations'] as List<dynamic>?)
          ?.map((item) => Reservation.fromJson(item))
          .toList() ??
          [], // تأكد من عدم حدوث Null
      countOfParticipants: json['countOfParticipants'] ?? 0,
    );
  }

  // تحويل كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'reservations': reservations.map((item) => item.toJson()).toList(),
      'countOfParticipants': countOfParticipants,
    };
  }
}

class Reservation {
  final String name;
  final String phoneNumber;

  Reservation({
    required this.name,
    required this.phoneNumber,
  });

  // تحويل JSON إلى كائن Dart
  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      name: json['name'] ?? 'غير معروف', // معالجة null
      phoneNumber: json['phoneNumber'] ?? 'غير متوفر', // معالجة null
    );
  }

  // تحويل كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }
}