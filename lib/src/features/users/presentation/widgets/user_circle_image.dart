import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/assets/assets.gen.dart';
import 'package:sannjosevet/src/core/packages/pocketbase_collections.dart';
import 'package:sannjosevet/src/core/widgets/center_progress_indicator.dart';
import 'package:sannjosevet/src/core/widgets/pb_image_loader.dart';
import 'package:sannjosevet/src/core/widgets/photo_viewer.dart';
import 'package:sannjosevet/src/features/users/domain/user.dart';

class UserCircleImage extends StatelessWidget {
  final User user;
  final bool isInteractable;
  final double radius;
  final BoxFit fit;

  const UserCircleImage({
    super.key,
    required this.user,
    this.radius = 60,
    this.isInteractable = true,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    // final file = patient.displayImage ?? '';
    final file = user.avatar ?? '';
    if (file.isEmpty) {
      return SizedBox(
        width: radius,
        height: radius,
        child: Assets.icons.appIconTransparent.image(
          fit: BoxFit.cover,
          width: radius,
          height: radius,
        ),
      );
    }
    return PbImageLoader(
      collection: PocketBaseCollections.users,
      file: file,
      id: user.id,
      placeholder: _circlePlaceholder(),
      builder: (url) {
        if (url == null || url.isEmpty) {
          return _circlePlaceholder();
        }

        return GestureDetector(
          onTap: isInteractable && url != null && url.isNotEmpty
              ? () => PhotoViewer.show(context, url)
              : null,
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
      width: radius.toDouble(),
      height: radius.toDouble(),
      color: Colors.grey[300],
      alignment: Alignment.center,
      child: Icon(Icons.error, size: radius / 2),
    );
  }
}
