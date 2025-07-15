import 'package:flutter/material.dart';
import 'package:ego/core/common/widgets/misc/divider.dart';

class TitleSection extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const TitleSection({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextTheme.of(context).titleSmall,
              ),
              trailing ?? SizedBox.shrink()
            ],
          ),
        ),
        TDivider(),
      ],
    );
  }
}
