import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/features/history/data/history/history_repository.dart';
import 'package:gym_system/src/features/history/data/history_type/history_type_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HistoryTypeCreateSheet extends HookConsumerWidget {
  final Map<String, dynamic>? formData;

  const HistoryTypeCreateSheet({super.key, this.formData});

  static Future show(
    BuildContext context, {
    Map<String, dynamic>? formData,
  }) async {
    final screenSize = MediaQuery.of(context).size;

    return showDialog(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      builder: (_) => HistoryTypeCreateSheet(formData: formData),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final isFullScreen = useState(false);

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

      final result = await ref
          .read(historyTypeRepositoryProvider)
          .create(form.value)
          .run();
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          context.pop(r);
        },
      );
    }

    final content = Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        title: Text('New History Type'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FormBuilder(
          key: formKey,
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

                    ///
                    /// Icon
                    ///
                    FormBuilderDropdown(
                      name: HistoryTypeField.icon,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            bottom: 10, right: 8, left: 8, top: 30),
                        labelText: 'Icon',
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: [
                        'star',
                        'heart',
                        'smile',
                        'sad',
                        'mood',
                      ]
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                    ),
                    SizedBox(height: 10),

                    ///
                    /// Type Name
                    ///
                    FormBuilderTextField(
                      name: HistoryTypeField.name,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            bottom: 10, right: 8, left: 8, top: 30),
                        labelText: 'History Name',
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
      ),
    );

    if (isFullScreen.value) {
      return Dialog.fullscreen(
        child: content,
      );
    }

    return Dialog(
      child: content,
    );
  }
}
