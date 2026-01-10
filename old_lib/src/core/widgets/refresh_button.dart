import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:math';

class RefreshButton extends HookWidget {
  final VoidCallback onPressed;

  const RefreshButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );
    final scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    void _animateAndRefresh() {
      controller.forward(from: 0.0);
      onPressed();
    }

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: controller.value * 2 * pi,
          child: Transform.scale(
            scale: scaleAnimation.value,
            child: IconButton(
              icon: const Icon(Icons.refresh),
              color: null, // Use default icon button color
              onPressed: _animateAndRefresh,
            ),
          ),
        );
      },
    );
  }
}
