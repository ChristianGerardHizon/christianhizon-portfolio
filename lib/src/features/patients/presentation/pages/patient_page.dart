import 'package:flutter/material.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patient_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients_controller.dart';
import 'package:gym_system/src/features/patients/presentation/widgets/patient_circle_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      repo.delete(id).run().then((result) {
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

    return Scaffold(
      body: state.when(
        skipError: false,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (patient) {
          return CustomScrollView(
            slivers: [
              /// AppBar
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

              SliverToBoxAdapter(
                child: SizedBox(
                  height: 250,
                  child: PatientCircleImage(
                    radius: 120,
                    patient: patient,
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverList.list(children: [
                  SizedBox(height: 30),

                  ///
                  /// Header
                  ///
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 14),
                    title: Text(
                      'Patient Info',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

                  ///
                  /// name
                  ///
                  ListTile(
                    leading: Text('Name: '),
                    title: Text(patient.name),
                  ),

                  /// Breed
                  ListTile(
                    leading: Text('Breed: '),
                    title: Text(patient.breed.optional()),
                  ),

                  ListTile(
                    leading: Text('Species: '),
                    title: Text(patient.species.optional()),
                  ),

                  ///
                  /// owner
                  ///
                  ListTile(
                    leading: Text('Owner: '),
                    title: Text(patient.owner.optional()),
                  ),

                  ///
                  /// address
                  ///
                  ListTile(
                    leading: Text('Address: '),
                    title: Text(patient.address.optional()),
                  ),

                  ///
                  /// date of birth
                  ///
                  ListTile(
                    leading: Text('Date of Birth: '),
                    title: Text(
                        (patient.dateOfBirth?.toLocal().toString()).optional()),
                  ),

                  ///
                  /// created
                  ///
                  ListTile(
                    leading: Text('Created At: '),
                    title: Text(
                        (patient.created?.toLocal().toString()).optional()),
                  ),

                  ///
                  /// updated
                  ///
                  ListTile(
                    leading: Text('Updated At: '),
                    title: Text(
                        (patient.created?.toLocal().toString()).optional()),
                  ),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
