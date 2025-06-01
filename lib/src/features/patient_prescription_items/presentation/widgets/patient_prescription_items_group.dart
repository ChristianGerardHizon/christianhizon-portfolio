import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sannjosevet/src/core/extensions/date_time_extension.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/routing/router.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/modals/confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:sannjosevet/src/core/widgets/modals/dropdown_confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/popover_widget.dart';
import 'package:sannjosevet/src/core/widgets/stack_loader.dart';
import 'package:sannjosevet/src/features/patient_prescription_items/data/patient_prescription_item_repository.dart';
import 'package:sannjosevet/src/features/patient_prescription_items/domain/patient_prescription_item.dart';
import 'package:sannjosevet/src/features/patient_prescription_items/presentation/controllers/patient_prescription_item_group_controller.dart';
import 'package:sannjosevet/src/features/patient_prescription_items/presentation/widgets/patient_prescription_items_pdf_generator.dart';
import 'package:sannjosevet/src/features/patient_records/domain/patient_record.dart';
import 'package:sannjosevet/src/features/patient_records/presentation/controllers/patient_record_controller.dart';
import 'package:sannjosevet/src/features/patients/domain/patient.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum _Action { print, share, save }

class PatientPrescriptionItemsGroup extends HookConsumerWidget {
  const PatientPrescriptionItemsGroup(
      {super.key, required this.record, required this.patient});

  final PatientRecord record;
  final Patient patient;

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
    final list = state.maybeWhen(
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      data: (data) => data,
      orElse: () => <PatientPrescriptionItemGroupState>[],
    );

    ///
    /// print
    ///
    void print({
      required List<PatientPrescriptionItemGroupState> items,
      required PatientRecord record,
      required _Action action,
    }) async {
      final result = await TaskResult<DateTime?>.tryCatch(
        () async {
          return DropdownConfirmModal.show<DateTime>(context,
              title: 'Select Date',
              options: items.map((e) {
                return DropdownConfirmOption(
                  label: e.date.fullDate,
                  value: e.date,
                );
              }).toList());
        },
        Failure.handle,
      )

          /// check if null
          .flatMap((dateTime) {
            if (dateTime == null)
              return TaskResult.left(CancelledFailure('Cancelled'));
            return TaskResult.right(dateTime);
          })

          /// filter all items
          .map((dateTime) => items
              .where((x) => x.date == dateTime)
              .toList()
              .firstOrNull
              ?.items)

          /// check if no date
          .flatMap((items) {
            if (items == null || items.isEmpty) {
              return TaskResult.left(PresentationFailure('no Date selected'));
            }
            return TaskResult.right(items);
          })

          /// setup generator
          .flatMap((items) {
            return TaskResult<PatientPdfGenerator>.tryCatch(() async {
              return PatientPdfGenerator(
                patient: patient,
                record: record,
                items: items ?? [],
              );
            }, Failure.handle);
          })

          /// start process
          .flatMap((gen) => TaskResult.tryCatch(
                () async {
                  if (action == _Action.print) {
                    gen.print();
                  }

                  if (action == _Action.share) {
                    gen.share();
                  }

                  if (action == _Action.save) {
                    gen.save();
                  }
                },
                Failure.handle,
              ))
          .run();

      result.match(
        AppSnackBar.rootFailure,
        (_) {
          AppSnackBar.root(message: 'Success');
        },
      );
    }

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
      ref.invalidate(patientRecordControllerProvider(id));
      ref.invalidate(patientPrescriptionItemGroupControllerProvider(id));
    }

    ///
    /// onDelete
    ///
    onDelete(PatientPrescriptionItem patientPrescriptionItem) async {
      final fullTask = await
          // 1. Call Confirm Modal
          ConfirmModal.taskResult(context)
              .flatMap((_) {
                isLoading.value = true;
                return TaskResult.right(_);
              })

              // 2. Delete Network Call
              .flatMap(
                  (_) => repo.softDeleteMulti([patientPrescriptionItem.id]))
              // 3. Side effects
              .flatMap(
                (_) => _handleSuccessfulDeleteTaskSidEffects(
                  context: context,
                  patientPrescriptionItemId: patientPrescriptionItem.id,
                  refresh: refresh,
                ),
              );

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
                text: e.dosage.enclose('(', close: ')', skipIfEmpty: true),
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(e.instructions.optional()),
          ],
        ),
        trailing: PopoverWidget.icon(
          icon: Icon(MIcons.dotsHorizontal),
          bottomSheetHeader: const Text('Action'),
          items: [
            PopoverMenuItemData(
              name: 'Edit',
              onTap: () => onUpdate(e),
            ),
            PopoverMenuItemData(
              name: 'Delete',
              onTap: () => onDelete(e),
            ),
          ],
        ),
      );
    }

    final widgets = list
        .map((item) => DynamicGroupItem.field(
              title: item.date.toLocal().fullDate,
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
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widgets.isNotEmpty)
              DynamicGroup(
                padding: const EdgeInsets.only(left: 8, right: 8),
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
                padding: const EdgeInsets.only(left: 8, right: 8),
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
                    onPressed: () => print(
                        items: list, record: record, action: _Action.print),
                  ),
                  TextButton.icon(
                    icon: Icon(MIcons.floppy),
                    label: Text('Save to device'),
                    onPressed: () => print(
                        items: list, record: record, action: _Action.save),
                  ),
                  TextButton.icon(
                    icon: Icon(MIcons.shareOutline),
                    label: Text('Share'),
                    onPressed: () => print(
                        items: list, record: record, action: _Action.share),
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
  required String patientPrescriptionItemId,
  required void Function(String id) refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Successfully Deleted');
    refresh(patientPrescriptionItemId);
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
