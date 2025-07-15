import 'package:easy_localization/easy_localization.dart';
import 'package:ego/features/splash/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ego/app/app_wrapper.dart';
import 'package:ego/app/get_it/get_it.dart';
import 'package:ego/app/layout/layout.dart';
import 'package:ego/core/common/services/shared_prefs/shared_prefs.dart';
import 'package:ego/core/connectivity/cubit/connectivity_cubit.dart';
import 'package:ego/core/constants/constants.dart';
import 'package:ego/core/localization/lang_repo.dart';
import 'package:ego/core/theme/theme.dart';
import 'package:ego/core/theme/theme_cubit/theme_cubit.dart';
import 'package:ego/core/theme/theme_cubit/theme_states.dart';

import 'package:ego/main.dart';



class TraderVolt extends StatefulWidget {
  const TraderVolt({super.key});

  @override
  State<TraderVolt> createState() => _TraderVoltState();
}

class _TraderVoltState extends State<TraderVolt> {
  @override
  void initState() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: colorScheme.background,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
    );
    if (SharedPrefs.getBool(Constants.biometricsEnabledKey)) {
      di<AppCubit>().authenticateBiometrics().then((authenticated) {
        if (authenticated == true) {
          initMethods();
        } else {
          SystemNavigator.pop();
        }
      });
    } else {
      initMethods();
    }
    super.initState();
  }

  void initMethods() {

  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di<ConnectivityCubit>()),

        BlocProvider(create: (context) => di<AppCubit>()..setThemeMode()),

      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
          Locale('hi'),
          Locale('ur'),
          Locale('bn'),
          Locale('es'),
          Locale('fr'),
          Locale('pt'),
          Locale('ru'),
          Locale('zh'),

        ],
        path: Constants.localizationPath,
        fallbackLocale: const Locale('en'),
        startLocale: Locale(di<LangRepo>().lang??"en"),
        child: BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (_, child) {
                return MaterialApp(
                  navigatorKey: navKey,
                  title: Constants.appName,
                  debugShowCheckedModeBanner: false,
                  theme: TAppTheme.lightTheme,
                  darkTheme: TAppTheme.darkTheme,
                  themeMode: di<AppCubit>().themeMode,
                  locale: context.locale,
                  supportedLocales: context.supportedLocales,

                  localizationsDelegates: [
                    ...context.localizationDelegates,
                  ],
                  home: AppWrapper(child: SplashPage(dialogChild: child!,)),
                );
              },
              child: Layout(),
            );
          },
        ),
      ),
    );
  }
}
