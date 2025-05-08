import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final Widget child;
  final Size size;
  const CircleWidget({super.key, required this.child, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: child,
        ),
      ),
    );
  }
}
