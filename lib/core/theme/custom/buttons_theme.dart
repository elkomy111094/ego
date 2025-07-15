import 'package:flutter/material.dart';
import 'package:ego/core/theme/colors.dart';

import '../../../app/sizes.dart';

class TButtonsTheme {
  TButtonsTheme._();

  //? Filled Button
  static FilledButtonThemeData lightFilledButtonStyle = FilledButtonThemeData(
      style: ButtonStyle(
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(r4),
    )),
  ));
  static FilledButtonThemeData darkFilledButtonStyle = FilledButtonThemeData(
      style: ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(Colors.white),
    iconColor: WidgetStatePropertyAll(Colors.white),
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(r4),
    )),
  ));

  //? Outlined Button
  static OutlinedButtonThemeData lightOutlinedButtonStyle =
      OutlinedButtonThemeData(
          style: ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(TDarkModeColors.primaryColor),
    iconColor: WidgetStatePropertyAll(Colors.white),
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(r4),
    )),
    side: WidgetStatePropertyAll(BorderSide(
      color: TDarkModeColors.primaryColor,
    )),
  ));
  static OutlinedButtonThemeData darkOutlinedButtonStyle =
      OutlinedButtonThemeData(
          style: ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(TDarkModeColors.primaryColor),
    iconColor: WidgetStatePropertyAll(Colors.white),
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(r4),
    )),
    side: WidgetStatePropertyAll(BorderSide(
      color: TDarkModeColors.primaryColor,
    )),
  ));
}
