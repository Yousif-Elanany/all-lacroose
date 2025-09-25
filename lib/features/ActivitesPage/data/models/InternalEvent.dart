


import 'dart:convert';

InternalEventModel internalEventModelFromMap(String str) => InternalEventModel.fromJson(json.decode(str));

String internalEventModelToMap(InternalEventModel data) => json.encode(data.toMap());

// class InternalEventModel {
//   int id;
//   int eventType;
//   String eventName;
//   DateTime from;
//   DateTime to;
//   String eventLocation;
//   String description;
//   int firstTeamId;
//   String firstTeamName;
//   int secondTeamId;
//   String secondTeamName;
//   List<ApplicationUserInternalEvent> applicationUserInternalEvents;
//   List<InternalEventFile> internalEventFiles;
//
//   InternalEventModel({
//     required this.id,
//     required this.eventType,
//     required this.eventName,
//     required this.from,
//     required this.to,
//     required this.eventLocation,
//     required this.description,
//     required this.firstTeamId,
//     required this.firstTeamName,
//     required this.secondTeamId,
//     required this.secondTeamName,
//     required this.applicationUserInternalEvents,
//     required this.internalEventFiles,
//   });
//
//   factory InternalEventModel.fromJson(Map<String, dynamic> json) => InternalEventModel(
//     id: json["id"],
//     eventType: json["eventType"],
//     eventName: json["eventName"],
//     from: DateTime.parse(json["from"]),
//     to: DateTime.parse(json["to"]),
//     eventLocation: json["eventLocation"],
//     description: json["description"],
//     firstTeamId: json["firstTeamId"]??0,
//     firstTeamName: json["firstTeamName"]??"",
//     secondTeamId: json["secondTeamId"]??0,
//     secondTeamName: json["secondTeamName"]??"",
//
//     applicationUserInternalEvents: List<ApplicationUserInternalEvent>.from(json["applicationUserInternalEvents"]?.map((x) => ApplicationUserInternalEvent.fromMap(x))??[]),
//     internalEventFiles: List<InternalEventFile>.from(json["internalEventFiles"]?.map((x) => InternalEventFile.fromMap(x)))??[],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "eventType": eventType,
//     "eventName": eventName,
//     "from": from.toIso8601String(),
//     "to": to.toIso8601String(),
//     "eventLocation": eventLocation,
//     "description": description,
//     "firstTeamId": firstTeamId,
//     "firstTeamName": firstTeamName,
//     "secondTeamId": secondTeamId,
//     "secondTeamName": secondTeamName,
//     "applicationUserInternalEvents": List<dynamic>.from(applicationUserInternalEvents.map((x) => x.toMap())),
//     "internalEventFiles": List<dynamic>.from(internalEventFiles.map((x) => x.toMap())) ==[]?[]:List<dynamic>.from(internalEventFiles.map((x) => x.toMap())),
//   };
// }
class InternalEventModel {
  final int id;
  final int eventType;
  final String eventName;
  final DateTime from;
  final DateTime to;
  final String eventLocation;
  final String description;
  final int? firstTeamId;
  final String? firstTeamName;
  final int? secondTeamId;
  final String? secondTeamName;
  final List<ApplicationUserInternalEvent> applicationUserInternalEvents;
  final List<InternalEventFile> internalEventFiles;

  InternalEventModel({
    required this.id,
    required this.eventType,
    required this.eventName,
    required this.from,
    required this.to,
    required this.eventLocation,
    required this.description,
    this.firstTeamId,
    this.firstTeamName,
    this.secondTeamId,
    this.secondTeamName,
    required this.applicationUserInternalEvents,
    required this.internalEventFiles,
  });

  /// **إنشاء كائن من JSON مع التعامل مع الحقول غير الموجودة بأمان**
  factory InternalEventModel.fromJson(Map<String, dynamic> json) {
    return InternalEventModel(
      id: json["id"] ?? 0, // إذا لم يكن موجودًا، نضع قيمة افتراضية
      eventType: json["eventType"] ?? 0,
      eventName: json["eventName"] ?? "Unknown Event",
      from: json["from"] != null ? DateTime.parse(json["from"]) : DateTime.now(),
      to: json["to"] != null ? DateTime.parse(json["to"]) : DateTime.now(),
      eventLocation: json["eventLocation"] ?? "Unknown Location",
      description: json["description"] ?? "No Description",
      firstTeamId: json.containsKey("firstTeamId") ? json["firstTeamId"] : null,
      firstTeamName: json.containsKey("firstTeamName") ? json["firstTeamName"] : null,
      secondTeamId: json.containsKey("secondTeamId") ? json["secondTeamId"] : null,
      secondTeamName: json.containsKey("secondTeamName") ? json["secondTeamName"] : null,
      applicationUserInternalEvents: (json["applicationUserInternalEvents"] as List?)
          ?.map((x) => ApplicationUserInternalEvent.fromMap(x))
          .toList() ??
          [],
      internalEventFiles: (json["internalEventFiles"] as List?)
          ?.map((x) => InternalEventFile.fromMap(x))
          .toList() ??
          [],
    );
  }

  /// **تحويل الكائن إلى JSON مع تجاهل القيم غير الموجودة**
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "eventType": eventType,
      "eventName": eventName,
      "from": from.toIso8601String(),
      "to": to.toIso8601String(),
      "eventLocation": eventLocation,
      "description": description,
      if (firstTeamId != null) "firstTeamId": firstTeamId,
      if (firstTeamName != null) "firstTeamName": firstTeamName,
      if (secondTeamId != null) "secondTeamId": secondTeamId,
      if (secondTeamName != null) "secondTeamName": secondTeamName,
      "applicationUserInternalEvents":
      applicationUserInternalEvents.map((x) => x.toMap()).toList(),
      "internalEventFiles": internalEventFiles.map((x) => x.toMap()).toList(),
    };
  }
}

class ApplicationUserInternalEvent {
  String applicationUserId;
  int internalEventId;

  ApplicationUserInternalEvent({
    required this.applicationUserId,
    required this.internalEventId,
  });

  factory ApplicationUserInternalEvent.fromMap(Map<String, dynamic> json) => ApplicationUserInternalEvent(
    applicationUserId: json["applicationUserId"]??"",
    internalEventId: json["internalEventId"]??0,
  );

  Map<String, dynamic> toMap() => {
    "applicationUserId": applicationUserId,
    "internalEventId": internalEventId,
  };
}

class InternalEventFile {
  int id;
  int internalEventId;
  String file;

  InternalEventFile({
    required this.id,
    required this.internalEventId,
    required this.file,
  });

  factory InternalEventFile.fromMap(Map<String, dynamic> json) => InternalEventFile(
    id: json["id"]??0,
    internalEventId: json["internalEventId"]??0,
    file: json["file"]??"" ,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "internalEventId": internalEventId,
    "file": file,
  };
}
//
// class InternalEventModel {
//   final int id;
//   final int eventType;
//   final String eventName;
//   final DateTime from;
//   final DateTime to;
//   final String eventLocation;
//   final String description;
//   final int firstTeamId;
//   final String firstTeamName;
//   final int secondTeamId;
//   final String secondTeamName;
//   final List<ApplicationUserInternalEvent> applicationUserInternalEvents;
//   final List<InternalEventFile> internalEventFiles;
//
//   InternalEventModel({
//     required this.id,
//     required this.eventType,
//     required this.eventName,
//     required this.from,
//     required this.to,
//     required this.eventLocation,
//     required this.description,
//     required this.firstTeamId,
//     required this.firstTeamName,
//     required this.secondTeamId,
//     required this.secondTeamName,
//     required this.applicationUserInternalEvents,
//     required this.internalEventFiles,
//   });
//
//   factory InternalEventModel.fromJson(Map<String, dynamic> json) {
//     return InternalEventModel(
//       id: json['id'],
//       eventType: json['eventType'],
//       eventName: json['eventName'],
//       from: DateTime.parse(json['from']),
//       to: DateTime.parse(json['to']),
//       eventLocation: json['eventLocation'],
//       description: json['description'],
//       firstTeamId: json['firstTeamId'],
//       firstTeamName: json['firstTeamName'],
//       secondTeamId: json['secondTeamId'],
//       secondTeamName: json['secondTeamName'],
//       applicationUserInternalEvents: (json['applicationUserInternalEvents'] as List)
//           .map((item) => ApplicationUserInternalEvent.fromJson(item))
//           .toList(),
//       internalEventFiles: (json['internalEventFiles'] as List)
//           .map((item) => InternalEventFile.fromJson(item))
//           .toList(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'eventType': eventType,
//       'eventName': eventName,
//       'from': from.toIso8601String(),
//       'to': to.toIso8601String(),
//       'eventLocation': eventLocation,
//       'description': description,
//       'firstTeamId': firstTeamId,
//       'firstTeamName': firstTeamName,
//       'secondTeamId': secondTeamId,
//       'secondTeamName': secondTeamName,
//       'applicationUserInternalEvents': applicationUserInternalEvents.map((e) => e.toJson()).toList(),
//       'internalEventFiles': internalEventFiles.map((e) => e.toJson()).toList(),
//     };
//   }
// }
//
// class ApplicationUserInternalEvent {
//   final String applicationUserId;
//   final int internalEventId;
//
//   ApplicationUserInternalEvent({
//     required this.applicationUserId,
//     required this.internalEventId,
//   });
//
//   factory ApplicationUserInternalEvent.fromJson(Map<String, dynamic> json) {
//     return ApplicationUserInternalEvent(
//       applicationUserId: json['applicationUserId'],
//       internalEventId: json['internalEventId'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'applicationUserId': applicationUserId,
//       'internalEventId': internalEventId,
//     };
//   }
// }
//
// class InternalEventFile {
//   // Add properties based on the actual structure of internalEventFiles if needed.
//   final String? filePath; // Example property
//
//   InternalEventFile({this.filePath});
//
//   factory InternalEventFile.fromJson(Map<String, dynamic> json) {
//     return InternalEventFile(
//       filePath: json['filePath'] ?? '', // Replace with the actual key
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'filePath': filePath, // Replace with the actual key
//     };
//   }
// }