import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class SelectLocationMapScreen extends StatefulWidget {
  var lat;
  var long;
  SelectLocationMapScreen({this.lat, this.long});
  @override
  _SelectLocationMapScreenState createState() =>
      _SelectLocationMapScreenState();
}

class _SelectLocationMapScreenState extends State<SelectLocationMapScreen> {
  GoogleMapController? _mapController;
  LatLng? pickedLocation;

  // احصل على موقع المستخدم الحالي
  Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return LatLng(30.0444, 31.2357); // fallback: القاهرة
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LatLng(30.0444, 31.2357); // fallback
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
      future: getCurrentLocation(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        LatLng initialPosition = snapshot.data!;

        return Scaffold(
          appBar: AppBar(title: Text("اختر الموقع".tr())),
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: initialPosition,
                  zoom: 15,
                ),
                onMapCreated: (controller) => _mapController = controller,
                onTap: (latLng) {
                  setState(() {
                    pickedLocation = latLng;
                  });
                },
                markers: pickedLocation != null
                    ? {
                        Marker(
                          markerId: MarkerId("picked"),
                          position: pickedLocation!,
                        ),
                      }
                    : {},
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: ElevatedButton(
                  onPressed: pickedLocation == null
                      ? null
                      : () {
                          Navigator.pop(context, pickedLocation);
                        },
                  child: Text("تأكيد الموقع".tr()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
