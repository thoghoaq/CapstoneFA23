// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class GoongMap extends StatefulWidget {
  const GoongMap({super.key});

  @override
  State<GoongMap> createState() => _GoongMapState();
}

LatLng _current = const LatLng(21.027763, 105.834160);

class _GoongMapState extends State<GoongMap> {
  Future<LatLng> _getCurrentLatLng() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        print("'Location permissions are permanently denied");
      } else {
        print("GPS Location service is granted");
      }
    } else {
      print("GPS Location permission granted.");
    }

    bool servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      print("GPS service is enabled");
    } else {
      print("GPS service is disabled.");
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    return LatLng(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCurrentLatLng(),
      builder: (context, snapshot) {
        return MapboxMap(
          accessToken: dotenv.env['STYLE_ACCESS_TOKEN'],
          styleString: dotenv.env['STYLE_STRING'],
          initialCameraPosition: CameraPosition(
            target: snapshot.data ?? _current,
            zoom: 12.0,
          ),
        );
      },
    );
  }
}
