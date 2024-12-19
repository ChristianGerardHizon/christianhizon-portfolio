import 'package:flutter/material.dart';
import 'package:gym_system/src/core/assets/assets.gen.dart';


///
/// Simple widget for showing a missing image
/// for when an image is missing
///
///
class ImageMissingView extends StatelessWidget {
  final double maxHeight;
  const ImageMissingView({super.key, this.maxHeight = 120});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Assets.icons.appIconTransparent.image(height: maxHeight),
    );
  }
}
