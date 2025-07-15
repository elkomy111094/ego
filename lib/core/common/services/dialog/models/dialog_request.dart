import 'package:flutter/material.dart';

class DialogRequest {
  final bool dismissable;
  final Widget dialog;
  final BuildContext context;
  DialogRequest({
    required this.context,
    required this.dismissable,
    required this.dialog,
  });
}
