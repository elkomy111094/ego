import 'package:dio_adapter/dio_adapter.dart';

import '../../../app/get_it/get_it.dart';
import '../../../config/app_config.dart';
import '../../localization/lang_repo.dart';

class ApiHandler {
  ApiHandler() {
    _adapterBase = _apiConfig();
  }
  DioAdapterBase _apiConfig() {
    return DioAdapterBase(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseTypeEnum: ResponseTypeEnum.json,
      customRequestHandler: _customRequestHandler,
      customResponseHandler: _customResponseHandler,
      customErrorHandler: _customErrorHandler,
      contentTypeEnum: ContentTypeEnum.applicationJson,
    );
  }

  DioAdapterBase? _adapterBase;
  DioAdapterBase get dioAdapterBase => _adapterBase!;

  Future<RequestOptions> _customRequestHandler(
      RequestOptions options, _) async {
    // get user token
    String? token = "" /*await getIt.get<CacheHelper>().get(kUserToken)*/;

    if (options.path == EndPoints.updateProfileWithDataBase) {
      options.contentType = 'multipart/form-data';
    }
    if (options.path == EndPoints.loginWithDataBase) {
      options.headers.addAll({'Accept-Language': 'ar'});
    } else {
      final appLang = di<LangRepo>().lang ?? "en";
      if (token == null) {
        options.headers.addAll({
          'Accept-Language': appLang,
        });
      } else {
        options.headers.addAll({
          'Authorization': 'Bearer $token',
          'Accept-Language': appLang,
        });
      }
    }
    return options;
  }

  Future<Response> _customResponseHandler(response, _) async {
    return response;
  }

  Future<DioException> _customErrorHandler(DioException error, _) async {
    DioException e = DioException(
      message: error.response != null
          ? error.response?.data['message'] ?? error.message
          : error.message,
      error: error.error,
      requestOptions: error.requestOptions,
      response: error.response,
      type: error.type,
      stackTrace: error.stackTrace,
    );
    return e;
  }
}
