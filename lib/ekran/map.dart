import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// 1
Completer<GoogleMapController> _controller = Completer();
// 2
 final CameraPosition _myLocation = CameraPosition(target: LatLng(0, 0),);


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1
      body: GoogleMap(
        // 2
        initialCameraPosition: _myLocation,
        // 3
        mapType: MapType.normal,
        // 4
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
