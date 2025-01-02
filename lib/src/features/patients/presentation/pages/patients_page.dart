import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientsPage extends HookConsumerWidget {
  const PatientsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
      ),
      body: Center(
        child: Text('PatientsPage'),
      ),
    );
  }
}
