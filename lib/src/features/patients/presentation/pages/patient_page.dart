import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/utils/file_picker.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/image_viewer.dart';
import 'package:gym_system/src/core/widgets/photo_viewer.dart';
import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patient_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:responsive_builder/responsive_builder.dart';

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

    ///
    /// onUpload
    ///
    onUpload(Patient patient) async {
      final repo = ref.read(patientRepositoryProvider);

      final result = await TaskResult<Patient?>.Do(($) async {
        final images = await $(FilePickerUtil.getImage('displayImage'));
        if (images == null || images.isEmpty) return $(TaskResult.right(null));
        return $(repo.update(patient, {}, files: images));
      }).run();

      result.fold((l) => AppSnackBar.rootFailure(l), (r) {
        if (r == null) return;
        ref.invalidate(provider);
        AppSnackBar.root(message: 'Successfully Updated');
      });
    }

    ///
    /// onImageDiscard
    ///
    onImageDiscard() {
      final repo = ref.read(patientRepositoryProvider);
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
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text('Display Picture')),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: ImageViewer(
                  feature: PocketBaseCollections.patients,
                  file: patient.displayImage ?? '',
                  id: patient.id,
                  builder: (url) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: ResponsiveBuilder(builder: (context, si) {
                        if (si.isMobile) {
                          return Column(
                            children: [
                              InkWell(
                                  onTap: () => PhotoViewer.show(context, url),
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        CachedNetworkImageProvider(url),
                                  )),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FilledButton.icon(
                                      onPressed: () => onUpload(patient),
                                      icon: const Icon(Icons.upload),
                                      label: Text('Upload')),
                                  SizedBox(width: 8),
                                  FilledButton.icon(
                                    onPressed: () {},
                                    style: FilledButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                    icon: const Icon(Icons.delete_outline),
                                    label: Text('Delete'),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        }
                        return Row(
                          children: [
                            InkWell(
                                onTap: () => PhotoViewer.show(context, url),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage:
                                      CachedNetworkImageProvider(url),
                                )),
                            Spacer(),
                            FilledButton.icon(
                                onPressed: () => onUpload(patient),
                                icon: const Icon(Icons.upload),
                                label: Text('Upload')),
                            SizedBox(width: 8),
                            FilledButton.icon(
                              onPressed: () {},
                              style: FilledButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.error,
                              ),
                              icon: const Icon(Icons.delete_outline),
                              label: Text('Delete'),
                            ),
                          ],
                        );
                      }),
                    );
                  },
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverList.list(children: [
                  ///
                  /// name
                  ///
                  ListTile(
                    title: Text(patient.name),
                  ),

                  ListTile(
                    subtitle: Text('Breed'),
                    title: Text(patient.breed.optional()),
                  ),

                  ///
                  /// owner
                  ///
                  ListTile(
                    title: Text(patient.owner.optional()),
                  ),

                  ///
                  /// address
                  ///
                  ListTile(
                    title: Text(patient.address.optional()),
                  ),

                  ///
                  /// date of birth
                  ///
                  ListTile(
                    title: Text(
                        (patient.dateOfBirth?.toLocal().toString()).optional()),
                  ),

                  ///
                  /// created
                  ///
                  ListTile(
                    title: Text(
                        (patient.created?.toLocal().toString()).optional()),
                  ),

                  ///
                  /// updated
                  ///
                  ListTile(
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
