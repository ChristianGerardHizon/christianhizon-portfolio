import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/core/widgets/circle_widget.dart';
import 'package:sannjosevet/src/core/widgets/pb_image_circle.dart';
import 'package:sannjosevet/src/core/widgets/selectable_card.dart';
import 'package:sannjosevet/src/features/patients/domain/patient.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({
    super.key,
    required this.patient,
    required this.onLongPress,
    required this.onTap,
    this.selected = false,
  });

  final Function() onLongPress;
  final Function() onTap;
  final bool selected;
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      margin: EdgeInsets.all(8),
      onLongPress: onLongPress,
      onTap: onTap,
      selected: selected,
      child: ListTile(
        leading: CircleWidget(
          size: Size(60, 120),
          child: PbImageCircle(
            collection: patient.collectionId,
            recordId: patient.id,
            file: patient.avatar,
            fit: BoxFit.contain,
          ),
        ),
        title:
            Text(patient.name, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodySmall,
                children: [
                  TextSpan(
                    text: (patient.expand.species?.name).optional(),
                  ),
                  TextSpan(
                    text: ' | ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: (patient.expand.breed?.name).optional(),
                  ),
                ],
              ),
            ),
            RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodySmall,
                children: [
                  TextSpan(
                    text: 'Owner',
                  ),
                  TextSpan(
                    text: ' : ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: (patient.owner).optional(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
