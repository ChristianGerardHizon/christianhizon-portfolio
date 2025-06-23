import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/assets/assets.gen.dart';
import 'package:sannjosevet/src/core/widgets/center_progress_indicator.dart';
import 'package:sannjosevet/src/core/widgets/pb_image_loader.dart';
import 'package:sannjosevet/src/core/widgets/photo_viewer.dart';

class PbImageCircle extends StatelessWidget {
  final String collection;
  final String? file;
  final String recordId;
  final BoxFit fit;
  final double radius;
  final bool viewable;

  const PbImageCircle({
    super.key,
    this.viewable = true,
    required this.file,
    required this.recordId,
    required this.collection,
    this.radius = 60,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (file == null || file!.isEmpty) {
      return SizedBox(
        width: radius,
        height: radius,
        child: const DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
        ),
      );
    }

    return SizedBox(
      width: radius,
      height: radius,
      child: PbImageLoader(
        collection: collection,
        file: file,
        id: recordId,
        placeholder: _circlePlaceholder(),
        builder: (url) {
          if (url == null || url.isEmpty) {
            return _circlePlaceholder();
          }

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: viewable ? () => PhotoViewer.show(context, url) : null,
            child: CachedNetworkImage(
              imageUrl: url,
              fit: fit,
              width: radius,
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: radius,
                  height: radius,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: fit,
                    ),
                  ),
                );
              },
              height: radius,
              alignment: Alignment.center,
              placeholder: (context, url) => _circleLoading(),
              errorWidget: (context, url, error) => _circleError(),
            ),
          );
        },
      ),
    );
  }

  Widget _circlePlaceholder() {
    return Container(
      width: radius,
      height: radius,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
      child: Assets.icons.appIconTransparent.image(
        fit: BoxFit.cover,
        width: radius,
        height: radius,
      ),
    );
  }

  Widget _circleLoading() {
    return Center(
      child: SizedBox(
        width: radius / 2,
        height: radius / 2,
        child: const CenteredProgressIndicator(),
      ),
    );
  }

  Widget _circleError() {
    return Container(
      width: radius,
      height: radius,
      color: Colors.grey[300],
      alignment: Alignment.center,
      child: Icon(Icons.error, size: radius / 2),
    );
  }
}
