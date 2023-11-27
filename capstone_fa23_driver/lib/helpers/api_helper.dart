import 'dart:convert';
import 'dart:io';
import 'package:capstone_fa23_driver/core/models/api_response_model.dart';
import 'package:capstone_fa23_driver/helpers/jwt_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const apiUrl =
    "http://optimizing-last-mile-env.eba-ix8wtpqt.ap-southeast-1.elasticbeanstalk.com";

class ApiClient {
  final Map<String, String>? headers;

  ApiClient({
    this.headers,
  });

  Future<ApiResponse> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$apiUrl/api$endpoint'),
      headers: await _createHeaders(),
    );
    return _handleResponse(response);
  }

  Future<ApiResponse> post(String endpoint, String data) async {
    final response = await http.post(
      Uri.parse('$apiUrl/api$endpoint'),
      headers: await _createHeaders(),
      body: data,
    );
    return _handleResponse(response);
  }

  Future<Response> postRaw(String endpoint, String data) async {
    final response = await http.post(
      Uri.parse('$apiUrl/api$endpoint'),
      headers: await _createHeaders(),
      body: data,
    );
    return response;
  }

  Future<ApiResponse> put(String endpoint, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$apiUrl/api$endpoint'),
      headers: await _createHeaders(),
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  Future<Map<String, String>> _createHeaders() async {
    final defaultHeaders = {
      'Content-Type': 'application/json',
      // More here
    };
    var bearerToken = await JWTHelper().getTokenString();
    if (bearerToken != null) {
      defaultHeaders['Authorization'] = 'Bearer $bearerToken';
    }
    Map<String, String> combinedHeaders = {...?headers, ...defaultHeaders};
    return combinedHeaders;
  }

  ApiResponse _handleResponse(http.Response response) {
    if (response.statusCode == 500) {
      throw Exception(response.reasonPhrase);
    }
    if (response.statusCode == HttpStatus.noContent) {
      return ApiResponse.noContent();
    }
    return ApiResponse.fromJson(
      response.statusCode,
      json.decode(response.body),
    );
  }
}
