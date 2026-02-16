import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../../core/hooks/use_form_dirty_guard.dart';
import '../../../../core/widgets/cached_avatar.dart';
import '../../../../core/widgets/dialog/dialog_constraints.dart';
import '../../../../core/widgets/dialog_close_handler.dart';
import '../../../../core/widgets/form/form_dialog_scaffold.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../../../core/widgets/step_indicator.dart';
import '../../../memberships/data/repositories/member_membership_add_on_repository.dart';
import '../../../memberships/data/repositories/member_membership_repository.dart';
import '../../../memberships/domain/membership.dart';
import '../../../memberships/domain/membership_add_on.dart';
import '../../../memberships/presentation/widgets/membership_purchase_content.dart';
import '../../../settings/presentation/controllers/current_branch_controller.dart';
import '../../domain/member.dart';
import '../controllers/members_controller.dart';
import '../controllers/paginated_members_controller.dart';

/// Shows a dialog form for creating or editing a member.
///
/// - **Create mode** (`member == null`): 3-step wizard
///   (Details → Photo → Membership). All data saved at the end.
/// - **Edit mode** (`member != null`): Single-step form (unchanged).
///
/// Returns `true` if the member was saved successfully.
Future<bool?> showMemberFormDialog(
  BuildContext context, {
  Member? member,
}) {
  return showConstrainedDialog<bool>(
    context: context,
    fullScreen: true,
    builder: (context) => MemberFormDialog(member: member),
  );
}

class MemberFormDialog extends HookConsumerWidget {
  const MemberFormDialog({super.key, this.member});

  final Member? member;

  bool get isEditing => member != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isEditing) {
      return _MemberEditForm(member: member!);
    }
    return const _MemberCreateWizard();
  }
}

// =============================================================================
// Edit Form (single-step, unchanged behavior)
// =============================================================================

class _MemberEditForm extends HookConsumerWidget {
  const _MemberEditForm({required this.member});

  final Member member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);

    final initialValues = <String, dynamic>{
      'name': member.name,
      'mobileNumber': member.mobileNumber,
      'email': member.email,
      'dateOfBirth': member.dateOfBirth,
      'sex': member.sex,
      'address': member.address,
      'emergencyContact': member.emergencyContact,
      'remarks': member.remarks,
    };

    final dirtyGuard = useFormDirtyGuard(
      formKey: formKey,
      initialValues: initialValues,
    );

    Future<void> handleSave() async {
      if (!formKey.currentState!.saveAndValidate()) return;

      isSaving.value = true;
      final values = formKey.currentState!.value;

      final memberData = Member(
        id: member.id,
        name: values['name'] as String,
        mobileNumber: values['mobileNumber'] as String?,
        email: values['email'] as String?,
        dateOfBirth: values['dateOfBirth'] as DateTime?,
        sex: values['sex'] as MemberSex?,
        address: values['address'] as String?,
        emergencyContact: values['emergencyContact'] as String?,
        remarks: values['remarks'] as String?,
        rfidCardId: member.rfidCardId,
        addedBy: member.addedBy,
      );

      final success = await ref
          .read(membersControllerProvider.notifier)
          .updateMember(memberData);

      ref.read(paginatedMembersControllerProvider.notifier).refresh();

      isSaving.value = false;

      if (success && context.mounted) {
        showSuccessSnackBar(
          context,
          message: 'Member updated',
          useRootMessenger: false,
        );
        Navigator.of(context).pop(true);
      } else if (context.mounted) {
        showErrorSnackBar(
          context,
          message: 'Failed to update member',
          useRootMessenger: false,
        );
      }
    }

    return ScaffoldMessenger(
      child: Builder(
        builder: (context) => FormDialogScaffold(
          title: 'Edit Member',
          formKey: formKey,
          dirtyGuard: dirtyGuard,
          isSaving: isSaving.value,
          onSave: handleSave,
          fullScreen: true,
          child: _MemberFormFields(member: member),
        ),
      ),
    );
  }
}

// =============================================================================
// Create Wizard (3 steps)
// =============================================================================

class _MemberCreateWizard extends HookConsumerWidget {
  const _MemberCreateWizard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentStep = useState(0);
    final isSaving = useState(false);

    // Step 1: Form state
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final dirtyGuard = useFormDirtyGuard(formKey: formKey);

    // Step 2: Photo state
    final selectedPhoto = useState<XFile?>(null);
    final photoBytes = useState<Uint8List?>(null);

    // Step 3: Membership state
    final selectedMembership = useState<Membership?>(null);
    final selectedAddOns = useState<Set<MembershipAddOn>>({});

    Future<void> handleFinish() async {
      // Validate form from step 1
      if (!formKey.currentState!.saveAndValidate()) {
        currentStep.value = 0;
        return;
      }

      isSaving.value = true;
      final values = formKey.currentState!.value;

      final memberData = Member(
        id: '',
        name: values['name'] as String,
        mobileNumber: values['mobileNumber'] as String?,
        email: values['email'] as String?,
        dateOfBirth: values['dateOfBirth'] as DateTime?,
        sex: values['sex'] as MemberSex?,
        address: values['address'] as String?,
        emergencyContact: values['emergencyContact'] as String?,
        remarks: values['remarks'] as String?,
      );

      // 1. Create member (with photo if selected)
      http.MultipartFile? photoFile;
      if (photoBytes.value != null && selectedPhoto.value != null) {
        photoFile = http.MultipartFile.fromBytes(
          'photo',
          photoBytes.value!,
          filename: selectedPhoto.value!.name,
        );
      }

      final created = await ref
          .read(membersControllerProvider.notifier)
          .createMemberWithPhoto(memberData, photo: photoFile);

      if (created == null) {
        isSaving.value = false;
        if (context.mounted) {
          showErrorSnackBar(
            context,
            message: 'Failed to create member',
            useRootMessenger: false,
          );
        }
        return;
      }

      // 2. Purchase membership if selected
      if (selectedMembership.value != null) {
        final plan = selectedMembership.value!;
        final branchId = ref.read(currentBranchIdProvider) ?? '';
        final startDate = DateTime.now();
        final endDate = startDate.add(Duration(days: plan.durationDays));

        final membershipRepo =
            ref.read(memberMembershipRepositoryProvider);
        final result = await membershipRepo.create(
          memberId: created.id,
          membershipId: plan.id,
          startDate: startDate,
          endDate: endDate,
          branchId: branchId,
        );

        result.fold(
          (failure) {
            // Member created but membership failed — still a partial success
            if (context.mounted) {
              showErrorSnackBar(
                context,
                message:
                    'Member created but failed to purchase membership',
                useRootMessenger: false,
              );
            }
          },
          (createdMembership) async {
            // Create add-on records
            if (selectedAddOns.value.isNotEmpty) {
              final addOnRepo =
                  ref.read(memberMembershipAddOnRepositoryProvider);
              for (final addOn in selectedAddOns.value) {
                await addOnRepo.create(
                  memberMembershipId: createdMembership.id,
                  membershipAddOnId: addOn.id,
                  addOnName: addOn.name,
                  price: addOn.price,
                );
              }
            }
          },
        );
      }

      // 3. Refresh and close
      ref.read(paginatedMembersControllerProvider.notifier).refresh();

      isSaving.value = false;

      if (context.mounted) {
        showSuccessSnackBar(
          context,
          message: 'Member created',
          useRootMessenger: false,
        );
        Navigator.of(context).pop(true);
      }
    }

    return ScaffoldMessenger(
      child: Builder(
        builder: (context) => DialogCloseHandler(
          onClose: (ctx) async {
            if (currentStep.value == 0) {
              return dirtyGuard.confirmDiscard(ctx);
            }
            // On steps 1-2, check if user has made selections
            if (selectedPhoto.value != null ||
                selectedMembership.value != null) {
              return await showDialog<bool>(
                    context: ctx,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Discard changes?'),
                      content: const Text(
                        'You have unsaved changes. Are you sure you want to discard them?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(false),
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.of(ctx).pop(true),
                          child: const Text('Discard'),
                        ),
                      ],
                    ),
                  ) ??
                  false;
            }
            return true;
          },
          child: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) async {
              if (didPop) return;
              if (currentStep.value == 0) {
                dirtyGuard.onPopInvokedWithResult(didPop, result);
              } else {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            },
            child: ConstrainedDialogContent(
              fullScreen: true,
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: isSaving.value
                              ? null
                              : () async {
                                  if (currentStep.value == 0) {
                                    if (await dirtyGuard
                                        .confirmDiscard(context)) {
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    }
                                  } else {
                                    Navigator.of(context).pop();
                                  }
                                },
                        ),
                        Expanded(
                          child: Text(
                            'New Member',
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Step indicator
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: StepIndicator(
                      currentStep: currentStep.value,
                      steps: const ['Details', 'Photo', 'Membership'],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Step content
                  Expanded(
                    child: IndexedStack(
                      index: currentStep.value,
                      children: [
                        // Step 0: Member Details
                        _MemberDetailsStep(
                          formKey: formKey,
                          onNext: () => currentStep.value = 1,
                        ),

                        // Step 1: Photo
                        _PhotoStep(
                          selectedPhoto: selectedPhoto,
                          photoBytes: photoBytes,
                          onNext: () => currentStep.value = 2,
                          onBack: () => currentStep.value = 0,
                        ),

                        // Step 2: Membership
                        _MembershipStep(
                          selectedMembership: selectedMembership,
                          selectedAddOns: selectedAddOns,
                          isSaving: isSaving.value,
                          onSave: handleFinish,
                          onSkip: handleFinish,
                          onBack: () => currentStep.value = 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Step 0: Member Details
// =============================================================================

class _MemberDetailsStep extends StatelessWidget {
  const _MemberDetailsStep({
    required this.formKey,
    required this.onNext,
  });

  final GlobalKey<FormBuilderState> formKey;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FormBuilder(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  const _MemberFormFields(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
        // Next button
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                if (formKey.currentState!.saveAndValidate()) {
                  onNext();
                }
              },
              child: const Text('Next'),
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Step 1: Photo
// =============================================================================

class _PhotoStep extends HookWidget {
  const _PhotoStep({
    required this.selectedPhoto,
    required this.photoBytes,
    required this.onNext,
    required this.onBack,
  });

  final ValueNotifier<XFile?> selectedPhoto;
  final ValueNotifier<Uint8List?> photoBytes;
  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 32),
                // Photo preview
                if (photoBytes.value != null)
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(photoBytes.value!),
                  )
                else
                  const CachedAvatar(radius: 64),
                const SizedBox(height: 24),
                Text(
                  'Add a Photo',
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'This step is optional. You can always add a photo later.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                FilledButton.tonalIcon(
                  onPressed: () => _pickImage(),
                  icon: const Icon(Icons.camera_alt),
                  label: Text(
                    selectedPhoto.value != null
                        ? 'Change Photo'
                        : 'Choose Photo',
                  ),
                ),
              ],
            ),
          ),
        ),
        // Bottom nav
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              OutlinedButton(
                onPressed: onBack,
                child: const Text('Back'),
              ),
              const Spacer(),
              if (selectedPhoto.value == null)
                TextButton(
                  onPressed: onNext,
                  child: const Text('Skip'),
                )
              else
                FilledButton(
                  onPressed: onNext,
                  child: const Text('Next'),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );
    if (image != null) {
      selectedPhoto.value = image;
      photoBytes.value = await image.readAsBytes();
    }
  }
}

// =============================================================================
// Step 2: Membership
// =============================================================================

class _MembershipStep extends StatelessWidget {
  const _MembershipStep({
    required this.selectedMembership,
    required this.selectedAddOns,
    required this.isSaving,
    required this.onSave,
    required this.onSkip,
    required this.onBack,
  });

  final ValueNotifier<Membership?> selectedMembership;
  final ValueNotifier<Set<MembershipAddOn>> selectedAddOns;
  final bool isSaving;
  final VoidCallback onSave;
  final VoidCallback onSkip;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MembershipPurchaseContent(
            memberId: '',
            memberName: '',
            collectOnly: true,
            selectedMembership: selectedMembership,
            selectedAddOns: selectedAddOns,
          ),
        ),
        // Bottom nav
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              OutlinedButton(
                onPressed: isSaving ? null : onBack,
                child: const Text('Back'),
              ),
              const Spacer(),
              if (selectedMembership.value == null)
                FilledButton(
                  onPressed: isSaving ? null : onSkip,
                  child: isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Save'),
                )
              else
                FilledButton(
                  onPressed: isSaving ? null : onSave,
                  child: isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Save'),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Shared Form Fields
// =============================================================================

class _MemberFormFields extends StatelessWidget {
  const _MemberFormFields({this.member});

  final Member? member;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormBuilderTextField(
          name: 'name',
          initialValue: member?.name,
          decoration: const InputDecoration(labelText: 'Name *'),
          validator: FormBuilderValidators.required(),
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 16),
        FormBuilderTextField(
          name: 'mobileNumber',
          initialValue: member?.mobileNumber,
          decoration: const InputDecoration(labelText: 'Mobile Number'),
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        FormBuilderTextField(
          name: 'email',
          initialValue: member?.email,
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        FormBuilderDateTimePicker(
          name: 'dateOfBirth',
          initialValue: member?.dateOfBirth,
          decoration: const InputDecoration(labelText: 'Date of Birth'),
          inputType: InputType.date,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        ),
        const SizedBox(height: 16),
        FormBuilderDropdown<MemberSex>(
          name: 'sex',
          initialValue: member?.sex,
          decoration: const InputDecoration(labelText: 'Sex'),
          items: MemberSex.values
              .map((s) => DropdownMenuItem(
                    value: s,
                    child: Text(s.displayName),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
        FormBuilderTextField(
          name: 'address',
          initialValue: member?.address,
          decoration: const InputDecoration(labelText: 'Address'),
          maxLines: 2,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.sentences,
        ),
        const SizedBox(height: 16),
        FormBuilderTextField(
          name: 'emergencyContact',
          initialValue: member?.emergencyContact,
          decoration:
              const InputDecoration(labelText: 'Emergency Contact'),
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 16),
        FormBuilderTextField(
          name: 'remarks',
          initialValue: member?.remarks,
          decoration: const InputDecoration(labelText: 'Remarks'),
          maxLines: 3,
          textCapitalization: TextCapitalization.sentences,
        ),
      ],
    );
  }
}
