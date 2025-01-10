import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/form_builders/images_form_field.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/features/pets/data/pet_repository.dart';
import 'package:gym_system/src/features/pets/domain/pet.dart';
import 'package:gym_system/src/features/pets/presentation/controllers/pet_update_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PetUpdatePage extends HookConsumerWidget {
  const PetUpdatePage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(petUpdateControllerProvider(id));
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    void onSubmit(Pet pet) async {
      isLoading.value = true;
      final result = await ref
          .read(petRepositoryProvider)
          .update(pet, formKey.currentState!.value)
          .run();
      if (!context.mounted) return;
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: "Success");
          PetPageRoute(id).go(context);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => PetPageRoute(id).go(context),
        ),
        title: Text('Pet Update Page'),
      ),
      body: state.when(
        data: (updateState) {
          final pet = updateState.pet;
          final settings = updateState.settings;
          return FormBuilder(
            key: formKey,
            initialValue: pet.toMap(),
            child: Column(
              children: [
                ///
                /// name
                ///
                FormBuilderTextField(name: PetField.name),

                SizedBox(height: 10),

                ImagesFormField(
                  domain:
                      '${settings.domain}/api/files/${PocketBaseCollections.pets}/$id',
                  name: PetField.images,
                ),

                SizedBox(height: 10),

                ///
                /// save button
                ///
                LoadingFilledButton(
                  isLoading: isLoading.value,
                  child: Text('Save'),
                  onPressed: () => onSubmit(pet),
                ),
              ],
            ),
          );
        },
        error: (error, stack) {
          return Text(error.toString());
        },
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
