import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ego/core/common/services/dialog/models/dialog_request.dart';
import 'package:ego/core/common/services/dialog/models/dialog_response.dart';
import 'package:ego/core/common/services/router/app_router.dart';

class DialogService {
  Function(DialogRequest)? _dialogListener;
  Completer? _dialogCompleter;

  void registerDialogListener(Function(DialogRequest) dialogListener) {
    _dialogListener = dialogListener;
  }

  Future? showDialog({
    required BuildContext context,
    required bool dismissable,
    required Widget dialog,
  }) {
    _dialogCompleter = Completer();
    _dialogListener!(DialogRequest(
      context: context,
      dismissable: dismissable,
      dialog: dialog,
    ));
    return _dialogCompleter?.future;
  }

  void hideDialog(context) {
    _dialogCompleter?.complete();
    _dialogCompleter = null;
    Navigator.of(context).pop();
  }
}
