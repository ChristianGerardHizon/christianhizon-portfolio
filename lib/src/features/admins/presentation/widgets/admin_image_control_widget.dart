import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/assets/assets.gen.dart';
import 'package:sannjosevet/src/core/packages/pocketbase_collections.dart';
import 'package:sannjosevet/src/core/widgets/pb_image_loader.dart';
import 'package:sannjosevet/src/core/widgets/photo_viewer.dart';
import 'package:sannjosevet/src/features/admins/domain/admin.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdminImageControlWidget extends StatelessWidget {
  final Admin admin;

  final Function() onUpload;
  final Function() onImageDiscard;

  const AdminImageControlWidget({
    super.key,
    required this.admin,
    required this.onUpload,
    required this.onImageDiscard,
  });

  @override
  Widget build(BuildContext context) {
    return PbImageLoader(
      collection: PocketBaseCollections.admins,
      file: admin.avatar ?? '',
      id: admin.id,
      placeholder: SizedBox(),
      builder: (url) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ResponsiveBuilder(builder: (context, si) {
            if (si.isMobile) {
              return Column(
                children: [
                  InkWell(
                      onTap: () => url != null && url.isNotEmpty
                          ? PhotoViewer.show(context, url)
                          : null,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: url == null || url.isEmpty
                            ? Assets.icons.appIconTransparent.provider()
                            : CachedNetworkImageProvider(url),
                      )),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton.icon(
                          onPressed: onUpload,
                          icon: const Icon(Icons.upload),
                          label: Text('Upload')),
                      SizedBox(width: 8),
                      FilledButton.icon(
                        onPressed: onImageDiscard,
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                        icon: const Icon(Icons.delete_outline),
                        label: Text('Delete'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              );
            }
            return Row(
              children: [
                InkWell(
                    onTap: () => url != null && url.isNotEmpty
                        ? PhotoViewer.show(context, url)
                        : null,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: url == null || url.isEmpty
                          ? Assets.icons.appIconTransparent.provider()
                          : CachedNetworkImageProvider(url),
                    )),
                Spacer(),
                FilledButton.icon(
                    onPressed: onUpload,
                    icon: const Icon(Icons.upload),
                    label: Text('Upload')),
                SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                  icon: const Icon(Icons.delete_outline),
                  label: Text('Delete'),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
