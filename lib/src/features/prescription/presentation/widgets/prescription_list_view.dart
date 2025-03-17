import 'package:flutter/material.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/features/medical_records/domain/medical_record.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients/patient_controller.dart';
import 'package:gym_system/src/features/prescription/data/prescription_item_repository.dart';
import 'package:gym_system/src/features/prescription/domain/prescription_item.dart';
import 'package:gym_system/src/features/prescription/presentation/controllers/prescription_all_items_controller.dart';
import 'package:gym_system/src/features/prescription/presentation/sheets/prescription_item_create_sheet.dart';
import 'package:gym_system/src/features/prescription/presentation/widgets/prescription_items_pdf_generator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PrescriptionListView extends HookConsumerWidget {
  final MedicalRecord record;

  const PrescriptionListView({super.key, required this.record});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = prescriptionAllItemsControllerProvider(id: record.id);
    final state = ref.watch(provider);
    final theme = Theme.of(context);

    onDelete(PrescriptionItem item) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;

      final repo = ref.read(prescriptionItemRepositoryProvider);
      repo.softDeleteMulti([item.id]).run().then((result) {
            result.fold(
              (l) => AppSnackBar.rootFailure(l),
              (r) {
                ref.invalidate(prescriptionAllItemsControllerProvider(
                  id: record.id,
                ));
                AppSnackBar.root(message: 'Successfully Deleted');
                ref.invalidate(provider);
              },
            );
          });
    }

    onPrescriptionAdd() async {
      final result =
          await PrescriptionItemCreateSheet.show(context, record: record);
      if (result is! PrescriptionItem) return;
      ref.invalidate(prescriptionAllItemsControllerProvider(id: record.id));
    }

    onPrint(List<PrescriptionItem> list) async {
      final result = await TaskResult.tryCatch(() async {
        AppSnackBar.root(message: 'Print Starting...');
        final patient =
            await ref.read(patientControllerProvider(record.patient).future);
        await PrescriptionItemsPdfGenerator(items: list, patient: patient, record: record)
            .print();
      }, Failure.tryCatchPresentation)
          .run();

      result.fold((l) {
        AppSnackBar.rootFailure(l);
      }, (r) {});
    }

    onShare(List<PrescriptionItem> list) async {
      final result = await TaskResult.tryCatch(() async {
        AppSnackBar.root(message: 'Share Starting...');
        final patient =
            await ref.read(patientControllerProvider(record.patient).future);
        await PrescriptionItemsPdfGenerator(items: list, patient: patient, record: record)
            .share();
      }, Failure.tryCatchPresentation)
          .run();

      result.fold((l) {
        AppSnackBar.rootFailure(l);
      }, (r) {});
    }

    buildActions({List<PrescriptionItem>? list}) {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              label: Text('Add Prescription'),
              icon: Icon(Icons.add),
              onPressed: onPrescriptionAdd,
            ),
            if (list is List)
              SizedBox(
                width: 120,
                child: TextButton.icon(
                  label: Text('Print'),
                  icon: Icon(MIcons.printer),
                  onPressed: () => onPrint(list!),
                ),
              ),
            if (list is List)
              SizedBox(
                width: 120,
                child: TextButton.icon(
                  label: Text('Share'),
                  icon: Icon(MIcons.share),
                  onPressed: () => onShare(list!),
                ),
              ),
          ],
        ),
      );
    }

    return state.when(
      skipError: false,
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      error: (error, stackTrace) => SizedBox(
          height: 200,
          child: Center(
            child: Text(
              error.toString(),
            ),
          )),
      loading: () => SizedBox(
          height: 200, child: const Center(child: CircularProgressIndicator())),
      data: (list) {
        ///
        /// Empty List
        ///
        if (list.isEmpty) {
          return Column(
            children: [
              Container(
                height: 200,
                alignment: Alignment.center,
                child: Text(
                  'Prescriptions not yet given',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              buildActions(),
            ],
          );
        }

        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];

                return ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.primaryFixedDim,
                    child: Text(
                      (index + 1).toString(),
                      style: theme.textTheme.titleMedium?.copyWith(),
                    ),
                  ),
                  title: Text(
                    item.medication.optional(placeholder: 'no medication'),
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          item.dosage.optional(placeholder: 'no dosage given')),
                      Text(
                        item.instructions
                            .optional(placeholder: 'no instructions'),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    color: theme.colorScheme.error,
                    icon: Icon(MIcons.trashCanOutline, size: 22),
                    onPressed: () => onDelete(item),
                  ),
                );
              },
            ),

            ///
            /// Actions
            ///
            buildActions(list: list),
          ],
        );
      },
    );
  }
}
