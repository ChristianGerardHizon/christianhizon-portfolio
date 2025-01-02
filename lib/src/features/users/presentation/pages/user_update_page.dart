import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/form_builders/cutom_image_field.dart';
import 'package:gym_system/src/core/widgets/form_builders/hidden_form_field.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/utils/form_utils.dart';
import 'package:gym_system/src/features/settings/presentation/image_viewer.dart';
import 'package:gym_system/src/features/users/data/user_repository.dart';
import 'package:gym_system/src/features/users/domain/user.dart';
import 'package:gym_system/src/features/users/presentation/controllers/user_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class UserUpdatePage extends HookConsumerWidget {
  const UserUpdatePage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final provider = userControllerProvider(id);

    /// Retrieves the current user from the auth controller

    /// Submits the form and if successful, pops the route with the new [Bid]
    /// otherwise shows a snackbar with the error message.
    void onSubmit() async {
      isLoading.value = true;
      final result = await TaskResult.Do(($) async {
        final form = await $(FormUtils.getFormState(formKey.currentState));
        final values = await $(FormUtils.getFormValues(form));
        final repo = ref.read(userRepositoryProvider);
        final user = await $(repo.get(id));
        return $(repo.update(user, values));
      }).run();

      result.fold(
        (l) {
          AppSnackBar.rootFailure(l);
        },
        (r) {
          context.pop<User>(null);
        },
      );
      isLoading.value = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Update Page'),
      ),
      body: ref.watch(provider).when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Center(child: Text(e.toString())),
            data: (user) => FormBuilder(
              key: formKey,
              initialValue: user.toMap(),
              enabled: isLoading.value == false,
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList.list(children: [
                      ///
                      /// change to hidden
                      ///
                      HiddenFormField(name: UserField.isStoreOwner),

                      ///
                      /// Change Profile Picture
                      ///
                      CustomImageField(
                        feature: 'users',
                        id: id,
                        name: UserField.profilePhoto,
                        stringBuilder: (context, value) {
                          return ImageViewer(
                            builder: (url) => Image.network(
                              url,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            feature: 'users',
                            file: value,
                            id: id,
                          );
                        },
                      ),

                      ///
                      /// name
                      ///
                      FormBuilderTextField(
                        name: UserField.name,
                        decoration: const InputDecoration(
                          label: Text('Name'),
                        ),
                      ),

                      FormBuilderTextField(
                        name: UserField.contactNumber,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          MaskTextInputFormatter(
                            mask: '+63###-###-####',
                            filter: {"#": RegExp(r'[0-9]')},
                          ),
                        ],
                        decoration: const InputDecoration(
                          label: Text('Contact Number'),
                        ),
                      ),

                      ///
                      /// Is a store owner
                      ///
                      // FormBuilderSwitch(
                      //   title: const Text('Is a Store Owner'),
                      //   name: UserField.isStoreOwner,
                      //   decoration: const InputDecoration(
                      //   enabled: ,
                      //     hintText: 'for development purposes only',
                      //   ),
                      // ),

                      ///
                      /// Spacer
                      ///
                      const SizedBox(height: 20),

                      ///
                      /// Submit
                      ///
                      LoadingFilledButton(
                        isLoading: isLoading.value,
                        onPressed: onSubmit,
                        child: const Text('Save'),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ),
    );
  }
}
