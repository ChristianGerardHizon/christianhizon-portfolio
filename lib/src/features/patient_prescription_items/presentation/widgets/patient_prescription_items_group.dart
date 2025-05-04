import 'package:flutter/material.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientPrescriptionItemsGroup extends HookConsumerWidget {
  const PatientPrescriptionItemsGroup({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DynamicGroup(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
      header: 'Prescriptions',
      headerAction: TextButton(
        onPressed: () {},
        child: const Text('Print'),
      ),
      items: [
        DynamicGroupItem.field(
          title: 'January 5, 2021',
          value: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  child: Text('1'),
                ),
                title: Text('Sample'),
                subtitle: Text('Sample'),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Text('1'),
                ),
                title: Text('Sample'),
                subtitle: Text('Sample'),
              )
            ],
          ),
        ),
        DynamicGroupItem.field(
          title: 'January 4, 2021',
          value: Column(
            children: [
              ListTile(
                title: Text('Sample'),
                subtitle: Text('Sample'),
              ),
              ListTile(
                title: Text('Sample'),
                subtitle: Text('Sample'),
              )
            ],
          ),
        ),
        
      ],
    );
  }
}
