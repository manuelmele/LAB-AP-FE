// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingWidget extends StatefulWidget {
  @override
  TrackingWidgetState createState() => TrackingWidgetState();
}

class TrackingWidgetState extends State<TrackingWidget> {
  LatLng? userPosition = LatLng(41.9028, 12.4964);

  GoogleMapController? _googleMapController;

  MapType selectedMapType = MapType.normal;

  @override
  void dispose() {
    if (_googleMapController != null) {
      _googleMapController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: selectedMapType,
      initialCameraPosition: CameraPosition(
        target: userPosition!,
        zoom: 12,
        tilt: 50.0,
      ),
      myLocationButtonEnabled: false,
      onMapCreated: (controller) => _googleMapController = controller,
    );
  }
}
