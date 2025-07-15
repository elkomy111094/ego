import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class SnackBarBuilder {
  static showFeedBackMessage(BuildContext context, String message,
      {bool addBehaviour = true, bool isSuccess = true}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.start,
              message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        backgroundColor: isSuccess ? TLightModeColors.primaryColor : Colors.red,
        dismissDirection: DismissDirection.up,
        duration: const Duration(seconds: 1),
        behavior: addBehaviour ? SnackBarBehavior.floating : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
