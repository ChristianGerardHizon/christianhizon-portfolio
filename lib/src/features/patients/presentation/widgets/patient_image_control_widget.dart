import 'package:flutter/material.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/widgets/circle_widget.dart';
import 'package:gym_system/src/core/widgets/pb_image_circle.dart';
import 'package:gym_system/src/core/widgets/pb_image_loader.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';

class PatientImageControlWidget extends StatelessWidget {
  final Patient patient;

  final Function() onUpload;
  final Function() onImageDiscard;

  const PatientImageControlWidget({
    super.key,
    required this.patient,
    required this.onUpload,
    required this.onImageDiscard,
  });

  @override
  Widget build(BuildContext context) {
    return PbImageLoader(
      collection: PocketBaseCollections.patients,
      file: patient.avatar ?? '',
      id: patient.id,
      placeholder: SizedBox(),
      builder: (url) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleWidget(
                size: 250,
                child: PbImageCircle(
                  radius: 250,
                  collection: patient.collectionId,
                  recordId: patient.id,
                  file: patient.avatar,
                  fit: BoxFit.cover,
                ),
              ),
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
          ),
        );
      },
    );
  }
}
