import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/widgets/image_viewer.dart';
import 'package:gym_system/src/core/widgets/photo_viewer.dart';
import 'package:gym_system/src/features/users/domain/user.dart';

class UserCircleImage extends StatelessWidget {
  final User user;
  final int radius;
  const UserCircleImage({super.key, required this.user, this.radius = 60});

  @override
  Widget build(BuildContext context) {
    // final file = patient.displayImage ?? '';
    final file = '';
    if (file.isEmpty) {
      return CircleAvatar(radius: radius.toDouble());
    }
    return ImageViewer(
      feature: PocketBaseCollections.patients,
      file: file,
      id: user.id,
      placeholder: SizedBox(),
      builder: (url) {
        return GestureDetector(
          onTap: () => PhotoViewer.show(context, url),
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
