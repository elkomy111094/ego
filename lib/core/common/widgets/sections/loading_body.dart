import 'package:flutter/material.dart';
import 'package:ego/core/common/widgets/misc/loading_indicator.dart';

class LoadingBody extends StatelessWidget {
  const LoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: LoadingIndicator()),
      ],
    );
  }
}
