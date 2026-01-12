import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/patients.routes.dart';
import '../controllers/patients_controller.dart';
import 'empty_detail_state.dart';
import 'patient_list_panel.dart';

/// Two-pane tablet layout for patients.
///
/// Left pane: Patient list with search
/// Right pane: Patient detail from router or empty state
class TabletPatientsLayout extends ConsumerWidget {
  const TabletPatientsLayout({
    super.key,
    required this.detailChild,
  });

  /// The detail panel content from the router.
  final Widget detailChild;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientsAsync = ref.watch(patientsControllerProvider);

    // Get selected patient ID from current route
    final routerState = GoRouterState.of(context);
    final selectedPatientId = routerState.pathParameters['id'];

    return patientsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            Text('Error: ${error.toString()}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  ref.read(patientsControllerProvider.notifier).refresh(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (patients) => Row(
        children: [
          // List panel
          SizedBox(
            width: 320,
            child: PatientListPanel(
              patients: patients,
              selectedId: selectedPatientId,
              onPatientTap: (patient) {
                // Navigate using the route - this updates the URL and detail panel
                PatientDetailRoute(id: patient.id).go(context);
              },
              onRefresh: () =>
                  ref.read(patientsControllerProvider.notifier).refresh(),
            ),
          ),
          const VerticalDivider(width: 1),
          // Detail panel from router
          Expanded(
            child: selectedPatientId != null
                ? detailChild
                : const EmptyDetailState(),
          ),
        ],
      ),
    );
  }
}
