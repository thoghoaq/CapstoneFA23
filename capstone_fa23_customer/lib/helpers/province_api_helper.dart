import 'dart:convert';

import 'package:http/http.dart' as http;

class ProvinceApiHelper {
  final provinceOpenApiUrl = "https://provinces.open-api.vn/api/";

  Future<List<Map<int, String>>> getListProvince(String pattern) async {
    var response = await http.get(
        Uri.parse(
            '$provinceOpenApiUrl/p${pattern.isNotEmpty ? '/search/?q=$pattern' : ''}'),
        headers: {
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      return List<Map<int, String>>.from(
          data.map((e) => {e['code'] as int: e['name'] as String}));
    } else {
      throw Exception('Failed to load province');
    }
  }

  Future<List<Map<int, String>>> getListDistrict(
      int provinceCode, String pattern) async {
    String url = "";
    if (pattern.isNotEmpty) {
      url = '$provinceOpenApiUrl/d/search/?q=$pattern&p=$provinceCode';
    } else {
      url = '$provinceOpenApiUrl/p/$provinceCode/?depth=2';
    }
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      if (pattern.isNotEmpty) {
        return List<Map<int, String>>.from(
            data.map((e) => {e['code'] as int: e['name'] as String}));
      } else {
        return List<Map<int, String>>.from(data['districts']
            .map((e) => {e['code'] as int: e['name'] as String}));
      }
    } else {
      throw Exception('Failed to load district');
    }
  }

  Future<List<Map<int, String>>> getListWard(
      int provinceCode, int districtCode, String pattern) async {
    String url = "";
    if (pattern.isNotEmpty) {
      url =
          '$provinceOpenApiUrl/w/search/?q=$pattern&p=$provinceCode&d=$districtCode';
    } else {
      url = '$provinceOpenApiUrl/d/$districtCode/?depth=2';
    }
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      if (pattern.isNotEmpty) {
        return List<Map<int, String>>.from(
            data.map((e) => {e['code'] as int: e['name'] as String}));
      } else {
        return List<Map<int, String>>.from(
            data["wards"].map((e) => {e['code'] as int: e['name'] as String}));
      }
    } else {
      throw Exception('Failed to load ward');
    }
  }
}
