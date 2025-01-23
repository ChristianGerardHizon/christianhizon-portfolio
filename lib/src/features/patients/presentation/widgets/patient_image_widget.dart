import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/widgets/image_viewer.dart';
import 'package:gym_system/src/core/widgets/photo_viewer.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PatientImageWidget extends StatelessWidget {
  final Patient patient;

  final Function() onUpload;
  final Function() onImageDiscard;

  const PatientImageWidget({
    super.key,
    required this.patient,
    required this.onUpload,
    required this.onImageDiscard,
  });

  @override
  Widget build(BuildContext context) {
    return ImageViewer(
      feature: PocketBaseCollections.patients,
      file: patient.displayImage ?? '',
      id: patient.id,
      placeholder: SizedBox(),
      builder: (url) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ResponsiveBuilder(builder: (context, si) {
            if (si.isMobile) {
              return Column(
                children: [
                  InkWell(
                      onTap: () => PhotoViewer.show(context, url),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: CachedNetworkImageProvider(url),
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
                    onTap: () => PhotoViewer.show(context, url),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: CachedNetworkImageProvider(url),
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
