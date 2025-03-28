import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gym_system/src/core/widgets/pb_image_loader.dart';

class PbImageCircle extends StatelessWidget {
  final String collection;
  final String? file;
  final String recordId;
  final BoxFit fit;
  final double radius;
  const PbImageCircle({
    super.key,
    required this.file,
    required this.recordId,
    required this.collection,
    this.radius = 60,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    if (file == null || (file ?? '').isEmpty) {
      return SizedBox(
        width: radius,
        height: radius,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
      );
    }
    return SizedBox(
      width: radius,
      height: radius,
      child: PbImageLoader(
        collection: collection,
        file: file!,
        id: recordId,
        placeholder: SizedBox(),
        builder: (url) {
          return DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: fit,
                image: CachedNetworkImageProvider(url),
              ),
            ),
          );
        },
      ),
    );
  }
}
