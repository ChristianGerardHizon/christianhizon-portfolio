import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/features/history/presentation/widgets/history_type_selector.dart';
import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patient_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients_controller.dart';
import 'package:gym_system/src/features/patients/presentation/widgets/patient_circle_image.dart';
import 'package:gym_system/src/features/patients/presentation/widgets/sliver_patient_details.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tab_container/tab_container.dart';

class PatientPage extends HookConsumerWidget {
  const PatientPage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = patientControllerProvider(id);
    final state = ref.watch(provider);

    ///
    /// onDelete
    ///
    onDelete() async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(patientRepositoryProvider);
      repo.softDeleteMulti([id]).run().then((result) {
            result.fold(
              (l) => AppSnackBar.rootFailure(l),
              (r) {
                ref.invalidate(patientsControllerProvider);
                AppSnackBar.root(message: 'Successfully Deleted');
                PatientsPageRoute().go(context);
              },
            );
          });
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        print('test');
      },
      child: Scaffold(
        body: state.when(
          skipError: false,
          skipLoadingOnRefresh: false,
          skipLoadingOnReload: false,
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          data: (patient) {
            return CustomScrollView(
              slivers: [
                ///
                /// AppBar
                ///
                SliverAppBar(
                  leading: BackButton(
                    onPressed: () => PatientsPageRoute().go(context),
                  ),
                  title: Text(patient.name),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => PatientUpdatePageRoute(id).go(context),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => onDelete(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () => ref.invalidate(provider),
                    )
                  ],
                ),

                ///
                /// Picture
                ///
                SliverPadding(
                  padding: const EdgeInsets.only(top: 20, bottom: 30),
                  sliver: SliverToBoxAdapter(
                    child: SizedBox(
                      height: 250,
                      child: PatientCircleImage(
                        radius: 120,
                        patient: patient,
                      ),
                    ),
                  ),
                ),

                ///
                /// Tabs
                ///
                SliverToBoxAdapter(
                  child: HistoryTypeSelector(
                    onPress: (type) {},
                  ),
                ),

                ///
                /// Patient Details
                ///
                SliverPatientDetails(patient: patient),

                ///
                /// Spacer
                ///
                SliverToBoxAdapter(child: SizedBox(height: 50)),
              ],
            );
          },
        ),
      ),
    );
  }
}
