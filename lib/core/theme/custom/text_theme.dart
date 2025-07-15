import 'package:flutter/material.dart';
import 'package:ego/core/theme/colors.dart';
import '../../../app/sizes.dart';

// توحيد المقاسات لكلا الوضعين
final double headlineSmallSize = sp18;
final double headlineMediumSize = sp20;
final double headlineLargeSize = sp30;

final double titleSmallSize = sp14;
final double titleMediumSize = sp15;
final double titleLargeSize = sp18;

final double bodySmallSize = sp14;
final double bodyMediumSize = sp16;
final double bodyLargeSize = sp14;

final double labelSmallSize = sp8;
final double labelMediumSize = sp10;
final double labelLargeSize = sp12;

class TTextTheme {
  TTextTheme._();

  static TextTheme getTextTheme(Color textColor) => TextTheme (
    headlineSmall: TextStyle(
      fontSize: headlineSmallSize,
      fontWeight: FontWeight.bold,
      fontFamily: "Abel",
      color: textColor,
    ),
    headlineMedium: TextStyle(
      fontSize: headlineMediumSize,
      fontWeight: FontWeight.bold,
      fontFamily: "Abel",
      color: textColor,
    ),
    headlineLarge: TextStyle(
      fontSize: headlineLargeSize,
      fontWeight: FontWeight.bold,
      fontFamily: "Abel",
      color: textColor,
    ),
    titleSmall: TextStyle(
      fontSize: titleSmallSize,
      fontWeight: FontWeight.w500 , 
      fontFamily: "Abel",
      color: textColor,
    ),
    titleMedium: TextStyle(
      fontSize: titleMediumSize,
      fontWeight: FontWeight.w500 , 
      fontFamily: "Abel",
      color: textColor,
    ),
    titleLarge: TextStyle(
      fontSize: titleLargeSize,
      fontWeight: FontWeight.w500 , 
      fontFamily: "Abel",
      color: textColor,
    ),
    bodySmall: TextStyle(
      fontSize: bodySmallSize,
      fontWeight: FontWeight.w400 , 
      fontFamily: "Abel",
      color: textColor,
    ),
    bodyMedium: TextStyle(
      fontSize: bodyMediumSize,
      fontWeight: FontWeight.w400 , 
      fontFamily: "Abel",
      color: textColor,
    ),
    bodyLarge: TextStyle(
      fontSize: bodyLargeSize,
      fontWeight: FontWeight.w400 , 
      fontFamily: "Abel",
      color: textColor,
    ),
    labelSmall: TextStyle(
      fontSize: labelSmallSize,
      fontWeight: FontWeight.w400 , 
      fontFamily: "Abel",
      color: textColor,
    ),
    labelMedium: TextStyle(
      fontSize: labelMediumSize,
      fontWeight: FontWeight.w400 , 
      fontFamily: "Abel",
      color: textColor,
    ),
    labelLarge: TextStyle(
      fontSize: labelLargeSize,
      fontWeight: FontWeight.w400 , 
      fontFamily: "Abel",
      color: textColor,
    ),
  );

  static TextTheme lightTextTheme = getTextTheme(TLightModeColors.appBarFgColor);
  static TextTheme darkTextTheme = getTextTheme(TDarkModeColors.appBarFgColor);
}
