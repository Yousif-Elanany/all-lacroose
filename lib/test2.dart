// // import 'package:flutter/material.dart';
// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:geolocator/geolocator.dart';
// //
// // import 'dart:async';
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// //
// // class MapRouteScreen extends StatefulWidget {
// //   @override
// //   _MapRouteScreenState createState() => _MapRouteScreenState();
// // }
// //
// // class _MapRouteScreenState extends State<MapRouteScreen> {
// //   GoogleMapController? _mapController;
// //   Position? _currentPosition;
// //   LatLng? _selectedDestination;
// //   Set<Marker> _markers = {};
// //   Set<Polyline> _polylines = {};
// //   PolylinePoints polylinePoints = PolylinePoints();
// //
// //   // API Key (Replace with your actual Google API Key)
// //   final String googleApiKey = "AIzaSyCf_3qC_SyY1aZNw96nsD30QehPlKnh4sk";
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _getCurrentLocation();
// //   }
// //
// //   // 🔹 Getting Current Location (Compatible with Geolocator 8.2.1)
// //   Future<void> _getCurrentLocation() async {
// //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) return;
// //
// //     LocationPermission permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) return;
// //     }
// //
// //     if (permission == LocationPermission.deniedForever) return;
// //
// //     Position position = await Geolocator.getCurrentPosition(
// //       desiredAccuracy: LocationAccuracy.high,
// //     );
// //
// //     setState(() {
// //       _currentPosition = position;
// //       _markers.add(
// //         Marker(
// //           markerId: MarkerId("current_location"),
// //           position: LatLng(position.latitude, position.longitude),
// //           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
// //           infoWindow: InfoWindow(title: "موقعي الحالي"),
// //         ),
// //       );
// //     });
// //
// //     _mapController?.animateCamera(CameraUpdate.newLatLngZoom(
// //       LatLng(position.latitude, position.longitude),
// //       14.0,
// //     ));
// //   }
// //
// //   // 🔹 Handle Marker Tap to Select a Destination
// //   void _onMarkerTapped(LatLng destination) {
// //     setState(() {
// //       _selectedDestination = destination;
// //       _drawRoute();
// //     });
// //   }
// //
// //   // 🔹 Drawing Route Between Current Location & Destination
// //   Future<void> _drawRoute() async {
// //     if (_currentPosition == null || _selectedDestination == null) return;
// //
// //     String url =
// //         "https://maps.googleapis.com/maps/api/directions/json?origin=${_currentPosition!.latitude},${_currentPosition!.longitude}&destination=${_selectedDestination!.latitude},${_selectedDestination!.longitude}&key=$googleApiKey";
// //
// //     var response = await http.get(Uri.parse(url));
// //     var data = jsonDecode(response.body);
// //
// //     if (data["status"] == "OK") {
// //       List<PointLatLng> points =
// //       polylinePoints.decodePolyline(data["routes"][0]["overview_polyline"]["points"]);
// //
// //       List<LatLng> polylineCoordinates = points.map((point) {
// //         return LatLng(point.latitude, point.longitude);
// //       }).toList();
// //
// //       setState(() {
// //         _polylines.clear();
// //         _polylines.add(Polyline(
// //           polylineId: PolylineId("route"),
// //           color: Colors.blue,
// //           width: 5,
// //           points: polylineCoordinates,
// //         ));
// //       });
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("رسم المسار على الخريطة")),
// //       body: GoogleMap(
// //         initialCameraPosition: CameraPosition(
// //           target: LatLng(30.0444, 31.2357), // Centered on Cairo
// //           zoom: 12,
// //         ),
// //         markers: _markers,
// //         polylines: _polylines,
// //         onMapCreated: (controller) => _mapController = controller,
// //         onTap: (LatLng latLng) {
// //           setState(() {
// //             _selectedDestination = latLng;
// //             _markers.add(Marker(
// //               markerId: MarkerId("destination"),
// //               position: latLng,
// //               infoWindow: InfoWindow(title: "الوجهة المحددة"),
// //               icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
// //               onTap: () => _onMarkerTapped(latLng),
// //             ));
// //             _drawRoute();
// //           });
// //         },
// //       ),
// //     );
// //   }
// // }
//
// ///////////
// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:dio/dio.dart';
// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// //
// // class MapScreen extends StatefulWidget {
// //   @override
// //   _MapScreenState createState() => _MapScreenState();
// // }
// //
// // class _MapScreenState extends State<MapScreen> {
// //   GoogleMapController? mapController;
// //   Set<Marker> _markers = {};
// //   Set<Polyline> _polylines = {};
// //   PolylinePoints polylinePoints = PolylinePoints();
// //   final String googleApiKey = "AIzaSyDTOoZf6ITSMREBuaQezlCV5FoxAYyeMuE";
// //
// //   // ⚡ نقاط البداية والنهاية
// //   LatLng startLocation = LatLng(30.0450, 31.2624);//LatLng(24.7136, 46.6753); // الرياض
// //   LatLng endLocation =LatLng(30.0459, 31.2243);// LatLng(21.3891, 39.8579); // مكة
// //   final Set<LatLng> famousPlaces = {
// //     LatLng(29.9792, 31.1342), // Giza Pyramids
// //     LatLng(30.0478, 31.2336), // Egyptian Museum
// //     LatLng(30.0459, 31.2243), // Cairo Tower
// //     LatLng(30.0450, 31.2624), // Al-Azhar Mosque
// //     LatLng(30.0066, 31.2305), // The Hanging Church
// //   };
// //   @override
// //   void initState() {
// //     super.initState();
// //     _setMarkers();
// //     _drawRoute(); // 🔥 حساب الطريق عند بدء التطبيق
// //   }
// //
// //   // 🎯 تعيين العلامات (Markers)
// //   void _setMarkers() {
// //     setState(() {
// //       _markers.add(Marker(
// //         markerId: MarkerId("start"),
// //         position: startLocation,
// //         infoWindow: InfoWindow(title: "نقطة البداية"),
// //       ));
// //       _markers.add(Marker(
// //         markerId: MarkerId("end"),
// //         position: endLocation,
// //         infoWindow: InfoWindow(title: "الوجهة"),
// //       ));
// //     });
// //   }
// //
// //   // 🛣️ رسم الطريق باستخدام Google Directions API
// //   Future<void> _drawRoute() async {
// //     String url =
// //         "https://maps.googleapis.com/maps/api/directions/json?origin=${startLocation.latitude},${startLocation.longitude}&destination=${endLocation.latitude},${endLocation.longitude}&key=$googleApiKey&mode=driving";
// //
// //     try {
// //       var response = await Dio().get(url);
// //       var data = response.data;
// //
// //       if (data["status"] == "OK") {
// //         List<PointLatLng> points =
// //         polylinePoints.decodePolyline(data["routes"][0]["overview_polyline"]["points"]);
// //
// //         List<LatLng> polylineCoordinates = points.map((point) {
// //           return LatLng(point.latitude, point.longitude);
// //         }).toList();
// //
// //         setState(() {
// //           _polylines.clear();
// //           _polylines.add(Polyline(
// //             polylineId: PolylineId("route"),
// //             color: Colors.blue,
// //             width: 5,
// //             points: polylineCoordinates,
// //           ));
// //         });
// //
// //         // 🔥 تحريك الكاميرا إلى المسار الجديد
// //         LatLngBounds bounds = _getBounds([startLocation, endLocation]);
// //         mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
// //       } else {
// //         print("⚠️ فشل في تحميل الطريق: ${data["status"]}");
// //       }
// //     } catch (e) {
// //       print("❌ خطأ في طلب البيانات: $e");
// //     }
// //   }
// //
// //   // 🗺️ حساب الحدود للمسار
// //   LatLngBounds _getBounds(List<LatLng> points) {
// //     double minLat = points[0].latitude;
// //     double maxLat = points[0].latitude;
// //     double minLng = points[0].longitude;
// //     double maxLng = points[0].longitude;
// //
// //     for (var point in points) {
// //       if (point.latitude < minLat) minLat = point.latitude;
// //       if (point.latitude > maxLat) maxLat = point.latitude;
// //       if (point.longitude < minLng) minLng = point.longitude;
// //       if (point.longitude > maxLng) maxLng = point.longitude;
// //     }
// //
// //     return LatLngBounds(
// //       southwest: LatLng(minLat, minLng),
// //       northeast: LatLng(maxLat, maxLng),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("رسم أفضل طريق")),
// //       body: GoogleMap(
// //         onMapCreated: (controller) {
// //           setState(() {
// //             mapController = controller;
// //           });
// //         },
// //         initialCameraPosition: CameraPosition(
// //           target: startLocation,
// //           zoom: 10.0,
// //         ),
// //         mapType: MapType.normal,
// //         markers: _markers,
// //         polylines: _polylines,
// //       ),
// //     );
// //   }
// // }
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:async';
//
// class LiveRouteTracking extends StatefulWidget {
//   @override
//   _LiveRouteTrackingState createState() => _LiveRouteTrackingState();
// }
//
// class _LiveRouteTrackingState extends State<LiveRouteTracking> {
//   GoogleMapController? _mapController;
//   StreamSubscription<Position>? _positionStream;
//   LatLng? _currentLocation;
//   LatLng? _destination;
//   List<LatLng> _routeCoordinates = [];
//   Set<Polyline> _polylines = {};
//   PolylinePoints polylinePoints = PolylinePoints();
//   Set<Marker> _markers = {};
//   final String googleApiKey = "AIzaSyDTOoZf6ITSMREBuaQezlCV5FoxAYyeMuE";
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   /// 🔹 الحصول على الموقع الحالي للمستخدم
//   Future<void> _getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//
//     setState(() {
//       _currentLocation = LatLng(position.latitude, position.longitude);
//       _markers.add(Marker(
//         markerId: MarkerId("currentLocation"),
//         position: _currentLocation!,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//       ));
//     });
//
//     _startLocationUpdates();
//   }
//
//   /// 🔹 تحديث الموقع الحي ورسم المسار
//   void _startLocationUpdates() {
//     _positionStream = Geolocator.getPositionStream(
//       locationSettings: LocationSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 5, // تحديث الموقع عند التحرك 5 أمتار
//       ),
//     ).listen((Position position) {
//       setState(() {
//         _currentLocation = LatLng(position.latitude, position.longitude);
//         _markers.removeWhere((marker) => marker.markerId == MarkerId("currentLocation"));
//         _markers.add(Marker(
//           markerId: MarkerId("currentLocation"),
//           position: _currentLocation!,
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//         ));
//      //   _updateRoute();
//         _drawRoute();
//       });
//
//       // تحريك الكاميرا لمتابعة الموقع
//       _mapController?.animateCamera(CameraUpdate.newLatLng(_currentLocation!));
//     });
//   }
//
//   /// 🔹 تعيين الوجهة عند ضغط المستخدم على الخريطة
//   void _setDestination(LatLng destination) {
//     setState(() {
//       _destination = destination;
//       _markers.removeWhere((marker) => marker.markerId == MarkerId("destination"));
//       _markers.add(Marker(
//         markerId: MarkerId("destination"),
//         position: destination,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//       ));
//       // _updateRoute();
//       _drawRoute();
//     });
//   }
//
//   /// 🔹 تحديث المسار بين الموقع الحالي والوجهة
//   void _updateRoute() {
//     if (_currentLocation == null || _destination == null) return;
//
//     setState(() {
//       _routeCoordinates = [_currentLocation!, _destination!]; // طريق مباشر
//       _polylines.clear();
//       _polylines.add(Polyline(
//         polylineId: PolylineId("route"),
//         points: _routeCoordinates,
//         color: Colors.blue,
//         width: 5,
//       ));
//     });
//   }
//   Future<void> _drawRoute() async {
//     print("⚠️  drow  run ////////////////");
//     print(_currentLocation);
//     print(_destination);
//     if (_currentLocation == null || _destination == null){
//       print("⚠️  drow in null  //////////////// ");
//       return;}
//     String url =
//         "https://maps.googleapis.com/maps/api/directions/json?origin=${_currentLocation!.latitude},${_currentLocation!.longitude}&destination=${_destination!.latitude},${_destination!.longitude}&key=$googleApiKey";
//     try {
//       Dio dio = Dio(); // إنشاء كائن Dio
//       Response response = await dio.get(url); // إرسال الطلب
//
//       if (response.statusCode == 200) {
//         var data = response.data; // مباشرة بدون jsonDecode
//
//         if (data["status"] == "OK") {
//           List<PointLatLng> points = polylinePoints.decodePolyline(
//             data["routes"][0]["overview_polyline"]["points"],
//           );
//           List<LatLng> polylineCoordinates = points.map((point) {
//             return LatLng(point.latitude, point.longitude);
//           }).toList();
//           setState(() {
//             _polylines.clear();
//             _polylines.add(Polyline(
//               polylineId: PolylineId("route"),
//               color: Colors.blue,
//               width: 5,
//               points: polylineCoordinates,
//             ));
//           });
//         } else {
//           print("⚠️ خطأ في Google Maps API: ${data["status"]}");
//         }
//       } else {
//         print("⚠️ خطأ في الاتصال: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("❌ خطأ أثناء جلب البيانات: $e");
//     }
//   }
//
//   @override
//   void dispose() {
//     _positionStream?.cancel(); // إيقاف تتبع الموقع عند الخروج
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("تتبع الطريق المباشر")),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: LatLng(30.033333, 31.233334), // القاهرة
//           zoom: 14,
//         ),
//         polylines: _polylines,
//         markers: _markers,
//         onMapCreated: (GoogleMapController controller) {
//           _mapController = controller;
//         },
//         onTap: (LatLng latLng) {
//           _setDestination(latLng); // تعيين الوجهة عند النقر
//         },
//       ),
//     );
//   }
// }