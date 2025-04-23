import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/utils/pb_utils.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/features/users/data/user_repository.dart';
import 'package:gym_system/src/features/users/domain/user.dart';
import 'package:gym_system/src/features/users/presentation/controllers/user_controller.dart';
import 'package:gym_system/src/features/users/presentation/controllers/user_form_controller.dart';
import 'package:gym_system/src/features/users/presentation/controllers/users_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserFormPage extends HookConsumerWidget {
  const UserFormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(userFormControllerProvider(id));

    ///
    /// Submit
    ///
    void onSave(
      User? user,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(userRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (user == null
          ? repository.create(value, files: files)
          : repository.update(user, value, files: files));

      final result = await task.run();

      isLoading.value = false;

      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(usersControllerProvider);
          ref.invalidate(userControllerProvider(r.id));

          context.pop();
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('User Form Page'),
      ),
      body: provider.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
          data: (formState) {
            final user = formState.user;
            final images = formState.images;

            return DynamicFormBuilder(
              itemPadding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 0,
              ),
              formKey: formKey,
              isLoading: isLoading.value,
              fields: [
                ///
                /// Avatar
                ///
                DynamicPBImagesField(
                  name: UserField.avatar,
                  maxFiles: 1,
                  allowCompression: false,
                  maxSizeKB: 300,
                  compressionQuality: 85,
                  previewSize: 200,
                  fieldTransformer: (list) =>
                      PBUtils.defaultFieldTransformer(list, isSingleFile: true),
                  fileTransformer: PBUtils.defaultFileTransformer,
                  decoration: InputDecoration(
                    label: Text('Image'),
                    border: OutlineInputBorder(),
                  ),
                  initialValue: images,
                  validator: FormBuilderValidators.compose([]),
                ),

                ///
                /// User Name
                ///
                DynamicTextField(
                  name: UserField.name,
                  initialValue: user?.name,
                  decoration: InputDecoration(
                    label: Text('User Name'),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),
              ],
              onSubmit: (result) => onSave(user, result),
            );
          }),
    );
  }
}
