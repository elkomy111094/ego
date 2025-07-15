import 'package:dio/dio.dart';

import 'package:logger/logger.dart';
import 'package:ego/config/app_config.dart';

/// Rate limit interceptor to prevent API abuse
class RateLimitInterceptor extends Interceptor {
  final Logger _logger;
  final _requestTimestamps = <String, DateTime>{};

  RateLimitInterceptor({Logger? logger}) : _logger = logger ?? Logger();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final key = '${options.method}_${options.path}';
    final lastRequest = _requestTimestamps[key];

    if (lastRequest != null &&
        DateTime.now().difference(lastRequest) < AppConfig.rateLimitDelay) {
      _logger.d('Rate limiting request: $key');
      await Future.delayed(AppConfig.rateLimitDelay);
    }

    _requestTimestamps[key] = DateTime.now();
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final headers = response.headers;
    if (headers['X-RateLimit-Remaining'] != null) {
      final remaining = int.tryParse(headers['X-RateLimit-Remaining']!.first);
      if (remaining != null && remaining < 10) {
        _logger.w('Low rate limit remaining: $remaining');
      }
    }
    handler.next(response);
  }
}
