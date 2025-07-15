import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:ego/app/get_it/get_it.dart';
import 'package:ego/core/common/services/local_auth/local_auth_service.dart';
import 'package:ego/core/common/services/shared_prefs/shared_prefs.dart';
import 'package:ego/core/constants/constants.dart';
import 'package:ego/core/theme/theme_cubit/theme_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());
  static AppCubit get(context) => BlocProvider.of(context);

  final authService = di<LocalAuthService>();
  Future<bool> authenticateBiometrics() async {
    bool authenticated = false;
    final availableBiometrics = await authService.getAvailableBiometrics();
    if (availableBiometrics.isEmpty) {
      authenticated = await authService.authenticateWithDevicePassword();
    } else {
      authenticated = await authService.authenticateWithBiometrics();
    }

    return authenticated;
  }

  ThemeMode? themeMode;
  

  void setThemeMode() {
    
   
    
    if (SharedPrefs.getString(Constants.themeModeKey) == ThemeEnums.dark.name) {
      themeMode = ThemeMode.dark;
    } else if (SharedPrefs.getString(Constants.themeModeKey) ==
        ThemeEnums.light.name) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.system;
    }
    Logger().d("Currrrrrrrent Theme is " + "$themeMode") ;

  }

  void setDarkMode() {
    themeMode = ThemeMode.dark;
    SharedPrefs.setString(Constants.themeModeKey, ThemeEnums.dark.name);
    reRender();
    emit(ThemeChangeToDarkState());
  }

  void reRender() {
    emit(ReRenderState());
  }

  void setLightMode() {
    themeMode = ThemeMode.light;
    SharedPrefs.setString(Constants.themeModeKey, ThemeEnums.light.name);
    reRender();
    emit(ThemeChangeToLightState());
  }

  void setFollowSystemMode() {
    themeMode = ThemeMode.system;
    SharedPrefs.setString(Constants.themeModeKey, ThemeEnums.system.name);
    reRender();
    emit(ThemeChangeToSystemState());
  }

  bool get isDarkMode =>
      Theme.of(navKey.currentState!.context).brightness == Brightness.dark;

  bool get isTablet {
    final firstView = WidgetsBinding.instance.platformDispatcher.views.first;
    final logicalShortestSide =
        firstView.physicalSize.shortestSide / firstView.devicePixelRatio;
    return logicalShortestSide > 580;
  }

  bool get isPortrait {
    return MediaQuery.of(navKey.currentState!.context).orientation ==
        Orientation.portrait;
  }
}
