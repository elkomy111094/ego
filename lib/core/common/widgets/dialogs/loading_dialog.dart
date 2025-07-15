import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ego/core/common/widgets/misc/loading_indicator.dart';

import '../../../../app/sizes.dart';
import '../../../localization/loc_keys.dart';
import '../custom_dialog.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: h30,
        height: h30, 
        child: CustomDialog(title: Loc.pleaseWait(), content: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary,), message: '',));
  }
}
