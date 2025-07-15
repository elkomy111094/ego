/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:ego/app/app.dart';
import 'package:ego/app/get_it/get_it.dart';
import 'package:ego/config/app_config.dart';
import 'package:ego/core/cache/cache_helper.dart';
import 'package:ego/core/common/services/local_data_srouce/sqflite.dart';
import 'package:ego/core/common/services/secure_storage/secure_storage.dart';
import 'package:ego/core/common/services/shared_prefs/shared_prefs.dart';
import 'package:ego/core/connectivity/cubit/connectivity_cubit.dart';
import 'package:ego/core/localization/lang_repo.dart';

import 'core/connectivity/app_connectivity_wrapper.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await SharedPrefs.initialize();
  // Bloc.observer = TBlocObserver();
  await SecureStorage.initialize();
  await CacheHelper.init();
  di<SqfliteDatabase>().initialize();




  di<LangRepo>().lang = await CacheHelper.getData(kUserLangKey) ;


  /// Set the default language 
  /// if it's null
  /// it means the user has never
  /// selected a language
  if (di<LangRepo>().lang == null) {
    di<LangRepo>().lang = "en";
    await CacheHelper.saveData(key: kUserLangKey, value: "en") ;
  }
  Logger().i("The language is ${di<LangRepo>().lang}");




  runApp(BlocProvider(
    create: (_) => di<ConnectivityCubit>(),
    child:  AppWithOverlay() ,
  ));
}
*/

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'core/notifications/notification_manager.dart';
import 'core/notifications/widgets/notification_inbox.dart';
import 'features/notification_settings_screen.dart';

Future<String?> getDeviceToken() async {
  try {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    print('📱 FCM Token: $token');
    return token;
  } catch (e) {
    print('❌ Error getting device token: $e');
    return null;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await Hive.initFlutter();

  String token = await getDeviceToken() ?? '';
  Logger().i(token);

  tz.initializeTimeZones();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification System Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      routes: {
        '/': (context) => const HomeScreen(),
        '/inbox': (context) => const NotificationInbox(),
        '/notification_settings':
            (context) => const NotificationSettingsScreen(),
      },
      home: Builder(
        builder: (context) {
          // Initialize NotificationManager
          NotificationManager.init(context);
          return const HomeScreen();
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pushNamed('/inbox'),
          child: const Text('View Notifications'),
        ),
      ),
    );
  }
}
