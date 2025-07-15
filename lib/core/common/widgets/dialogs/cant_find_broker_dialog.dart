import 'package:flutter/material.dart';
import 'package:ego/app/get_it/get_it.dart';
import 'package:ego/core/common/services/dialog/dialog_service.dart';

import '../../../localization/loc_keys.dart';

class CantFindBrokerDialog extends StatefulWidget {
  const CantFindBrokerDialog({super.key});

  @override
  State<CantFindBrokerDialog> createState() => _CantFindBrokerDialogState();
}

class _CantFindBrokerDialogState extends State<CantFindBrokerDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(8),
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 0),
      titlePadding: EdgeInsets.only(left: 14, right: 14, top: 18, bottom: 8),
      buttonPadding: EdgeInsets.all(10),
      scrollable: true,
      title: Text(
        Loc.cantFindBrokerTitle(),
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Text(
        Loc.cantFindBrokerMessage(),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      actions: [
        TextButton(
          onPressed: () {
            final _dialogService = di<DialogService>();
            _dialogService.hideDialog(context);
          },
          child: Text(Loc.okButton()),
        )
      ],
    );
  }
}
