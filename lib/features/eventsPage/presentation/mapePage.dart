

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? currentLocation;
  GoogleMapController? mapController;
  final String googleApiKey = "AIzaSyDTOoZf6ITSMREBuaQezlCV5FoxAYyeMuE";
  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // استدعاء الدالة للحصول على الموقع الحالي عند بدء الشاشة
  }
  //not run //
  // Future<Position?> getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   // التحقق مما إذا كانت خدمة الموقع مفعّلة
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // إذا كانت مغلقة، فتح إعدادات الموقع للمستخدم
  //     await Geolocator.openLocationSettings();
  //     return null; // انتظار المستخدم لتشغيل الخدمة
  //   }
  //   // التحقق من الأذونات
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return null; // تم رفض الإذن
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     // فتح إعدادات التطبيق للسماح للمستخدم بتعديل الأذونات
  //     await Geolocator.openAppSettings();
  //     return null;
  //   }
  //
  //   // الحصول على الموقع الحالي
  //   return await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  // }
  /////
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // التحقق مما إذا كانت خدمات الموقع مفعلة
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خدمات الموقع غير مفعلة")),
      );
      return;
    }

    // طلب إذن الوصول إلى الموقع
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("تم رفض إذن الموقع")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("تم رفض إذن الموقع نهائيًا، الرجاء تفعيله من الإعدادات")),
      );
      return;
    }

    // الحصول على الموقع الحالي
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });

    // تحريك الكاميرا إلى الموقع الحالي
    mapController?.animateCamera(CameraUpdate.newLatLng(currentLocation!));
  }

  void _onMapTap(LatLng position) {
    setState(() {
      currentLocation = position;
    });
  }

  void _confirmLocation() {
    if (currentLocation != null) {
      Navigator.pop(context, {
        "latitude": currentLocation!.latitude,
        "longitude": currentLocation!.longitude,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("اختر الموقع"),
        centerTitle: true,),
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator()) // عرض مؤشر تحميل أثناء تحديد الموقع
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: currentLocation!,
          zoom: 15, // تكبير الكاميرا عند بداية العرض
        ),
        onMapCreated: (controller) => mapController = controller,
        onTap: _onMapTap,
        markers: {
          Marker(
            markerId: MarkerId("current"),
            position: currentLocation!,
            infoWindow: InfoWindow(title: "الموقع الحالي"),
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: _confirmLocation,
        child: Icon(Icons.check,color: Colors.white,),
      ),
    );
  }
}
