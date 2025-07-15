import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ego/core/common/widgets/picture.dart';

import '../../../app/sizes.dart';
import '../../utils/get_asset_path.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, this.title, this.externalWidget});
  final String? title;
  final Widget? externalWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: Picture(
            getAssetIcon("no_data.svg"),
            height: h100,
            width: h100,
          ),
        ),
        Gap(h20),
        Text(
          title ?? "",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        externalWidget ?? const SizedBox(),
      ],
    );
  }
}
