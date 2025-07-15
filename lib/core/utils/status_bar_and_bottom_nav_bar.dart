import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setSystemUIColors(BuildContext context) {
  // Get current theme
  final theme = Theme.of(context);

  // Determine brightness to set icon colors
  final isDark = theme.brightness == Brightness.dark;

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: theme.scaffoldBackgroundColor, // Match status bar to background
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark, // Icon colors
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light, // For iOS
      systemNavigationBarColor: theme.scaffoldBackgroundColor, // Bottom nav bar color
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark, // Bottom nav bar icons
    ),
  );
}
