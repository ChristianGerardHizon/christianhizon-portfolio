import 'package:flutter/material.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MedicalRecordPage extends HookConsumerWidget {
  final String id;
  final String patientId;
  const MedicalRecordPage({
    super.key,
    required this.id,
    required this.patientId,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(
          onPressed: () {
            return PatientPageRoute(patientId, page: 1).go(context);
          },
        ),
        title: Text('Medical Record'),
      ),
      body: Center(
        child: Text(id),
      ),
    );
  }
}
