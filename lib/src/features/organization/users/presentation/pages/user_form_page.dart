import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/utils/pb_utils.dart';
import 'package:sannjosevet/src/core/utils/validators.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:sannjosevet/src/features/organization/users/data/user_repository.dart';
import 'package:sannjosevet/src/features/organization/users/domain/user.dart';
import 'package:sannjosevet/src/features/organization/users/presentation/controllers/user_controller.dart';
import 'package:sannjosevet/src/features/organization/users/presentation/controllers/user_form_controller.dart';
import 'package:sannjosevet/src/features/organization/users/presentation/controllers/user_table_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserFormPage extends HookConsumerWidget {
  const UserFormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(userFormControllerProvider(id));
    final showPasswords = useState(false);

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
          ref.invalidate(userTableControllerProvider);
          ref.invalidate(userControllerProvider(r.id));

          context.pop(r);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('User Form Page'),
      ),
      body: provider.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
          data: (formState) {
            final user = formState.user;
            final images = formState.images;
            final branches = formState.branches;

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
                showPasswords.value = data[UserField.changePassword] ?? false;
              },
              fields: [
                ///
                /// Avatar
                ///
                DynamicPBFilesField(
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
                    border: InputBorder.none,
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
                    label: Text('Name'),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),

                DynamicTextField(
                  name: UserField.email,
                  initialValue: user?.email,
                  decoration: InputDecoration(
                    label: Text('Email'),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ],
                  ),
                ),

                ///
                /// Branch
                ///
                DynamicSelectField(
                  name: UserField.branch,
                  initialValue:
                      user?.expand.branch?.id ?? branches.firstOrNull?.id,
                  options: branches
                      .map(
                        (e) => SelectOption(
                          value: e.id,
                          display: e.name,
                        ),
                      )
                      .toList(),
                  decoration: InputDecoration(
                    label: Text('Branch'),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),

                DynamicHiddenField(
                  name: UserField.emailVisibility,
                  initialValue: true,
                ),

                ///
                /// Change Password
                ///
                if (user is User)
                  DynamicCheckboxField(
                    name: UserField.changePassword,
                    title: 'Change Password',
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),

                ///
                /// Password for create
                ///
                if (user == null) ...[
                  DynamicTextField(
                    name: UserField.password,
                    decoration: InputDecoration(
                      label: Text('Password'),
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        CustomValidators.matchFieldValidator(
                          UserField.passwordConfirm,
                          formKey: formKey,
                        ),
                      ],
                    ),
                  ),
                  DynamicTextField(
                    name: UserField.passwordConfirm,
                    decoration: InputDecoration(
                      label: Text('Confirm Password'),
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        CustomValidators.matchFieldValidator(
                          UserField.password,
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
                    name: UserField.oldPassword,
                    decoration: InputDecoration(
                      label: Text('Old Password'),
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        CustomValidators.matchFieldValidator(
                          UserField.passwordConfirm,
                          formKey: formKey,
                        ),
                      ],
                    ),
                  ),
                  DynamicTextField(
                    name: UserField.password,
                    decoration: InputDecoration(
                      label: Text('Password'),
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        CustomValidators.matchFieldValidator(
                          UserField.passwordConfirm,
                          formKey: formKey,
                        ),
                      ],
                    ),
                  ),
                  DynamicTextField(
                    name: UserField.passwordConfirm,
                    decoration: InputDecoration(
                      label: Text('Confirm Password'),
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        CustomValidators.matchFieldValidator(
                          UserField.password,
                          formKey: formKey,
                        ),
                      ],
                    ),
                  ),
                ]
              ],
              onSubmit: (result) => onSave(user, result),
            );
          }),
    );
  }
}
