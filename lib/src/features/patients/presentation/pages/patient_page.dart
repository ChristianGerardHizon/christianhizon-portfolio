import 'package:flutter/material.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patient_controller.dart';
import 'package:gym_system/src/features/settings/presentation/controllers/settings_controller.dart';
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
            icon: const Icon(Icons.update),
            onPressed: () => PatientUpdatePageRoute(id).go(context),
          ),
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
              /// row of images scrolling horizontally
              ///
              ref.watch(settingsControllerProvider).when(
                    skipError: false,
                    skipLoadingOnRefresh: false,
                    skipLoadingOnReload: false,
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) =>
                        Center(child: Text(error.toString())),
                    data: (settings) {
                      return Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: patient.images.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                ///
                                /// image
                                ///
                                Padding(
                                  padding: EdgeInsets.only(right: 15, top: 15),
                                  child: InkWell(
                                    onTap: () => print('test'),
                                    child: Image.network(
                                        '${settings.domain}/api/files/${PocketBaseCollections.patients}/$id/${patient.images[index]}'),
                                  ),
                                ),

                                ///
                                /// delete
                                ///
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 2),
                                          blurRadius: 4,
                                          color: Colors.black12,
                                        ),
                                      ],
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
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
