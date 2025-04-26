import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/utils/pb_utils.dart';
import 'package:gym_system/src/core/utils/validators.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/features/admins/data/admin_repository.dart';
import 'package:gym_system/src/features/admins/domain/admin.dart';
import 'package:gym_system/src/features/admins/presentation/controllers/admin_controller.dart';
import 'package:gym_system/src/features/admins/presentation/controllers/admin_form_controller.dart';
import 'package:gym_system/src/features/admins/presentation/controllers/admin_table_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminFormPage extends HookConsumerWidget {
  const AdminFormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(adminFormControllerProvider(id));
    final showPasswords = useState(false);

    ///
    /// Submit
    ///
    void onSave(
      Admin? admin,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(adminRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (admin == null
          ? repository.create(value, files: files)
          : repository.update(admin, value, files: files));

      final result = await task.run();

      isLoading.value = false;

      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(adminTableControllerProvider);
          ref.invalidate(adminControllerProvider(r.id));

          context.pop();
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Admin Form Page'),
      ),
      body: provider.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
          data: (formState) {
            final admin = formState.admin;
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
              onChange: (data) {
                showPasswords.value = data[AdminField.changePassword] ?? false;
              },
              fields: [
                ///
                /// Image
                ///
                DynamicPBImagesField(
                  name: AdminField.avatar,
                  maxFiles: 1,
                  allowCompression: false,
                  maxSizeKB: 300,
                  compressionQuality: 85,
                  previewSize: 200,
                  fieldTransformer: (list) =>
                      PBUtils.defaultFieldTransformer(list, isSingleFile: true),
                  fileTransformer: PBUtils.defaultFileTransformer,
                  decoration: InputDecoration(border: InputBorder.none),
                  initialValue: images,
                  validator: FormBuilderValidators.compose([]),
                ),

                ///
                /// Admin Name
                ///
                DynamicTextField(
                  name: AdminField.name,
                  initialValue: admin?.name,
                  decoration: InputDecoration(
                    label: Text('Name'),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),

                ///
                /// Email
                ///
                DynamicTextField(
                  name: AdminField.email,
                  initialValue: admin?.email,
                  decoration: InputDecoration(
                    label: Text('Email'),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),

                DynamicHiddenField(
                  name: AdminField.emailVisibility,
                  initialValue: true,
                ),

                ///
                /// Change Password
                ///
                if (admin is Admin)
                  DynamicCheckboxField(
                    name: AdminField.changePassword,
                    title: 'Change Password',
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),

                ///
                /// Password for create
                ///
                if (admin == null) ...[
                  DynamicTextField(
                    name: AdminField.password,
                    decoration: InputDecoration(
                      label: Text('Password'),
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        CustomValidators.matchFieldValidator(
                          AdminField.passwordConfirm,
                          formKey: formKey,
                        ),
                      ],
                    ),
                  ),
                  DynamicTextField(
                    name: AdminField.passwordConfirm,
                    decoration: InputDecoration(
                      label: Text('Confirm Password'),
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        CustomValidators.matchFieldValidator(
                          AdminField.password,
                          formKey: formKey,
                        ),
                      ],
                    ),
                  ),
                ],

                ///
                /// passwords update
                ///
                if (showPasswords.value) ...[
                  DynamicTextField(
                    name: AdminField.oldPassword,
                    decoration: InputDecoration(
                      label: Text('Old Password'),
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        CustomValidators.matchFieldValidator(
                          AdminField.passwordConfirm,
                          formKey: formKey,
                        ),
                      ],
                    ),
                  ),
                  DynamicTextField(
                    name: AdminField.password,
                    decoration: InputDecoration(
                      label: Text('Password'),
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        CustomValidators.matchFieldValidator(
                          AdminField.passwordConfirm,
                          formKey: formKey,
                        ),
                      ],
                    ),
                  ),
                  DynamicTextField(
                    name: AdminField.passwordConfirm,
                    decoration: InputDecoration(
                      label: Text('Confirm Password'),
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        CustomValidators.matchFieldValidator(
                          AdminField.password,
                          formKey: formKey,
                        ),
                      ],
                    ),
                  ),
                ]
              ],
              onSubmit: (result) => onSave(admin, result),
            );
          }),
    );
  }
}
