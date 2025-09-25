import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String name;

  const MapScreen({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.name,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _cameraPosition = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 16.0,
    );

    _markers.add(
      Marker(
        markerId: MarkerId("playground"),
        position: LatLng(widget.latitude, widget.longitude),
        infoWindow: InfoWindow(title: widget.name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name,style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green.shade700,
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        markers: _markers,
        onMapCreated: (controller) {
          _mapController = controller;
        },
      ),
    );
  }
}
