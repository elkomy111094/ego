import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScaffoldWrapper extends StatefulWidget {
  final Widget child;
  const ScaffoldWrapper({
    super.key,
    required this.child,
  });

  @override
  State<ScaffoldWrapper> createState() => _ScaffoldWrapperState();
}

class _ScaffoldWrapperState extends State<ScaffoldWrapper> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: widget.child,
    );
  }
}
