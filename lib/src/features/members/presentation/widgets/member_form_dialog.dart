import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/hooks/use_form_dirty_guard.dart';
import '../../../../core/widgets/dialog/dialog_constraints.dart';
import '../../../../core/widgets/form/form_dialog_scaffold.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../domain/member.dart';
import '../controllers/members_controller.dart';

/// Shows a dialog form for creating or editing a member.
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
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSaving = useState(false);

    final initialValues = isEditing
        ? <String, dynamic>{
            'name': member!.name,
            'mobileNumber': member!.mobileNumber,
            'email': member!.email,
            'dateOfBirth': member!.dateOfBirth,
            'sex': member!.sex,
            'address': member!.address,
            'emergencyContact': member!.emergencyContact,
            'remarks': member!.remarks,
          }
        : null;

    final dirtyGuard = useFormDirtyGuard(
      formKey: formKey,
      initialValues: initialValues,
    );

    Future<void> handleSave() async {
      if (!formKey.currentState!.saveAndValidate()) return;

      isSaving.value = true;
      final values = formKey.currentState!.value;

      final memberData = Member(
        id: member?.id ?? '',
        name: values['name'] as String,
        mobileNumber: values['mobileNumber'] as String?,
        email: values['email'] as String?,
        dateOfBirth: values['dateOfBirth'] as DateTime?,
        sex: values['sex'] as MemberSex?,
        address: values['address'] as String?,
        emergencyContact: values['emergencyContact'] as String?,
        remarks: values['remarks'] as String?,
        rfidCardId: member?.rfidCardId,
        addedBy: member?.addedBy,
      );

      final controller = ref.read(membersControllerProvider.notifier);

      bool success;
      if (isEditing) {
        success = await controller.updateMember(memberData);
      } else {
        final created = await controller.createMember(memberData);
        success = created != null;
      }

      isSaving.value = false;

      if (success && context.mounted) {
        showSuccessSnackBar(
          context,
          message: isEditing ? 'Member updated' : 'Member created',
          useRootMessenger: false,
        );
        Navigator.of(context).pop(true);
      } else if (context.mounted) {
        showErrorSnackBar(
          context,
          message: isEditing
              ? 'Failed to update member'
              : 'Failed to create member',
          useRootMessenger: false,
        );
      }
    }

    return ScaffoldMessenger(
      child: Builder(
        builder: (context) => FormDialogScaffold(
          title: isEditing ? 'Edit Member' : 'New Member',
          formKey: formKey,
          dirtyGuard: dirtyGuard,
          isSaving: isSaving.value,
          onSave: handleSave,
          fullScreen: true,
          child: Column(
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
                decoration:
                    const InputDecoration(labelText: 'Mobile Number'),
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
                decoration:
                    const InputDecoration(labelText: 'Date of Birth'),
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
          ),
        ),
      ),
    );
  }
}
