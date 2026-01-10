import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/widgets/selectable_card.dart';
import 'package:sannjosevet/src/features/patients/breeds/domain/patient_breed.dart';

class PatientBreedCard extends StatelessWidget {
  const PatientBreedCard({
    super.key,
    required this.patientBreed,
    required this.onLongPress,
    required this.onTap,
    this.selected = false,
  });

  final Function() onLongPress;
  final Function() onTap;
  final bool selected;
  final PatientBreed patientBreed;

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      margin: EdgeInsets.all(8),
      onLongPress: onLongPress,
      onTap: onTap,
      selected: selected,
      child: ListTile(
        title: Text(patientBreed.name),
      ),
    );
  }
}
