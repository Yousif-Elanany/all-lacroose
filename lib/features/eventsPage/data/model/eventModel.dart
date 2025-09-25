class AddEventModel {
  int eventType;
  String eventName;
  DateTime from;
  DateTime to;
  String eventLocation;
  String description;
  int firstTeamId;
  int secondTeamId;
  List<ApplicationUserInternalEvent> applicationUserInternalEvents;
  List<InternalEventFile> internalEventFiles;

  AddEventModel({
    required this.eventType,
    required this.eventName,
    required this.from,
    required this.to,
    required this.eventLocation,
    required this.description,
    required this.firstTeamId,
    required this.secondTeamId,
    required this.applicationUserInternalEvents,
    required this.internalEventFiles,
  });

  factory AddEventModel.fromJson(Map<String, dynamic> json) {
    return AddEventModel(
      eventType: json['eventType'],
      eventName: json['eventName'],
      from: DateTime.parse(json['from']),
      to: DateTime.parse(json['to']),
      eventLocation: json['eventLocation'],
      description: json['description'],
      firstTeamId: json['firstTeamId'],
      secondTeamId: json['secondTeamId'],
      applicationUserInternalEvents: (json['applicationUserInternalEvents'] as List)
          .map((e) => ApplicationUserInternalEvent.fromJson(e))
          .toList(),
      internalEventFiles: (json['internalEventFiles'] as List)
          .map((e) => InternalEventFile.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventType': eventType,
      'eventName': eventName,
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'eventLocation': eventLocation,
      'description': description,
      'firstTeamId': firstTeamId,
      'secondTeamId': secondTeamId,
      'applicationUserInternalEvents':
      applicationUserInternalEvents.map((e) => e.toJson()).toList(),
      'internalEventFiles': internalEventFiles.map((e) => e.toJson()).toList(),
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

  factory ApplicationUserInternalEvent.fromJson(Map<String, dynamic> json) {
    return ApplicationUserInternalEvent(
      applicationUserId: json['applicationUserId'],
      internalEventId: json['internalEventId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'applicationUserId': applicationUserId,
      'internalEventId': internalEventId,
    };
  }

}

List<Map<String, dynamic>> toJsonList(List<ApplicationUserInternalEvent> events) {
  return events.map((event) => event.toJson()).toList();
}
List<Map<String, dynamic>> toJsonList2(List<InternalEventFile> events) {
  return events.map((event) => event.toJson()).toList();
}
class InternalEventFile {
  int internalEventId;
  String file;

  InternalEventFile({
    required this.internalEventId,
    required this.file,
  });

  factory InternalEventFile.fromJson(Map<String, dynamic> json) {
    return InternalEventFile(
      internalEventId: json['internalEventId'],
      file: json['file'],
    );
  }
  @override
  String toString() {
    return 'InternalEvent(internalEventId: $internalEventId, file: $file)';
  }
  Map<String, dynamic> toJson() {
    return {
      'internalEventId': internalEventId,
      'file': file,
    };
  }

}