import 'package:flutter/material.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/photo_viewer.dart';
import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patient_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    onUpload() {}

    ///
    /// onImageDiscard
    ///
    onImageDiscard() {
            final repo = ref.read(patientRepositoryProvider);

  repo/
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: ResponsiveBuilder(builder: (context, si) {
                    if (si.isMobile) {
                      return Column(
                        children: [
                          InkWell(
                              onTap: () => PhotoViewer.show(context,
                                  'https://s3.amazonaws.com/files.prod.dpreview.com/sample_galleries/1330372094/1693761761.jpg?X-Amz-Expires=3600&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAUIXIAMA3N436PSEA/20250113/us-east-1/s3/aws4_request&X-Amz-Date=20250113T134714Z&X-Amz-SignedHeaders=host&X-Amz-Signature=f36e23ba70efe10d60f06b5fba8fc4c8a01918b499e73ac2aac60510214a5763'),
                              child: CircleAvatar(radius: 60)),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FilledButton.icon(
                                  onPressed: () {},
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
                            onTap: () => PhotoViewer.show(context,
                                'https://s3.amazonaws.com/files.prod.dpreview.com/sample_galleries/1330372094/1693761761.jpg?X-Amz-Expires=3600&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAUIXIAMA3N436PSEA/20250113/us-east-1/s3/aws4_request&X-Amz-Date=20250113T134714Z&X-Amz-SignedHeaders=host&X-Amz-Signature=f36e23ba70efe10d60f06b5fba8fc4c8a01918b499e73ac2aac60510214a5763'),
                            child: CircleAvatar(radius: 60)),
                        Spacer(),
                        FilledButton.icon(
                            onPressed: () {},
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
                    title: Text(patient.breed ?? '-'),
                  ),

                  ///
                  /// owner
                  ///
                  ListTile(
                    title: Text(patient.owner ?? '-'),
                  ),

                  ///
                  /// address
                  ///
                  ListTile(
                    title: Text(patient.address ?? '-'),
                  ),

                  ///
                  /// date of birth
                  ///
                  ListTile(
                    title:
                        Text(patient.dateOfBirth?.toLocal().toString() ?? '-'),
                  ),

                  ///
                  /// created
                  ///
                  ListTile(
                    title: Text(patient.created?.toLocal().toString() ?? '-'),
                  ),

                  ///
                  /// updated
                  ///
                  ListTile(
                    title: Text(patient.created?.toLocal().toString() ?? '-'),
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
