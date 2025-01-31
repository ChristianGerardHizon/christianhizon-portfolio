import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/form_builders/form_hidden_fields.dart';
import 'package:gym_system/src/core/widgets/form_builders/hidden_form_field.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/features/users/data/user_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserCreatePage extends HookConsumerWidget {
  const UserCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    ///
    /// Submit
    ///
    void onSubmit() async {
      isLoading.value = true;
      final form = formKey.currentState;
      if (form == null) {
        isLoading.value = false;
        return;
      }
      final isValid = form.saveAndValidate();
      if (!isValid) {
        isLoading.value = false;
        return;
      }

      final result =
          await ref.read(userRepositoryProvider).create(form.value).run();
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          UsersPageRoute().go(context);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(
          onPressed: () => PatientsPageRoute().go(context),
        ),
        title: Text('User Create Page'),
      ),
      body: FormBuilder(
        key: formKey,
        initialValue: {
          UserField.verified: false,
          UserField.emailVisibility: true,
        },
        child: CustomScrollView(
          slivers: [
            ///
            /// Patient Details
            ///
            SliverPadding(
              padding: EdgeInsets.only(left: 10, right: 10),
              sliver: SliverList.list(
                children: [
                  SizedBox(height: 10),

                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'User Info',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

                  SizedBox(height: 10),

                  FormHiddenFields(
                    ids: [
                      UserField.verified,
                      UserField.emailVisibility,
                    ],
                  ),

                  ///
                  /// Email
                  ///
                  FormBuilderTextField(
                    name: UserField.email,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          bottom: 10, right: 8, left: 8, top: 30),
                      labelText: 'Email',
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.surfaceContainerLow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  ///
                  /// Name
                  ///
                  FormBuilderTextField(
                    name: UserField.name,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          bottom: 10, right: 8, left: 8, top: 30),
                      labelText: 'Name',
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.surfaceContainerLow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  ///
                  /// Password
                  ///
                  FormBuilderTextField(
                    name: UserField.password,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          bottom: 10, right: 8, left: 8, top: 30),
                      labelText: 'Password',
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.surfaceContainerLow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  ///
                  /// RePassword
                  ///
                  FormBuilderTextField(
                    name: UserField.passwordConfirm,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          bottom: 10, right: 8, left: 8, top: 30),
                      labelText: 'Password Confirm',
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.surfaceContainerLow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                ],
              ),
            ),

            ///
            /// Save Button
            ///
            SliverPadding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 30, bottom: 20),
              sliver: SliverToBoxAdapter(
                child: LoadingFilledButton(
                  isLoading: isLoading.value,
                  child: Text('Save'),
                  onPressed: onSubmit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
