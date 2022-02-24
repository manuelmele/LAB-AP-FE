// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wefix/services/meetings_service.dart';
import 'package:wefix/utilis/allert_dialogs.dart';

class TrackingWidget extends StatefulWidget {
  final String userJWT;
  final int meetingId;

  const TrackingWidget(
      {Key? key, required this.userJWT, required this.meetingId})
      : super(key: key);
  @override
  TrackingWidgetState createState() => TrackingWidgetState();
}

class TrackingWidgetState extends State<TrackingWidget> {
  LatLng? userPosition = LatLng(41.9028, 12.4964);
  Marker? marker;

  Timer? timer;

  GoogleMapController? _googleMapController;

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    if (_googleMapController != null) {
      _googleMapController!.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 2),
        (Timer t) => getMeetingPosition(widget.userJWT, widget.meetingId)
                .then((position) {
              Marker newMarker = Marker(
                markerId: MarkerId(widget.meetingId.toString()),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure),
                position: LatLng(position.lat!, position.lng!),
              );

              if (timer != null && timer!.isActive) {
                setState(() {
                  marker = newMarker;
                });
              }
            }));
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
    if (marker != null) {
      return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: userPosition!,
          zoom: 12,
          tilt: 50.0,
        ),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        markers: {marker!},
        onMapCreated: (controller) => _googleMapController = controller,
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
