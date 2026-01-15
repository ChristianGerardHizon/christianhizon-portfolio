import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/patients.routes.dart';
import '../controllers/paginated_patients_controller.dart';
import '../widgets/patient_list_panel.dart';

/// Patients list page for mobile view.
///
/// Shows the patient list panel and navigates to detail on tap.
class PatientsListPage extends ConsumerWidget {
  const PatientsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paginatedAsync = ref.watch(paginatedPatientsControllerProvider);

    return paginatedAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('Error: ${error.toString()}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref
                    .read(paginatedPatientsControllerProvider.notifier)
                    .refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (paginatedState) => PatientListPanel(
        paginatedState: paginatedState,
        selectedId: null,
        onPatientTap: (patient) {
          PatientDetailRoute(id: patient.id).push(context);
        },
        onRefresh: () =>
            ref.read(paginatedPatientsControllerProvider.notifier).refresh(),
        onLoadMore: () =>
            ref.read(paginatedPatientsControllerProvider.notifier).loadMore(),
      ),
    );
  }
}
