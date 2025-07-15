import 'package:flutter/material.dart';
import 'package:ego/app/get_it/get_it.dart';
import 'package:ego/core/common/services/dialog/dialog_service.dart';
import 'package:ego/core/constants/constants.dart';
import 'package:ego/core/theme/theme_cubit/theme_cubit.dart';

import '../../../localization/loc_keys.dart';

class SelectThemeDialog extends StatefulWidget {
  const SelectThemeDialog({super.key});

  @override
  State<SelectThemeDialog> createState() => _SelectThemeDialogState();
}

class _SelectThemeDialogState extends State<SelectThemeDialog> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        final _dialogService = di<DialogService>();
        final _themeCubit = di<AppCubit>();

        return AlertDialog(
          insetPadding: const EdgeInsets.all(8),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
          titlePadding: const EdgeInsets.only(left: 14, right: 14, top: 18, bottom: 8),
          buttonPadding: const EdgeInsets.all(10),
          scrollable: true,
          title: Text(
            Loc.chooseThemeTitle(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  Loc.systemDefault(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                value: ThemeEnums.system.name,
                groupValue: _themeCubit.themeMode?.name,
                onChanged: (value) {
                  setState(() {
                    _themeCubit.setFollowSystemMode();
                  });
                },
              ),
              RadioListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  Loc.lightTheme(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                value: ThemeEnums.light.name,
                groupValue: _themeCubit.themeMode?.name,
                onChanged: (value) {
                  setState(() {
                    _themeCubit.setLightMode();
                  });
                },
              ),
              RadioListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  Loc.darkTheme(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                value: ThemeEnums.dark.name,
                groupValue: _themeCubit.themeMode?.name,
                onChanged: (value) {
                  setState(() {
                    _themeCubit.setDarkMode();
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _dialogService.hideDialog(context);
              },
              child: Text(Loc.cancelButton()),
            ),
          ],
        );
      },
    );
  }
}
