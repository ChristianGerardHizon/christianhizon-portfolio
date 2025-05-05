import 'package:flutter/material.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientPrescriptionItemsGroup extends HookConsumerWidget {
  const PatientPrescriptionItemsGroup({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DynamicGroup(
            header: 'Prescriptions',
            headerAction: TextButton.icon(
              onPressed: () {},
              icon: Icon(MIcons.plus),
              label: const Text('Add'),
            ),
            items: [
              DynamicGroupItem.field(
                title: 'January 5, 2021',
                value: Column(
                  children: [
                    ListTile(
                      isThreeLine: true,
                      title: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'Diemnedrol'),
                            TextSpan(text: ' '),
                            TextSpan(
                              text: '(20mg)',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                      subtitle: Text('4 times a day. M W F. take after eating'),
                      trailing: IconButton(
                        icon: Icon(MIcons.trashCanOutline),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(MIcons.printerOutline),
                label: Text('Print'),
                onPressed: () {},
              ),
              TextButton.icon(
                icon: Icon(MIcons.filePdfBox),
                label: Text('Generate Pdf'),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
