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
                    icon: const Icon(Icons.update),
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
              )),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverList.list(children: [
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

              ///
              /// row of images scrolling horizontally
              ///
              // ref.watch(settingsControllerProvider).when(
              //       skipError: false,
              //       skipLoadingOnRefresh: false,
              //       skipLoadingOnReload: false,
              //       loading: () =>
              //           const Center(child: CircularProgressIndicator()),
              //       error: (error, stackTrace) =>
              //           Center(child: Text(error.toString())),
              //       data: (settings) {
              //         return Container(
              //           height: 100,
              //           child: ListView.builder(
              //             scrollDirection: Axis.horizontal,
              //             itemCount: patient.images.length,
              //             itemBuilder: (context, index) {
              //               final imageUrl =
              //                   '${settings.domain}/api/files/${PocketBaseCollections.patients}/$id/${patient.images[index]}';
              //               return Stack(
              //                 children: [
              //                   ///
              //                   /// image
              //                   ///
              //                   Padding(
              //                     padding: EdgeInsets.only(right: 15, top: 15),
              //                     child: InkWell(
              //                       onTap: () =>
              //                           PhotoViewer.show(context, imageUrl),
              //                       child: Image.network(imageUrl),
              //                     ),
              //                   ),

              //                   ///
              //                   /// delete
              //                   ///
              //                   Positioned(
              //                     right: 0,
              //                     top: 0,
              //                     child: Container(
              //                       decoration: BoxDecoration(
              //                         borderRadius: BorderRadius.circular(20),
              //                         color: Colors.white,
              //                         boxShadow: [
              //                           BoxShadow(
              //                             offset: const Offset(0, 2),
              //                             blurRadius: 4,
              //                             color: Colors.black12,
              //                           ),
              //                         ],
              //                       ),
              //                       child: IconButton(
              //                         icon: const Icon(
              //                           Icons.delete,
              //                           color: Colors.red,
              //                           size: 20,
              //                         ),
              //                         onPressed: () {},
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               );
              //             },
              //           ),
              //         );
              //       },
              //     ),

              ///
              /// breed
              ///
            ],
          );
        },
      ),
    );
  }
}
