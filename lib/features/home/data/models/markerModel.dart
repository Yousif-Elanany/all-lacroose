
class LocationMarkerModel {
  final int id;
  final String name;
  final double longitude;
  final double latitude;
  final double distance;

  LocationMarkerModel({
    required this.id,
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.distance,
  });

  // Convert JSON to Dart object
  factory LocationMarkerModel.fromJson(Map<String, dynamic> json) {
    return LocationMarkerModel(
      id: json['id'],
      name: json['name'],
      longitude: double.parse(json['longitude']), // Convert from String to double
      latitude: double.parse(json['latitude']),   // Convert from String to double
      distance: json['distance'],
    );
  }

  // Convert Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'longitude': longitude,
      'latitude': latitude,
      'distance': distance,
    };
  }
}