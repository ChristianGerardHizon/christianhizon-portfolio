import 'package:flutter/material.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patient_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientPage extends HookConsumerWidget {
  const PatientPage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = patientControllerProvider(id);
    final state = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => PatientsPageRoute().go(context),
        ),
        title: Text('Patient'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(provider),
          )
        ],
      ),
      body: state.when(
        skipError: false,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (patient) {
          return ListView(
            children: [
              ///
              /// name
              ///
              ListTile(
                title: Text(patient.name),
              ),

              ///
              /// created
              ///
              ListTile(
                title: Text(patient.created.toIso8601String()),
              ),

              ///
              /// updated
              ///
              ListTile(
                title: Text(patient.created.toIso8601String()),
              ),
            ],
          );
        },
      ),
    );
  }
}
