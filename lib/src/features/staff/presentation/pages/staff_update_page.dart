import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/utils/file_picker.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/features/staff/data/staff_repository.dart';
import 'package:gym_system/src/features/staff/domain/staff.dart';
import 'package:gym_system/src/features/staff/presentation/controllers/staff_controller.dart';
import 'package:gym_system/src/features/staff/presentation/controllers/staff_update_controller.dart';
import 'package:gym_system/src/features/staff/presentation/widgets/staff_image_control_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StaffUpdatePage extends HookConsumerWidget {
  final String id;

  const StaffUpdatePage(this.id, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateController = staffUpdateControllerProvider(id);
    final state = ref.watch(updateController);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    final provider = staffControllerProvider(id);

    onRefresh() {
      ref.invalidate(updateController);
      ref.invalidate(provider);
    }

    ///
    /// onUpload
    ///
    onUpload(Staff patient) async {
      final repo = ref.read(staffRepositoryProvider);

      final result = await TaskResult<Staff?>.Do(($) async {
        final images = await $(
          FilePickerUtil.getImage(PatientField.displayImage),
        );
        if (images == null || images.isEmpty) return $(TaskResult.right(null));
        return $(repo.update(patient, {}, files: images));
      }).run();

      result.fold((l) => AppSnackBar.rootFailure(l), (r) {
        if (r == null) return;
        onRefresh();
        AppSnackBar.root(message: 'Successfully Updated');
      });
    }

    ///
    /// onImageDiscard
    ///
    onImageDiscard(Staff patient) async {
      final repo = ref.read(staffRepositoryProvider);

      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;

      final result = await TaskResult<Staff?>.Do(($) async {
        return $(repo.update(patient, {PatientField.displayImage: null}));
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

    void onSubmit(Staff staff) async {
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
          .read(staffRepositoryProvider)
          .update(staff, form.value)
          .run();

      if (!context.mounted) return;
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: "Success");
          PatientPageRoute(id).go(context);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => PatientPageRoute(id).go(context),
        ),
        title: Text('Patient Update Page'),
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
          final staff = updateState.staff;
          // final settings = updateState.settings;
          final map = staff.toForm();
          return FormBuilder(
            key: formKey,
            initialValue: map,
            child: CustomScrollView(
              slivers: [
                ///
                /// image
                ///
                SliverToBoxAdapter(
                  child: StaffImageControlWidget(
                    staff: staff,
                    onUpload: () => onUpload(staff),
                    onImageDiscard: () => onImageDiscard(staff),
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
                          'Owner Details',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
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

                      SizedBox(height: 20),
                    ])),

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
                        onPressed: () => onSubmit(staff),
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
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
