import 'package:flutter/material.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/photo_viewer.dart';
import 'package:gym_system/src/features/pets/data/pet_repository.dart';
import 'package:gym_system/src/features/pets/presentation/controllers/pet_controller.dart';
import 'package:gym_system/src/features/pets/presentation/controllers/pets_controller.dart';
import 'package:gym_system/src/features/pets/presentation/controllers/pets_page_controller.dart';
import 'package:gym_system/src/features/settings/presentation/controllers/settings_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PetPage extends HookConsumerWidget {
  const PetPage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = petControllerProvider(id);
    final state = ref.watch(provider);

    onDelete() async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(petRepositoryProvider);
      repo.delete(id).run().then((result) {
        result.fold(
          (l) => AppSnackBar.rootFailure(l),
          (r) {
            ref.invalidate(petsControllerProvider);
            AppSnackBar.root(message: 'Successfully Deleted');
            PetsPageRoute().go(context);
          },
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => PetsPageRoute().go(context),
        ),
        title: Text('Pet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.update),
            onPressed: () => PetUpdatePageRoute(id).go(context),
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
      body: state.when(
        skipError: false,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (pet) {
          return ListView(
            children: [
              ///
              /// name
              ///
              ListTile(
                title: Text(pet.name),
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
                          itemCount: pet.images.length,
                          itemBuilder: (context, index) {
                            final imageUrl =
                                '${settings.domain}/api/files/${PocketBaseCollections.pets}/$id/${pet.images[index]}';
                            return Stack(
                              children: [
                                ///
                                /// image
                                ///
                                Padding(
                                  padding: EdgeInsets.only(right: 15, top: 15),
                                  child: InkWell(
                                    onTap: () =>
                                        PhotoViewer.show(context, imageUrl),
                                    child: Image.network(imageUrl),
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
              /// breed
              ///
              ListTile(
                title: Text(pet.breed ?? '-'),
              ),

              ///
              /// owner
              ///
              ListTile(
                title: Text(pet.owner ?? '-'),
              ),

              ///
              /// address
              ///
              ListTile(
                title: Text(pet.address ?? '-'),
              ),

              ///
              /// date of birth
              ///
              ListTile(
                title: Text(pet.dateOfBirth?.toLocal().toString() ?? '-'),
              ),

              ///
              /// created
              ///
              ListTile(
                title: Text(pet.created?.toLocal().toString() ?? '-'),
              ),

              ///
              /// updated
              ///
              ListTile(
                title: Text(pet.created?.toLocal().toString() ?? '-'),
              ),
            ],
          );
        },
      ),
    );
  }
}
