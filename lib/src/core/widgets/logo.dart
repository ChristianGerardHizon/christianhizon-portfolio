
import 'package:flutter/material.dart';
import 'package:gym_system/src/core/assets/assets.gen.dart';

class Logo extends StatelessWidget {

  final EdgeInsets padding;
  final double? width;
  final double? height;

  const Logo({super.key, this.padding = const EdgeInsets.all(10), this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: DecoratedBox(
            decoration: BoxDecoration(
            // border: Border.all(color: Colors.black),
            ),
            child: Assets.icons.appIconTransparent.image(width: width, height: height),
          ),
    );
  }
}
