import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/utils/file_picker.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/center_progress_indicator.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/features/admins/domain/admin.dart';
import 'package:gym_system/src/features/admins/data/admin_repository.dart';
import 'package:gym_system/src/features/admins/domain/admin.dart';
import 'package:gym_system/src/features/admins/presentation/controllers/admin_controller.dart';
import 'package:gym_system/src/features/admins/presentation/controllers/admin_update_controller.dart';
import 'package:gym_system/src/features/admins/presentation/widgets/admin_image_control_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminUpdatePage extends HookConsumerWidget {
  final String id;

  const AdminUpdatePage(this.id, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateController = adminUpdateControllerProvider(id);
    final state = ref.watch(updateController);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final changePassword = useState(false);

    final provider = adminControllerProvider(id);

    onRefresh() {
      ref.invalidate(updateController);
      ref.invalidate(provider);
    }

    ///
    /// onUpload
    ///
    onUpload(Admin patient) async {
      final repo = ref.read(adminRepositoryProvider);

      final result = await TaskResult<Admin?>.Do(($) async {
        final images = await $(
          FilePickerUtil.getImage(AdminField.avatar),
        );
        if (images == null || images.isEmpty) return $(TaskResult.right(null));
        return $(repo.update(patient, {}, files: images));
      }).run();

      result.fold((l) => AppSnackBar.rootFailure(l), (r) {
        if (r == null) return;
        onRefresh();
        AppSnackBar.root(message: 'Successfully Updated');
        if (context.canPop()) context.pop();
      });
    }

    ///
    /// onImageDiscard
    ///
    onImageDiscard(Admin admin) async {
      final repo = ref.read(adminRepositoryProvider);

      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;

      final result = await TaskResult<Admin?>.Do(($) async {
        return $(repo.update(admin, {AdminField.avatar: null}));
      }).run();

      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          if (r == null) return;
          onRefresh();
          AppSnackBar.root(message: 'Successfully Delete Image');
        },
      );
    }

    void onSubmit(Admin admin) async {
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

      final result = await ref
          .read(adminRepositoryProvider)
          .update(admin, form.value)
          .run();

      if (!context.mounted) return;
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: "Success");
          if (context.canPop()) context.pop();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Update'),
        actions: [
          IconButton(
            onPressed: onRefresh,
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: state.when(
        skipError: false,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        data: (updateState) {
          final admin = updateState.admin;
          // final settings = updateState.settings;
          final map = admin.toForm();
          return FormBuilder(
            key: formKey,
            initialValue: map,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 20)),

                ///
                /// image
                ///
                SliverToBoxAdapter(
                  child: AdminImageControlWidget(
                    admin: admin,
                    onUpload: () => onUpload(admin),
                    onImageDiscard: () => onImageDiscard(admin),
                  ),
                ),

                ///
                /// Personal Info
                ///
                SliverPadding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 35),
                    sliver: SliverList.list(children: [
                      ///
                      /// Header
                      ///
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text(
                          'Details',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),

                      SizedBox(height: 8),

                      ///
                      /// Email
                      ///
                      FormBuilderTextField(
                        name: AdminField.email,
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

                      SizedBox(height: 20),

                      ///
                      /// Name
                      ///
                      FormBuilderTextField(
                        name: AdminField.name,
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

                      SizedBox(height: 20),

                      ///
                      /// Change password toggle
                      ///
                      Row(
                        children: [
                          Checkbox(
                            value: changePassword.value,
                            onChanged: (v) {
                              changePassword.value = v ?? false;
                            },
                          ),
                          Text('Change Password'),
                        ],
                      ),
                    ])),

                if (changePassword.value == true)
                  SliverPadding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    sliver: SliverList.list(
                      children: [
                        SizedBox(height: 20),
                        FormBuilderTextField(
                          name: AdminField.oldPassword,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                bottom: 10, right: 8, left: 8, top: 30),
                            labelText: 'Current Password',
                            filled: true,
                            fillColor: Theme.of(context)
                                .colorScheme
                                .surfaceContainerLow,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        FormBuilderTextField(
                          name: AdminField.password,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                bottom: 10, right: 8, left: 8, top: 30),
                            labelText: 'New Password',
                            filled: true,
                            fillColor: Theme.of(context)
                                .colorScheme
                                .surfaceContainerLow,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        FormBuilderTextField(
                          name: AdminField.passwordConfirm,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                bottom: 10, right: 8, left: 8, top: 30),
                            labelText: 'Confirm New Password',
                            filled: true,
                            fillColor: Theme.of(context)
                                .colorScheme
                                .surfaceContainerLow,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),

                ///
                /// Save button
                ///
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: LoadingFilledButton(
                        isLoading: isLoading.value,
                        child: Text('Save'),
                        onPressed: () => onSubmit(admin),
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 20))
              ],
            ),
          );
        },
        error: (error, stack) {
          return Text(error.toString());
        },
        loading: () => CenteredProgressIndicator(),
      ),
    );
  }
}
