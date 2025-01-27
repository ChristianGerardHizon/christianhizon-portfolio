import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveTwoFields extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveTwoFields({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, si) {
      ///
      /// One Cloumn
      ///
      if (!si.isMobile) {
        return Column(
          children: [],
        );
      }

      ///
      ///  Two Columns
      ///
      return Row(
        children: [],
      );
    });
  }
}
