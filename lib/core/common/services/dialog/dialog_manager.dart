import 'package:flutter/material.dart';
import 'package:ego/app/get_it/get_it.dart';
import 'package:ego/core/common/services/dialog/dialog_service.dart';
import 'package:ego/core/common/services/dialog/models/dialog_request.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  const DialogManager({super.key, required this.child});

  @override
  State<DialogManager> createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final _dialogService = di<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest dialogRequest) {
    showDialog(
      useRootNavigator: false,
      context: dialogRequest.context,
      barrierDismissible: dialogRequest.dismissable,
      useSafeArea: true,
      builder: (context) {
        return dialogRequest.dialog;
      },
    );
  }
}
