import 'package:logger/logger.dart';

/// Network analytics for logging request performance
class NetworkAnalytics {
  final Logger _logger;

  NetworkAnalytics({Logger? logger}) : _logger = logger ?? Logger();

  void logRequest({
    required String method,
    required String path,
    required int statusCode,
    required Duration duration,
  }) {
    _logger.i('$method $path - Status: $statusCode, Duration: ${duration.inMilliseconds}ms');
  }

  void logError({
    required String path,
    required String error,
  }) {
    _logger.e('Error on $path: $error');
  }
}
