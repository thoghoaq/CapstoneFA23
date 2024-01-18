import 'dart:io';

import 'package:capstone_fa23_driver/helpers/api_helper.dart';
import 'package:capstone_fa23_driver/helpers/polyline_decoder.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapHelper {
  // ignore: constant_identifier_names
  static const String STATUS_OK = "ok";

  static Future<List<PolylineResult>> getRouteBetweenCoordinates(
      PointLatLng origin, PointLatLng destination) async {
    List<PolylineResult> results = [];
    var url =
        "/orders/directions?originLat=${origin.latitude}&originLng=${origin.longitude}&destinationLat=${destination.latitude}&destinationLng=${destination.longitude}";
    var response = await ApiClient().get(url);
    if (response.statusCode == HttpStatus.ok) {
      var parsedJson = response.result;
      if (parsedJson["routes"] != null && parsedJson["routes"].isNotEmpty) {
        List<dynamic> routeList = parsedJson["routes"];
        for (var route in routeList) {
          results.add(PolylineResult(
              points: PolylineDecoder.run(route["overview_polyline"]["points"]),
              errorMessage: "",
              status: STATUS_OK,
              distance: route["legs"][0]["distance"]["text"],
              distanceValue: route["legs"][0]["distance"]["value"],
              overviewPolyline: route["overview_polyline"]["points"],
              durationValue: route["legs"][0]["duration"]["value"],
              endAddress: route["legs"][0]['end_address'],
              startAddress: route["legs"][0]['start_address'],
              duration: route["legs"][0]["duration"]["text"]));
        }
      } else {
        throw Exception(
            "Unable to get route: Response ---> ${response.statusCode} ");
      }
    }
    return results;
  }

  static Future<PolylineResult> getDirections(
      PointLatLng origin, PointLatLng destination) async {
    try {
      var result = await getRouteBetweenCoordinates(origin, destination);
      return result.isNotEmpty
          ? result[0]
          : PolylineResult(errorMessage: "No result found");
    } catch (e) {
      rethrow;
    }
  }
}
