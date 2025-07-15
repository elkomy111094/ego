import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:ego/core/cache/cache_helper.dart';
import 'package:ego/core/connectivity/cubit/connectivity_cubit.dart';



import '../../../app/get_it/get_it.dart';
import '../../../core/common/services/shared_prefs/shared_prefs.dart';
import '../../../core/connectivity/cubit/connectivity_cubit.dart';
import '../../../core/utils/getAppCurrentVersion.dart';
import '../../../core/utils/status_bar_and_bottom_nav_bar.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Timer? _navigationTimer;
  late StreamSubscription _subscription;

  bool termsAccepted = false;
  bool inMaintenance = false;

  void initialize() async {
    termsAccepted = SharedPrefs.getBool("agreementDialogAccepted");
    _startConnectivityListener();
  }

  void _startConnectivityListener() {
    _subscription = di<ConnectivityCubit>().stream.listen((state) {
      if (state == ConnectionStatus.connectedWithInternet) {
        _startNavigation();
      } else {
        _navigationTimer?.cancel();
      }
    });
  }

  Future<void> _startNavigation() async {
    _navigationTimer?.cancel();

  }



  Future<bool> pingServer() async {
    final dio = Dio();

    try {
      final response = await dio.get(
        'http://104.248.165.230:5000/api/v1/system-status/ping',
        options: Options(headers: {'Accept': 'text/plain'}),
      );

      if (response.statusCode == 200) {
        Logger().d("The Maintenance status is: ${response.data["underMaintenance"]}");
        inMaintenance = response.data["underMaintenance"];
        return inMaintenance;
      } else {
        return false;
      }
    } catch (e) {
      Logger().e("Ping server error: $e");
      return false;
    }
  }


  @override
  Future<void> close() {
    _navigationTimer?.cancel();
    _subscription.cancel();
    return super.close();
  }
}
