// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class TrackingWidget extends StatefulWidget {
  @override
  TrackingWidgetState createState() => TrackingWidgetState();
}

class TrackingWidgetState extends State<TrackingWidget> {
  LatLng? userPosition = LatLng(41.9028, 12.4964);

  GoogleMapController? _googleMapController;

  @override
  void dispose() {
    if (_googleMapController != null) {
      _googleMapController!.dispose();
    }
    super.dispose();
  }

  void requestLocationPermission() async {
    await Geolocator.requestPermission().then((permission) {
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        //permission is now granted
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    requestLocationPermission();

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: userPosition!,
        zoom: 12,
        tilt: 50.0,
      ),
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      compassEnabled: true,
      onMapCreated: (controller) => _googleMapController = controller,
    );
  }
}
