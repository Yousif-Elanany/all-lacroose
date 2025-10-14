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
  const NearestClub({super.key});

  @override
  State<NearestClub> createState() => _NearestClubState();
}

class _NearestClubState extends State<NearestClub> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  late PolylinePoints polylinePoints;
  LatLng? _nearestLocation;
  LatLng? _currentPosition;
  final String googleApiKey = "AIzaSyC0hAS3zDVm4czww_CNmgFUqlvaYVXwsZU";

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints(apiKey: 'AIzaSyC0hAS3zDVm4czww_CNmgFUqlvaYVXwsZU');
    _getCurrentLocation();
  }

  /// 🧭 دالة الحصول على الموقع الحالي الحقيقي
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // التأكد أن خدمة الموقع مفعّلة
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("⚠️ خدمة الموقع غير مفعلة");
      return;
    }

    // التحقق من الأذونات
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("⚠️ تم رفض إذن الموقع");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("⚠️ تم رفض إذن الموقع بشكل دائم");
      return;
    }

    // الحصول على الموقع الحالي
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (!mounted) return;

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentPosition!,
          infoWindow: const InfoWindow(title: 'موقعك الحالي'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    });

    // استدعاء أقرب الملاعب بناءً على الموقع الحقيقي
    context.read<HomeCubit>().getNearestPlaygrounds(
          lat: position.latitude,
          long: position.longitude,
        );
  }

  Future<void> checkNearestLocation(
      List<LocationMarkerModel> markersList) async {
    if (markersList.isEmpty || _currentPosition == null) return;

    markersList.sort((a, b) => a.distance.compareTo(b.distance));
    final nearest = markersList.first;

    setState(() {
      _nearestLocation = LatLng(nearest.latitude, nearest.longitude);
    });

    await _drawRoute();
  }

  Future<void> _drawRoute() async {
    if (_nearestLocation == null || _currentPosition == null) return;

    final origin =
        "${_currentPosition!.latitude},${_currentPosition!.longitude}";
    final destination =
        "${_nearestLocation!.latitude},${_nearestLocation!.longitude}";

    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$googleApiKey";

    try {
      Dio dio = Dio();
      Response response = await dio.get(url);

      if (response.statusCode == 200 && response.data["status"] == "OK") {
        List<PointLatLng> result = PolylinePoints .decodePolyline(
            response.data["routes"][0]["overview_polyline"]["points"]);

        List<LatLng> routeCoords =
            result.map((p) => LatLng(p.latitude, p.longitude)).toList();

        if (!mounted) return;

        setState(() {
          _polylines.clear();
          _polylines.add(Polyline(
            polylineId: const PolylineId("route"),
            color: Colors.blue,
            width: 5,
            points: routeCoords,
          ));
        });

        // نحرك الكاميرا للموقع الحالي
        _mapController?.animateCamera(
          CameraUpdate.newLatLngBounds(
            _createBounds(_currentPosition!, _nearestLocation!),
            60,
          ),
        );
      } else {
        print("⚠️ خطأ من Google Directions API: ${response.data["status"]}");
      }
    } catch (e) {
      print("❌ خطأ أثناء جلب الاتجاهات: $e");
    }
  }

  /// لإنشاء حدود بين نقطتين لتكبير الخريطة بشكل مناسب
  LatLngBounds _createBounds(LatLng start, LatLng end) {
    return LatLngBounds(
      southwest: LatLng(
        start.latitude < end.latitude ? start.latitude : end.latitude,
        start.longitude < end.longitude ? start.longitude : end.longitude,
      ),
      northeast: LatLng(
        start.latitude > end.latitude ? start.latitude : end.latitude,
        start.longitude > end.longitude ? start.longitude : end.longitude,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) async {
          if (state is NearestPlaygroundsDataSuccess) {
            if (state.markersList.isNotEmpty && _currentPosition != null) {
              if (!mounted) return;
              setState(() {
                _markers.addAll(
                  state.markersList.map((location) => Marker(
                        markerId: MarkerId(location.id.toString()),
                        position: LatLng(location.latitude, location.longitude),
                        infoWindow: InfoWindow(
                          title: location.name,
                          snippet:
                              "المسافة: ${location.distance.toStringAsFixed(2)} كم",
                        ),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueRed),
                      )),
                );
              });

              await checkNearestLocation(state.markersList);
            }
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.14,
                    child: Container(
                      decoration: BoxDecoration(
                        image: const DecorationImage(
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: const Icon(Icons.arrow_back_ios_outlined,
                            color: Color(0xff185A3F), size: 20),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'nearest_club'.tr(),
                      style: const TextStyle(
                        color: Color(0xff185A3F),
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (_currentPosition != null)
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.14),
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition!,
                      zoom: 14,
                    ),
                    markers: _markers,
                    polylines: _polylines,
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  ),
                )
              else
                const Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
    );
  }
}
