import 'package:intl/intl.dart';

class HttpResponse {
  bool success;
  String httpStatus;
  int httpStatusCode;
  DateTime timestamp;
  String message;
  dynamic data;

  HttpResponse({
    required this.success,
    required this.httpStatus,
    required this.httpStatusCode,
    required this.timestamp,
    this.message = '',
    this.data,
  });

  factory HttpResponse.fromJson(Map<String, dynamic> jsonData) {
    return HttpResponse(
      success: jsonData['success'],
      httpStatus: jsonData['httpStatus'],
      httpStatusCode: jsonData['httpStatusCode'],
      timestamp: DateFormat('dd-MM-yyyy HH:mm:ss').parse(jsonData['timestamp']),
      message: jsonData['message'] ?? '',
      data: jsonData['data'],
    );
  }
}
