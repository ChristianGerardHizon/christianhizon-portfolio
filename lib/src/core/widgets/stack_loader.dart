import 'package:flutter/material.dart';

class StackLoader extends StatelessWidget {
  final Widget child;
  final Widget? loader;
  final bool isLoading;
  final double opacity;

  const StackLoader({
    super.key,
    this.isLoading = false,
    required this.child,
    this.loader,
    this.opacity = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      child,
      if (isLoading)
        (loader ??
            Container(
              color: Colors.white.withValues(alpha: opacity),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              ),
            ))
    ]);
  }
}
