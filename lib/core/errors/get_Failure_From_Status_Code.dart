import 'package:dio/dio.dart';

import '../utils/api/failure.dart' hide Failure;
import 'failures.dart';

/// Converts an HTTP status code to a Failure object.
/// Maps 4xx and 5xx status codes to appropriate Failure types with descriptive messages.
/// Non-error codes (1xx, 2xx, 3xx) return a GeneralFailure indicating invalid usage.\
/// 

String extractErrorMessage(dynamic exception) {
try {
// Assuming 'ex' is a DioException or similar with a response
if (exception?.response?.data != null) {
final data = exception.response.data;
// Check if 'errors' exists and is a non-empty list
if (data is Map<String, dynamic> &&
data.containsKey('errors') &&
data['errors'] is List &&
data['errors'].isNotEmpty) {
final firstError = data['errors'][0];
// Check if 'description' exists in the first error
if (firstError is Map<String, dynamic> &&
firstError.containsKey('description')) {
return firstError['description'] as String;
}
}
// Fallback to general description if available
if (data is Map<String, dynamic> &&
data.containsKey('description')) {
return data['description'] as String;
}
}
// Default error message
return 'Bad Request: Invalid request syntax.';
} catch (e) {
// Handle unexpected errors during parsing
return 'An unexpected error occurred.';
}
}



Failure getFailureFromStatusCode(int statusCode , {DioException ? ex}) {
  // Handle 4xx Client Errors
  if (statusCode >= 400 && statusCode < 500) {
    switch (statusCode) {
      case 400:

       String  ? errorMessage = extractErrorMessage(ex) ;
        
        return ServerFailure(errorMessage ?? "Bad Request: Invalid request syntax.");
      case 401:
        
        return ServerFailure("Unauthorized: Authentication required or invalid.");
      case 403:
        return ServerFailure("Forbidden: Access to this resource is denied.");
      case 404:
        return ServerFailure("Not Found: The requested resource does not exist.");
      case 408:
        return ServerFailure("Request Timeout: The server timed out.");
      case 429:
        return ServerFailure("Too Many Requests: Rate limit exceeded.");
      case 451:
        return ServerFailure("Unavailable For Legal Reasons: Access blocked.");
      default:
        return ServerFailure("Client Error: Status code $statusCode.");
    }
  }
  // Handle 5xx Server Errors
  else if (statusCode >= 500 && statusCode < 600) {
    switch (statusCode) {
      case 500:
        return ServerFailure("Internal Server Error: Something went wrong.");
      case 502:
        return ServerFailure("Bad Gateway: Invalid upstream response.");
      case 503:
        return ServerFailure("Service Unavailable: Server is temporarily down.");
      case 504:
        return ServerFailure("Gateway Timeout: No response from server.");
      default:
        return ServerFailure("Server Error: Status code $statusCode.");
    }
  }
  // Non-error codes (1xx, 2xx, 3xx) or invalid codes
  else {
    return GeneralFailure("Invalid status code: $statusCode is not a failure.");
  }
}
