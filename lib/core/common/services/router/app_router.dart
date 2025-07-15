import 'package:flutter/material.dart';
import 'package:ego/app/app_wrapper.dart';
import 'package:ego/app/get_it/get_it.dart';

class AppRouter {
  //route and  remove  the  Current screen
  static pushReplace({required Widget screen}) {
    return navKey.currentState!.pushReplacement(
      MaterialPageRoute(
        builder: (context) => AppWrapper(child: screen),
      ),
    );
  }

// route without remove anything
  static Future push({required Widget screen}) {
    return navKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => AppWrapper(child: screen),
      ),
    );
  }

// Route and Remove all All pages in the stack
  static removeUntil({required Widget screen, required Widget screenToKeep}) {
    return navKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => AppWrapper(child: screen),
      ),
      (route) => route.settings.name == screenToKeep.runtimeType.toString(),
    );
  }

// GO BACK
  static pop({var dataToSendBack, BuildContext? specificContext}) {
    return specificContext == null
        ? navKey.currentState!.pop(dataToSendBack)
        : Navigator.of(specificContext).pop();
  }
}
