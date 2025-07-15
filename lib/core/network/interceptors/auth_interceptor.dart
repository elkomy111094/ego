import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    const token = 'Bearer your_token_here';
    options.headers['Authorization'] = token;
    super.onRequest(options, handler);
  }
}
