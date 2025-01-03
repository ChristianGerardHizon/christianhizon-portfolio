import 'package:flutter/material.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientsPage extends HookConsumerWidget {
  const PatientsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patientsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(patientsControllerProvider),
          )
        ],
      ),
      body: state.when(
        skipError: false,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => PatientPageRoute(data[index].id).go(context),
                title: Text(data[index].name),
              );
            },
          );
        },
      ),
    );
  }
}
