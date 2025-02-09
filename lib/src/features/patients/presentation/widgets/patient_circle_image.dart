import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/widgets/image_viewer.dart';
import 'package:gym_system/src/core/widgets/photo_viewer.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';

class PatientCircleImage extends StatelessWidget {
  final Patient patient;
  final BoxFit fit;
  final int radius;
  const PatientCircleImage(
      {super.key, required this.patient, this.radius = 60, this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    final file = patient.avatar ?? '';

    if (file.isEmpty) {
      return CircleAvatar(radius: radius.toDouble());
    }
    return ImageViewer(
      feature: PocketBaseCollections.patients,
      file: file,
      id: patient.id,
      placeholder: SizedBox(),
      builder: (url) {
        return GestureDetector(
          onTap: () => PhotoViewer.show(context, url),
          child: Container(
            height: radius.toDouble(),
            width: radius.toDouble(),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              
              image: DecorationImage(
                fit: fit,
                image: CachedNetworkImageProvider(url)),
            ),
          ),
        );
      },
    );
  }
}
