import 'package:flutter/material.dart';
import 'package:ego/core/common/widgets/picture.dart';

import '../../../app/sizes.dart';
import '../../utils/get_asset_path.dart';

class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({super.key, this.title, this.subTitle});
  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Picture(getAssetIcon("no_connection.svg")),
        Text(
          title ?? "",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: h20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w70),
          child: Text(
            subTitle ?? "",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
