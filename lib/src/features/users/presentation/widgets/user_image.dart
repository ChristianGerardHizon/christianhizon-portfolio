import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/widgets/image_missing_view.dart';
import 'package:sannjosevet/src/features/users/domain/user.dart';

class UserImage extends StatelessWidget {
  final User user;
  final double width;

  const UserImage({super.key, required this.user, this.width = 80});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final value = user.avatar;
      if (value is String && value.isNotEmpty) {
        // return ImageViewer(
        //   builder: (url) => CachedNetworkImage(
        //     width: width,
        //     imageUrl: url,
        //     fit: BoxFit.fill,
        //     placeholder: (context, url) => SizedBox(
        //       child: Center(
        //         child: CircularProgressIndicator(),
        //       ),
        //     ),
        //     errorWidget: (context, url, error) =>
        //         Center(child: Icon(Icons.error)),
        //   ),
        //   feature: 'users',
        //   file: value,
        //   id: user.id,
        // );
      }

      return ImageMissingView();
    });
  }
}
