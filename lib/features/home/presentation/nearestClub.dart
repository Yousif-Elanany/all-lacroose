import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';

import '../data/manager/cubit/home_cubit.dart';
import '../data/models/markerModel.dart';

class NearestClub extends StatefulWidget {
  NearestClub();

  @override
  State<NearestClub> createState() => _NearestClubState();
}

class _NearestClubState extends State<NearestClub> {
  late GoogleMapController _mapController;
  late Position _currentPosition;
  late CameraPosition _cameraPosition;
  Set<Marker> _markers = Set();
  final LatLng carPosition = LatLng(30.0444, 31.2357);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // التحقق من تفعيل الخدمة
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // عرض رسالة في حالة عدم تفعيل الخدمة
      return;
    }

    // التحقق من إذن الوصول إلى الموقع
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    // الحصول على الموقع الحالي
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;
      _cameraPosition = CameraPosition(
        target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        zoom: 16.0,
      );
      _markers.clear(); // إزالة الماركر القديم
      _markers.add(Marker(
        markerId: MarkerId('club'),
        position: carPosition,
        infoWindow: InfoWindow(title: 'موقعك الحالى '),
      ));
    });

    // تحديث الموقع كل 5 ثواني
    Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.high)
        .listen((Position position) {
      setState(() {
        _currentPosition = position;
        _cameraPosition = CameraPosition(
          target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
          zoom: 16.0,
        );
        _markers.clear(); // إزالة الماركر القديم
        _markers.add(Marker(
          markerId: MarkerId('club'),
          position: LatLng(_currentPosition.latitude, _currentPosition.longitude),
          infoWindow: InfoWindow(title: 'موقع الحالى'),
        ));
      });
      _mapController.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
    });
  }

  // Future<void> checkNearestLocation(List<MarkerModel> markersList) async {
  //   if (_currentPosition == null || markersList.isEmpty) return;
  //
  //   markersList.sort((a, b) => a.distance.compareTo(b.distance));
  //   final nearest = markersList.first;
  //
  //   setState(() {
  //     _nearestLocation = LatLng(nearest.latitude, nearest.longitude);
  //   });
  // }

  // Future<void> _drawRoute() async {
  //   if (_currentPosition == null || _nearestLocation == null) return;
  //
  //   String url =
  //       "https://maps.googleapis.com/maps/api/directions/json?origin=${_currentPosition.latitude},${_currentPosition.longitude}&destination=${_nearestLocation!.latitude},${_nearestLocation!.longitude}&key=$googleApiKey";
  //
  //   try {
  //     Dio dio = Dio();
  //     Response response = await dio.get(url);
  //
  //     if (response.statusCode == 200) {
  //       var data = response.data;
  //       if (data["status"] == "OK") {
  //         List<PointLatLng> points =
  //         polylinePoints.decodePolyline(data["routes"][0]["overview_polyline"]["points"]);
  //
  //         List<LatLng> polylineCoordinates =
  //         points.map((point) => LatLng(point.latitude, point.longitude)).toList();
  //
  //         setState(() {
  //           _polylines.clear();
  //           _polylines.add(Polyline(
  //             polylineId: PolylineId("route"),
  //             color: Colors.blue,
  //             width: 5,
  //             points: polylineCoordinates,
  //           ));
  //         });
  //       } else {
  //         print("⚠️ Google Maps API Error: ${data["status"]}");
  //       }
  //     } else {
  //       print("⚠️ HTTP Error: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("❌ Error fetching directions: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) async {
          if (state is NearestPlaygroundsDataSuccess) {
            // if (state.markersList.isNotEmpty) {
            //   setState(() {
            //     _markers.addAll(
            //       state.markersList.map((location) => Marker(
            //         markerId: MarkerId(location.id.toString()),
            //         position: LatLng(location.latitude, location.longitude),
            //         infoWindow: InfoWindow(
            //           title: location.name,
            //           snippet: "المسافة: ${location.distance.toStringAsFixed(2)} كم",
            //         ),
            //         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            //       )),
            //     );
            //   });
            //
            //   // await checkNearestLocation(state.markersList);
            //   // await _drawRoute();
            // }
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.14,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/top bar.png"),
                          fit: BoxFit.cover,
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.shade900,
                            Colors.green.shade700
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 50,
                left: 16,
                right: 16,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Icon(Icons.arrow_back_ios_outlined,
                            color: Color(0xff185A3F), size: 20),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'nearest_club'.tr(),
                      style: TextStyle(
                        color: Color(0xff185A3F),
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.14),
                child: GoogleMap(
                  mapType: MapType.normal, // نوع الخريطة هنا
                  initialCameraPosition: CameraPosition(
                    target: carPosition, // إحداثيات القاهرة
                    zoom: 16.0,
                  ),
                  markers: _markers, // إضافة الماركر هنا
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                ),

              ),
            ],
          );
        },
      ),
    );
  }}