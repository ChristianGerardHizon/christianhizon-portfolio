import 'package:flutter/material.dart';
import 'package:gym_system/src/core/widgets/selectable_card.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';

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
          leading: Icon(Icons.abc),
          title: Text(patient.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(patient.name),
            ],
          )),
    );
  }
}
