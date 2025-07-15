import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ego/core/cache/cache_helper.dart';
import 'package:ego/core/common/services/dialog/dialog_service.dart';
import 'package:ego/core/common/services/local_auth/local_auth_service.dart';
import 'package:ego/core/common/services/local_data_srouce/sqflite.dart';
import 'package:ego/core/common/services/url_launcher/url_launcher_service.dart';
import 'package:ego/core/connectivity/cubit/connectivity_cubit.dart';
import 'package:ego/core/localization/lang_repo.dart';
import 'package:ego/core/network/client/dio_client.dart';
import 'package:ego/core/theme/theme_cubit/theme_cubit.dart';


import '../../core/utils/api/api_handler.dart';


final logger = Logger(
    printer: PrettyPrinter(
  methodCount: 0,
  colors: true,
  printEmojis: true,
));
final GlobalKey<NavigatorState> navKey = GlobalKey();
final di = GetIt.instance;

Future<void> initializeDependencies() async {
  di.registerLazySingleton(
        () => CacheHelper(),
  );
  //? Dio Client
  di.registerSingleton<DioClient>(DioClient());
  di.registerLazySingleton<ConnectivityCubit>(() => ConnectivityCubit());

  di.registerFactory<ApiHandler>(() => ApiHandler());
  //? Services
  di.registerLazySingleton(() => DialogService());
  di.registerLazySingleton(() => UrlLauncherService());
  di.registerFactory(() => LocalAuthService());
  di.registerLazySingleton(() => LangRepo());
  //? Cubits
  di.registerLazySingleton(() => AppCubit());
  di.registerLazySingleton<SqfliteDatabase>(() => SqfliteDatabaseImp.instance);


}
