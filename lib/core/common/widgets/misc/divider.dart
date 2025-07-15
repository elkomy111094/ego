import 'package:flutter/material.dart';

class TDivider extends StatelessWidget {
  final bool? vertical;
  final double? thickness;
  const TDivider({
    super.key,
    this.vertical = false,
    this.thickness = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return vertical == true
        ? VerticalDivider(
            color: Theme.of(context).colorScheme.outline,
            thickness: thickness,
          )
        : Divider(
            color: Theme.of(context).colorScheme.outline,
            thickness: thickness,
          );
  }
}
