import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/selectable_card.dart';
import 'package:sannjosevet/src/features/patient_files/domain/patient_file.dart';

class PatientFileCard extends StatelessWidget {
  const PatientFileCard({
    super.key,
    required this.patientFile,
    required this.onLongPress,
    required this.onTap,
    this.selected = false,
  });

  final Function() onLongPress;
  final Function() onTap;
  final bool selected;
  final PatientFile patientFile;

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      margin: EdgeInsets.all(8),
      onLongPress: onLongPress,
      onTap: onTap,
      selected: selected,
      child: ListTile(
        isThreeLine: true,
        leading: Icon(patientFile.isImage ? MIcons.image : MIcons.fileOutline),
        title: Text(patientFile.file),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text((patientFile.notes).optional()),
          ],
        ),
      ),
    );
  }
}
