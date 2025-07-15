import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'package:lottie/lottie.dart';

import '../localization/loc_keys.dart';

class NoConnectionScreen extends StatefulWidget {
  const NoConnectionScreen({super.key});

  @override
  State<NoConnectionScreen> createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _buttonAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openWifiSettings() {
    AppSettings.openAppSettings(type: AppSettingsType.wifi);
  }

  void _openMobileDataSettings() {
    AppSettings.openAppSettings(type: AppSettingsType.dataRoaming);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
         
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleTransition(
                  scale: _buttonAnimation,
                  child: Lottie.asset(
                    'assets/lottie/no_connection.json',
                    width: 180,
                    height: 180,
                    repeat: true,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  Loc.noConnection(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: colorScheme.shadow.withOpacity(0.5),
                        offset: const Offset(1, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                ScaleTransition(
                  scale: _buttonAnimation,
                  child: ElevatedButton.icon(
                    onPressed: _openWifiSettings,
                    icon: Icon(Icons.wifi,color: colorScheme.onPrimaryContainer,),
                    label: Text(
                      Loc.openWifiSettings(),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      elevation: 10,
                      shadowColor: colorScheme.shadow,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ScaleTransition(
                  scale: _buttonAnimation,
                  child: ElevatedButton.icon(
                    onPressed: _openMobileDataSettings,
                    icon: Icon(Icons.data_usage, color: colorScheme.onPrimaryContainer,),
                    label: Text(
                      Loc.openMobileData(),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      elevation: 10,
                      shadowColor: colorScheme.shadow,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
