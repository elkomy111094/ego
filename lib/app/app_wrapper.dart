import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppWrapper extends StatelessWidget {
  final Widget child;
  final bool withSafeArea;

  const AppWrapper({
    super.key,
    required this.child,
    this.withSafeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = theme.scaffoldBackgroundColor;

    final systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: backgroundColor,
      systemNavigationBarColor: backgroundColor,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: Container(
        color: backgroundColor,
        child: withSafeArea ? SafeArea(child: child) : child,
      ),
    );
  }
}
