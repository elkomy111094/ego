import 'package:ego/core/errors/api_error.dart';

import '../utils/api/failure.dart';

/// Exceptions 
abstract class AppException implements Exception {
  final String? message;
  const AppException([this.message]);
}

class ServerException extends AppException {
  const ServerException({required String? message, List<ApiError> ? errors}) : super(message ?? "Server exception");
}

class ConnectivityException extends AppException {
  const ConnectivityException([String? message]) : super(message ?? "No internet");
}

class TimeoutException extends AppException {
  const TimeoutException([String? message]) : super(message ?? "Request timed out");
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([String? message]) : super(message ?? "Unauthorized access");
}

class FormatException extends AppException {
  const FormatException([String? message]) : super(message ?? "Invalid data format");
}

class CacheException extends AppException {
  const CacheException([String? message]) : super(message ?? "Cache error");
}

class UnknownException extends AppException {
  const UnknownException([String? message]) : super(message ?? "Unknown exception");
}


