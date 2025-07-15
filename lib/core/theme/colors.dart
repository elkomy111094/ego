import 'package:flutter/material.dart';

class TLightModeColors {
  TLightModeColors._();

  static Color primaryColor = const Color.fromARGB(255, 61, 129, 251);
  static Color scaffoldBgColor = Colors.white;
  static Color appBarBgColor = Colors.white;
  static Color appBarFgColor = Colors.black.withOpacity(.8);
  static Color secondaryContainer = Colors.grey.shade100;
  static Color onSecondaryContainer = Colors.grey.shade600;
  static Color outline = Colors.grey.shade400;
  static Color error = Colors.red;
}

class TDarkModeColors {
  TDarkModeColors._();
  static Color primaryColor = const Color.fromARGB(255, 61, 129, 251);
  static Color scaffoldBgColor = Color(0XFF0F1821);
  static Color appBarBgColor = Colors.grey.shade700;
  static Color appBarFgColor = Colors.white.withOpacity(.8);
  static Color secondaryContainer = Color(0xff1f2937);
  static Color onSecondaryContainer = const Color.fromARGB(255, 147, 156, 169);
  static Color outline = Color.fromARGB(255, 147, 156, 169);
  static Color error = Colors.red;
}
