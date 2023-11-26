import 'dart:io';

class ApiResponse {
  final int statusCode;
  final dynamic result;
  final String? errorCode;
  final String? errorMessage;
  final String? invalidField;

  ApiResponse({
    required this.statusCode,
    this.result,
    this.errorCode,
    this.errorMessage,
    this.invalidField,
  });

  factory ApiResponse.fromJson(int statusCode, Map<String, dynamic> json) {
    return ApiResponse(
      statusCode: statusCode,
      result: json['result'],
      errorCode: json['errorCode'],
      errorMessage: json['errorMessage'],
      invalidField: json['invalidField'],
    );
  }

  factory ApiResponse.noContent() {
    return ApiResponse(
      statusCode: HttpStatus.noContent,
    );
  }
}
