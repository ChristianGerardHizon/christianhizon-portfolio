import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/extensions/date_time_extension.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/popover_widget.dart';
import 'package:sannjosevet/src/core/widgets/selectable_card.dart';
import 'package:sannjosevet/src/features/patient_records/domain/patient_record.dart';

class PatientRecordCard extends StatelessWidget {
  const PatientRecordCard({
    super.key,
    required this.patientRecord,
    required this.onLongPress,
    required this.onTap,
    this.selected = false,
  });

  final Function() onLongPress;
  final Function() onTap;
  final bool selected;
  final PatientRecord patientRecord;

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      margin: EdgeInsets.all(8),
      onLongPress: onLongPress,
      onTap: onTap,
      selected: selected,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(MIcons.medicalCottonSwab),
            title: Text(
              (patientRecord.visitDate.fullDateTime).optional(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: PopoverWidget.icon(
              icon: Icon(MIcons.dotsHorizontal),
              bottomSheetHeader: const Text('Action'),
              items: [
                PopoverMenuItemData(
                  name: 'Change Status',
                  onTap: () {},
                ),
                PopoverMenuItemData(
                  name: 'View',
                  onTap: () {},
                ),
                PopoverMenuItemData(
                  name: 'Edit',
                  onTap: () {},
                ),
                PopoverMenuItemData(
                  name: 'Delete',
                  onTap: () {},
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16)
                  .copyWith(bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                            text: 'Patient: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        TextSpan(
                          text: patientRecord.patient.optional(),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                            text: 'Diagnosis: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        TextSpan(
                          text: patientRecord.diagnosis.optional(),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                            text: 'Treatment: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        TextSpan(
                          text: patientRecord.treatment.optional(),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                            text: 'Weight: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        TextSpan(
                          text: patientRecord.displayWeightInKg.optional(),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
