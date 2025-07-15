
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum ConnectionStatus {
disconnected,
connectedNoInternet,
connectedWithInternet,
}

class ConnectivityCubit extends Cubit<ConnectionStatus> {
final Connectivity _connectivity = Connectivity();

late final StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
late final StreamSubscription<InternetConnectionStatus> _internetSubscription;


final InternetConnectionChecker _internetChecker = InternetConnectionChecker.createInstance(
checkInterval: Duration(milliseconds: 100),
);

ConnectivityCubit() : super(ConnectionStatus.disconnected) {
_monitorConnectivity();
}

Future<void> _monitorConnectivity() async {
// الاشتراك في تغيرات اتصال الشبكة (يرجع List<ConnectivityResult>)
_connectivitySubscription = _connectivity.onConnectivityChanged.listen(
(List<ConnectivityResult> results) async {
final ConnectivityResult result = results.isNotEmpty ? results.first : ConnectivityResult.none;
await _updateConnectivity(result);
},
);

// الاشتراك في تغيرات اتصال الانترنت (البنج)
_internetSubscription = _internetChecker.onStatusChange.listen(_updateInternetStatus);

// الحالة الأولية للاتصال - عنصر واحد فقط
final List<ConnectivityResult> initialConnectivity = await _connectivity.checkConnectivity();
await _updateConnectivity(initialConnectivity[0]);
}

Future<void> _updateConnectivity(ConnectivityResult result) async {
if (result == ConnectivityResult.none) {
emit(ConnectionStatus.disconnected);
} else {
bool hasInternet = await _internetChecker.hasConnection;
if (hasInternet) {
  
emit(ConnectionStatus.connectedWithInternet);
} else {
emit(ConnectionStatus.connectedNoInternet);
}
}
}

void _updateInternetStatus(InternetConnectionStatus status) {
if (status == InternetConnectionStatus.connected) {
emit(ConnectionStatus.connectedWithInternet);
} else if (state == ConnectionStatus.connectedWithInternet) {
emit(ConnectionStatus.connectedNoInternet);
}
}

@override
Future<void> close() async {
await _connectivitySubscription.cancel();
await _internetSubscription.cancel();
return super.close();
}
}
