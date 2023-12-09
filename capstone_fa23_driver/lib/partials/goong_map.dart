import 'package:capstone_fa23_driver/helpers/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class GoongMap extends StatefulWidget {
  const GoongMap({super.key});

  @override
  State<GoongMap> createState() => _GoongMapState();
}

LatLng _current = const LatLng(50.027763, 40.834160);

class _GoongMapState extends State<GoongMap> {
  late MapboxMapController mapController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LocationHelper().getCurrentLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          _current = snapshot.data as LatLng;
        }
        return MapboxMap(
          accessToken: dotenv.env['STYLE_ACCESS_TOKEN'],
          styleString: dotenv.env['STYLE_STRING'],
          myLocationEnabled: true,
          myLocationTrackingMode: MyLocationTrackingMode.Tracking,
          onMapCreated: (MapboxMapController controller) {
            mapController = controller;
          },
          compassEnabled: true,
          initialCameraPosition: CameraPosition(
            target: _current,
            zoom: 12.0,
          ),
        );
      },
    );
  }
}
