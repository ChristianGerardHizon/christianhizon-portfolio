import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/widgets/image_viewer.dart';
import 'package:gym_system/src/core/widgets/photo_viewer.dart';
import 'package:gym_system/src/features/admins/domain/admin.dart';

class AdminCircleImage extends StatelessWidget {
  final Admin admin;
  final int radius;
  final bool isInteractable;
  const AdminCircleImage(
      {super.key,
      required this.admin,
      this.radius = 60,
      this.isInteractable = true});

  @override
  Widget build(BuildContext context) {
    // final file = patient.displayImage ?? '';
    final file = admin.avatar ?? '';
    if (file.isEmpty) {
      return Container(
        height: radius.toDouble() * 2,
        width: radius.toDouble() * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context)
              .colorScheme
              .primaryFixedDim, // or any other placeholder color
        ),
      );
    }
    return ImageViewer(
      feature: PocketBaseCollections.admins,
      file: file,
      id: admin.id,
      placeholder: SizedBox(),
      builder: (url) {
        return GestureDetector(
          onTap: isInteractable ? () => PhotoViewer.show(context, url) : null,
          child: Container(
            height: radius.toDouble(),
            width: radius.toDouble(),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: CachedNetworkImageProvider(url)),
            ),
          ),
        );
      },
    );
  }
}
