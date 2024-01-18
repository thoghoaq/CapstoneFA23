import 'dart:async';

import 'package:capstone_fa23_driver/helpers/location_helper.dart';
import 'package:capstone_fa23_driver/helpers/map_helper.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class GoongMap extends StatefulWidget {
  final LatLng startPoints;
  final LatLng endPoints;
  const GoongMap(
      {super.key, required this.startPoints, required this.endPoints});

  @override
  State<GoongMap> createState() => _GoongMapState();
}

class _GoongMapState extends State<GoongMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition? _kGooglePlex;

  final List<Marker> _markers = <Marker>[];

  Map<PolylineId, Polyline> polylines = {};
  late Timer _timer;

  Future<LatLng> getUserCurrentLocation() async {
    var latlng = await LocationHelper().getCurrentLocation();
    var currentMarker = Marker(
        markerId: const MarkerId("currentLocation"),
        position: latlng,
        infoWindow: const InfoWindow(title: "Vị trí của bạn"),
        icon: await Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: DColors.primary, width: 2)),
          child: const Icon(
            Icons.delivery_dining,
            color: DColors.primary,
            size: 20,
          ),
        ).toBitmapDescriptor());
    _markers.add(currentMarker);
    _kGooglePlex = CameraPosition(
      target: widget.startPoints,
      zoom: 14,
    );
    return latlng;
  }

  void generatePolyLineFromPoints(List<LatLng> pollylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: DColors.primary,
      points: pollylineCoordinates,
      width: 5,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    try {
      List<LatLng> polylineCoordinates = [];
      // PolylinePoints polylinePoints = PolylinePoints();
      // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      //   dotenv.get('GOOGLE_MAP_API_KEY'),
      //   PointLatLng(widget.startPoints.latitude, widget.startPoints.longitude),
      //   PointLatLng(widget.endPoints.latitude, widget.endPoints.longitude),
      //   travelMode: TravelMode.driving,
      // );
      PolylineResult result = await MapHelper.getDirections(
        PointLatLng(widget.startPoints.latitude, widget.startPoints.longitude),
        PointLatLng(widget.endPoints.latitude, widget.endPoints.longitude),
      );
      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      } else {
        if (kDebugMode) {
          print(result.errorMessage);
        }
      }
      return polylineCoordinates;
    } catch (_) {
      Fluttertoast.showToast(
        msg: "Không thể vẽ lộ trình",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    }
    return [];
  }

  void onUpdateUserLocation() {
    getUserCurrentLocation().then((value) async {
      bool isNotChangeLocation =
          _markers.where((m) => m.position == value).firstOrNull == null;
      if (isNotChangeLocation) return;
      _markers.removeWhere((m) => m.markerId.value == "currentLocation");
      var currentMarker = Marker(
          markerId: const MarkerId("currentLocation"),
          position: value,
          infoWindow: const InfoWindow(title: "Vị trí của bạn"),
          icon: await Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: DColors.primary, width: 2)),
            child: const Icon(
              Icons.delivery_dining,
              color: DColors.primary,
              size: 20,
            ),
          ).toBitmapDescriptor());
      _markers.add(currentMarker);
      if (kDebugMode) {
        print(
            "Update location ${currentMarker.position.latitude} : ${currentMarker.position.longitude}");
      }
    });
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      onUpdateUserLocation();
    });
  }

  @override
  void initState() {
    super.initState();
    _markers.addAll([
      // Marker(
      //   markerId: const MarkerId("startPoints"),
      //   position: widget.startPoints,
      //   infoWindow: const InfoWindow(title: "Vị trí xuất phát"),
      // ),
      Marker(
        markerId: const MarkerId("endPoints"),
        position: widget.endPoints,
        infoWindow: const InfoWindow(title: "Vị trí đơn hàng"),
      ),
    ]);
    getUserCurrentLocation().then((_) => getPolylinePoints()
        .then((coordinates) => generatePolyLineFromPoints(coordinates)));
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _kGooglePlex == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex!,
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            polylines: Set<Polyline>.of(polylines.values),
          );
  }
}
