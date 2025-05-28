import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/assets/assets.gen.dart';

class Logo extends StatelessWidget {
  final EdgeInsets padding;
  final double? width;
  final double? height;

  const Logo({
    super.key,
    this.padding = const EdgeInsets.all(10),
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: DecoratedBox(
        decoration: BoxDecoration(
            // border: Border.all(color: Colors.black),
            ),
        child: Builder(
          builder: (context) => SizedBox(
            width: width,
            height: height,
            child: Builder(builder: (context) {
              if (kDebugMode)
                // if (false)
                // ignore: dead_code
                return Placeholder(
                  fallbackHeight: height ?? 400,
                  fallbackWidth: width ?? 400,
                );

              return Assets.icons.appIconTransparent.image(
                fit: BoxFit.fill,
              );
            }),
          ),
        ),
      ),
    );
  }
}
