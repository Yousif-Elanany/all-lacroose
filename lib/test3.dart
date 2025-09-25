// // import 'dart:async';
// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// // import 'package:http/http.dart' as http;
// //
// // class MapScreen extends StatefulWidget {
// //   @override
// //   _MapScreenState createState() => _MapScreenState();
// // }
// //
// // class _MapScreenState extends State<MapScreen> {
// //   final Completer<GoogleMapController> _controller = Completer();
// //   // static const String googleApiKey = "YOUR_GOOGLE_MAPS_API_KEY";
// //   final String googleApiKey = "AIzaSyDTOoZf6ITSMREBuaQezlCV5FoxAYyeMuE";
// //   LatLng? _currentLocation;
// //   LatLng _destination = LatLng(30.0444, 31.2357); // القاهرة كمثال
// //
// //   Set<Marker> _markers = {};
// //   Set<Polyline> _polylines = {};
// //   List<LatLng> _routeCoords = [];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _getCurrentLocation();
// //   }
// //
// //   /// 🔹 الحصول على الموقع الحالي
// //   Future<void> _getCurrentLocation() async {
// //     bool serviceEnabled;
// //     LocationPermission permission;
// //
// //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       return;
// //     }
// //
// //     permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         return;
// //       }
// //     }
// //
// //     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
// //     setState(() {
// //       _currentLocation = LatLng(position.latitude, position.longitude);
// //       _markers.add(Marker(
// //         markerId: MarkerId("current"),
// //         position: _currentLocation!,
// //         infoWindow: InfoWindow(title: "موقعي الحالي"),
// //         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
// //       ));
// //       _markers.add(Marker(
// //         markerId: MarkerId("destination"),
// //         position: _destination,
// //         infoWindow: InfoWindow(title: "الوجهة"),
// //         icon: BitmapDescriptor.defaultMarker,
// //       ));
// //     });
// //
// //     _getRoute();
// //   }
// //
// //   /// 🔹 جلب المسار بين الموقع الحالي والوجهة
// //   Future<void> _getRoute() async {
// //     String url =
// //         "https://maps.googleapis.com/maps/api/directions/json?origin=${_currentLocation!.latitude},${_currentLocation!.longitude}&destination=${_destination.latitude},${_destination.longitude}&key=$googleApiKey";
// //
// //     final response = await http.get(Uri.parse(url));
// //     print("Response status: ${response.statusCode}");
// //     print("Response body: ${response.body}");
// //
// //     if (response.statusCode == 200) {
// //       Map<String, dynamic> data = jsonDecode(response.body);
// //
// //       if (data["routes"].isEmpty) {
// //         print("❌ لم يتم العثور على مسار بين النقاط!");
// //         return;
// //       }
// //
// //       String encodedPolyline = data["routes"][0]["overview_polyline"]["points"];
// //
// //       PolylinePoints polylinePoints = PolylinePoints();
// //       List<PointLatLng> result = polylinePoints.decodePolyline(encodedPolyline);
// //
// //       _routeCoords.clear();
// //       for (var point in result) {
// //         _routeCoords.add(LatLng(point.latitude, point.longitude));
// //       }
// //
// //       setState(() {
// //         _polylines.add(Polyline(
// //           polylineId: PolylineId("route"),
// //           color: Colors.blue,
// //           width: 5,
// //           points: _routeCoords,
// //         ));
// //       });
// //     } else {
// //       print("❌ خطأ في API: ${response.body}");
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("التوجيه على الخريطة")),
// //       body: _currentLocation == null
// //           ? Center(child: CircularProgressIndicator())
// //           : GoogleMap(
// //         mapType: MapType.normal,
// //         initialCameraPosition: CameraPosition(
// //           target: _currentLocation!,
// //           zoom: 14.0,
// //         ),
// //         markers: _markers,
// //         polylines: _polylines,
// //         onMapCreated: (GoogleMapController controller) {
// //           _controller.complete(controller);
// //         },
// //       ),
// //     );
// //   }
// // }
// //////////////////////////////
// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//
// class LiveTrackingMap extends StatefulWidget {
//   @override
//   _LiveTrackingMapState createState() => _LiveTrackingMapState();
// }
//
// class _LiveTrackingMapState extends State<LiveTrackingMap> {
//   final Completer<GoogleMapController> _controller = Completer();
//   LatLng? _currentLocation;
//   LatLng _destination = LatLng(30.0444, 31.2357); // القاهرة (مثال)
//   Set<Polyline> _polylines = {};
//   List<LatLng> _routeCoords = [];
//   StreamSubscription<Position>? _positionStream;
//
//   // final String googleApiKey = "YOUR_GOOGLE_MAPS_API_KEY"; // 🔴 ضع مفتاحك هنا
//   final String googleApiKey = "AIzaSyDTOoZf6ITSMREBuaQezlCV5FoxAYyeMuE";
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation().then((_) {
//       _startLocationUpdates();
//     });
//   }
//
//   @override
//   void dispose() {
//     _positionStream?.cancel();
//     super.dispose();
//   }
//
//   /// 🔹 الحصول على الموقع الحالي
//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       print("❌ خدمة الموقع غير مفعلة");
//       return;
//     }
//
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.deniedForever) {
//         print("❌ تم رفض إذن الموقع نهائيًا");
//         return;
//       }
//     }
//
//     Position position = await Geolocator.getCurrentPosition();
//     setState(() {
//       _currentLocation = LatLng(position.latitude, position.longitude);
//     });
//
//     _moveCamera();
//     _getRoute();
//   }
//
//   /// 🔹 تحديث الموقع أثناء التنقل
//   void _startLocationUpdates() {
//     const LocationSettings locationSettings = LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 10, // تحديث كل 10 أمتار
//     );
//
//     _positionStream = Geolocator.getPositionStream(locationSettings: locationSettings)
//         .listen((Position position) {
//       setState(() {
//         _currentLocation = LatLng(position.latitude, position.longitude);
//       });
//
//       _getRoute();  // تحديث المسار
//       _moveCamera(); // تحريك الكاميرا
//     });
//   }
//
//   /// 🔹 جلب المسار من Google Directions API
//   Future<void> _getRoute() async {
//     if (_currentLocation == null) return;
//
//     String url =
//         "https://maps.googleapis.com/maps/api/directions/json?origin=${_currentLocation!.latitude},${_currentLocation!.longitude}&destination=${_destination.latitude},${_destination.longitude}&key=$googleApiKey";
//
//     final response = await http.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = jsonDecode(response.body);
//
//       if (data["routes"].isEmpty) {
//         print("❌ لم يتم العثور على مسار!");
//         return;
//       }
//
//       String encodedPolyline = data["routes"][0]["overview_polyline"]["points"];
//       PolylinePoints polylinePoints = PolylinePoints();
//       List<PointLatLng> result = polylinePoints.decodePolyline(encodedPolyline);
//
//       _routeCoords.clear();
//       for (var point in result) {
//         _routeCoords.add(LatLng(point.latitude, point.longitude));
//       }
//
//       setState(() {
//         _polylines.clear();
//         _polylines.add(Polyline(
//           polylineId: PolylineId("route"),
//           color: Colors.blue,
//           width: 5,
//           points: _routeCoords,
//         ));
//       });
//     } else {
//       print("❌ خطأ في API: ${response.body}");
//     }
//   }
//
//   /// 🔹 تحريك الكاميرا مع الاتجاه
//   Future<void> _moveCamera() async {
//     if (_currentLocation == null) return;
//     final GoogleMapController controller = await _controller.future;
//
//     controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//       target: _currentLocation!,
//       zoom: 16.0,
//       bearing: _getBearing(_currentLocation!, _routeCoords.first), // توجيه الكاميرا مع الطريق
//     )));
//   }
//
//   /// 🔹 حساب اتجاه الطريق (Bearing)
//   double _getBearing(LatLng start, LatLng end) {
//     double lat1 = start.latitude * (pi / 180);
//     double lon1 = start.longitude * (pi / 180);
//     double lat2 = end.latitude * (pi / 180);
//     double lon2 = end.longitude * (pi / 180);
//
//     double dLon = lon2 - lon1;
//     double y = sin(dLon) * cos(lat2);
//     double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
//
//     double bearing = atan2(y, x);
//     return (bearing * (180 / pi) + 360) % 360; // تحويل إلى درجات
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("التوجيه المباشر على الخريطة")),
//       body: _currentLocation == null
//           ? Center(child: CircularProgressIndicator()) // أثناء تحميل الموقع
//           : GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: _currentLocation!,
//           zoom: 16.0,
//         ),
//         markers: {
//           Marker(
//             markerId: MarkerId("current"),
//             position: _currentLocation!,
//             icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//           ),
//           Marker(
//             markerId: MarkerId("destination"),
//             position: _destination,
//             icon: BitmapDescriptor.defaultMarker,
//           ),
//         },
//         polylines: _polylines,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//     );
//   }
// }