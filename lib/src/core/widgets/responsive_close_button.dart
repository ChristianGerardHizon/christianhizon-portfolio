import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveCloseButton extends StatelessWidget {
  
  const ResponsiveCloseButton({super.key});
  @override

  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, si) {
      if (si.isMobile) {
        return IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close));
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
