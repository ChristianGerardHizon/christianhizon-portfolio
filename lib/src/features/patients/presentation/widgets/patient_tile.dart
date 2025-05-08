import 'package:flutter/material.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/widgets/circle_widget.dart';
import 'package:gym_system/src/core/widgets/pb_image_circle.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';

class PatientTile extends StatelessWidget {
  const PatientTile({super.key, required this.patient});
  final Patient patient;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleWidget(
        size: Size.square(40),
        child: PbImageCircle(
          collection: patient.collectionId,
          recordId: patient.id,
          file: patient.avatar,
          fit: BoxFit.fitWidth,
        ),
      ),
      title: Text(patient.name),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodySmall,
              children: [
                TextSpan(
                  text: patient.expand.breed?.name.optional(),
                ),
                TextSpan(text: ' - '),
                TextSpan(
                  text: patient.expand.species?.name.optional(),
                ),
              ],
            ),
          ),
          Text(
            'Owner: ${patient.owner?.optional()}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
