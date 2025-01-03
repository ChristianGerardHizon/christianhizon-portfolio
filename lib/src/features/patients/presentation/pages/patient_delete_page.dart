import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientDeletePage extends HookConsumerWidget {
  const PatientDeletePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Delete Page'),
      ),
      body: Center(
        child: Text('Patient Delete Page'),
      ),
    );
  }
}
