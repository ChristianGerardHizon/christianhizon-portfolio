import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:gym_system/src/core/widgets/stack_loader.dart';
import 'package:gym_system/src/features/patient_prescription_items/data/patient_prescription_item_repository.dart';
import 'package:gym_system/src/features/patient_prescription_items/domain/patient_prescription_item.dart';
import 'package:gym_system/src/features/patient_prescription_items/presentation/controllers/patient_prescription_item_group_controller.dart';
import 'package:gym_system/src/features/patient_records/domain/patient_record.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientPrescriptionItemsGroup extends HookConsumerWidget {
  const PatientPrescriptionItemsGroup({super.key, required this.record});

  final PatientRecord record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    /// loading variable
    ///
    final isLoading = useState(false);

    ///
    /// repo
    ///
    final repo = ref.read(patientPrescriptionItemRepositoryProvider);

    ///
    ///
    ///
    final state =
        ref.watch(patientPrescriptionItemGroupControllerProvider(record.id));

    ///
    ///
    ///
    final list = state.valueOrNull ?? [];

    ///
    ///
    ///
    addItem(PatientRecord record) {
      PatientPrescriptionItemFormPageRoute(parentId: record.id).push(context);
    }

    ///
    ///
    ///
    onUpdate(PatientPrescriptionItem record) {
      PatientPrescriptionItemFormPageRoute(
              parentId: record.patientRecord, id: record.id)
          .push(context);
    }

    ///
    /// refresh
    ///
    refresh(String id) {
      ref.invalidate(patientPrescriptionItemGroupControllerProvider(id));
    }

    ///
    /// onDelete
    ///
    onDelete(PatientRecord patientRecord) async {
      final fullTask = await
          // 1. Call Confirm Modal
          ConfirmModal.taskResult(context)
              // 2. Delete Network Call
              .flatMap((_) => repo.softDeleteMulti([patientRecord.id]))
              // 3. Side effects
              .flatMap(
                (_) => _handleSuccessfulDeleteTaskSidEffects(
                  context: context,
                  patientRecordId: patientRecord.id,
                  refresh: refresh,
                ),
              );

      isLoading.value = true;
      final result = await fullTask.run();
      isLoading.value = false;

      // 4. Handle Error
      result.match(
        (failure) => _handleFailure(context, failure),
        (_) {},
      );
    }

    Widget buildItem(PatientPrescriptionItem e) {
      return ListTile(
        isThreeLine: true,
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: e.medication.optional()),
              TextSpan(text: ' '),
              TextSpan(
                text: e.dosage
                    .enclose('(', close: ')', skipIfEmpty: true)
                    .optional(),
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
        subtitle: Text(e.instructions.optional()),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton.icon(
              label: Text('Edit'),
              icon: Icon(MIcons.pencilOutline),
              onPressed: () => onUpdate(e),
            ),
            TextButton.icon(
              label: Text('Delete'),
              icon: Icon(MIcons.trashCanOutline),
              onPressed: () => onDelete(record),
            )
          ],
        ),
      );
    }

    final widgets = list
        .map((item) => DynamicGroupItem.field(
              title: item.date.toLocal().fullDateTime,
              value: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => buildItem(item.items[index]),
                itemCount: item.items.length,
              ),
            ))
        .toList();

    return StackLoader(
      isLoading: isLoading.value,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widgets.isNotEmpty)
              DynamicGroup(
                padding: EdgeInsets.only(top: 20),
                header: 'Prescriptions',
                headerAction: TextButton.icon(
                  onPressed: () => addItem(record),
                  icon: Icon(MIcons.plus),
                  label: const Text('Add'),
                ),
                items: [...widgets],
              ),
            if (widgets.isEmpty)
              DynamicGroup(
                header: 'Prescriptions',
                items: [
                  DynamicGroupItem.widget(
                    value: Container(
                      height: 120,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('No prescriptions found.'),
                          SizedBox(height: 8),
                          TextButton.icon(
                            icon: Icon(MIcons.plus),
                            onPressed: () => addItem(record),
                            label: Text('Add New Prescription'),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            if (widgets.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    icon: Icon(MIcons.printerOutline),
                    label: Text('Print'),
                    onPressed: () {},
                  ),
                  TextButton.icon(
                    icon: Icon(MIcons.filePdfBox),
                    label: Text('Generate Pdf'),
                    onPressed: () {},
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}

///
/// Handles post-delete side effects like showing snackbar,
/// popping navigation, and refreshing local state.
///
TaskResult<void> _handleSuccessfulDeleteTaskSidEffects({
  required BuildContext context,
  required String patientRecordId,
  required void Function(String id) refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Successfully Deleted');
    if (context.canPop()) context.pop();
    refresh(patientRecordId);
    return null;
  }).toTaskEither<Failure>();
}

///
/// Handles Failure
/// Shows a snackbar when a failure occurs
///
void _handleFailure(BuildContext context, Failure failure) {
  if (failure is CancelledFailure) return;
  AppSnackBar.rootFailure(failure);
}
