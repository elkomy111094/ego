import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // تأكد من إضافة lottie في pubspec.yaml

import '../localization/loc_keys.dart';

class InMaintenanceScreen extends StatefulWidget {
  const InMaintenanceScreen({super.key});

  @override
  State<InMaintenanceScreen> createState() => _InMaintenanceScreenState();
}

class _InMaintenanceScreenState extends State<InMaintenanceScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkAgain() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(Loc.checkingStatus()), // localized
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
                  scale: _pulseAnimation,
                  child: Lottie.asset(
                    'assets/lottie/maintain.json', // ضع مسار الأنيميشن المناسب
                    width: 180,
                    height: 180,
                    repeat: true,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  Loc.maintenanceTitle(),
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
                const SizedBox(height: 10),
                Text(
                  Loc.maintenanceMessage(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onPrimaryContainer.withOpacity(0.75),
                  ),
                ),
                const SizedBox(height: 35),
                ElevatedButton.icon(
                  onPressed: _checkAgain,
                  icon: Icon(Icons.refresh, color: colorScheme.onPrimaryContainer,),
                  label: Text(
                    Loc.checkAgain(),
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
