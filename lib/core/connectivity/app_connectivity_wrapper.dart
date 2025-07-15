import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ego/app/app.dart';
import 'package:ego/app/app_wrapper.dart';
import 'package:ego/core/connectivity/mintainance_screen.dart';
import 'package:ego/core/connectivity/update_app_version_screen.dart';
import '../../app/get_it/get_it.dart';

import '../utils/status_bar_and_bottom_nav_bar.dart';
import 'cubit/connectivity_cubit.dart';
import 'no_internet_screen.dart';
import 'no_connectivity_screen.dart';

class AppWithOverlay extends StatefulWidget {
  const AppWithOverlay({super.key});

  @override
  State<AppWithOverlay> createState() => _AppWithOverlayState();
}

class _AppWithOverlayState extends State<AppWithOverlay> {
  OverlayEntry? _overlayEntry;
  late StreamSubscription<ConnectionStatus> _subscription;

  @override
  void initState() {
    super.initState();


    final cubit = di<ConnectivityCubit>();

    _subscription = cubit.stream.listen((state) {
      if (state == ConnectionStatus.connectedWithInternet) {
        _removeOverlay();
      } else if (state == ConnectionStatus.connectedNoInternet) {
        _showOverlay(_buildNoInternetOverlay()); // wifi_off
      } else if (state == ConnectionStatus.disconnected) {
        _showOverlay(_buildNoConnectionOverlay()); // no_internet
      }
    });
  }

  OverlayEntry _buildNoInternetOverlay() => OverlayEntry(
    builder: (_) => NoInternetScreen(),
  );

  OverlayEntry _buildNoConnectionOverlay() => OverlayEntry(
    builder: (_) => NoConnectionScreen(),
  );

  void _showOverlay(OverlayEntry newOverlay) {
    // لو نفس الشاشة مفتوحة بالفعل، لا حاجة لإعادة الإدراج
    if (_overlayEntry?.builder.runtimeType == newOverlay.builder.runtimeType) return;

    _removeOverlay();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _overlayEntry = newOverlay;
      final overlayState = navKey.currentState?.overlay;
      overlayState?.insert(_overlayEntry!);
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _subscription.cancel();
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TraderVolt();
  }
}

