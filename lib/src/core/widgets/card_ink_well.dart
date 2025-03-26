import 'package:flutter/material.dart';

class CardInkWell extends StatelessWidget {
  final Function()? onTap;
  final Function()? onLongPress;
  final Widget? child;

  const CardInkWell({
    super.key,
    this.onTap,
    this.onLongPress,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onLongPress: onLongPress,
      onTap: onTap,
      child: child,
    );
  }
}
