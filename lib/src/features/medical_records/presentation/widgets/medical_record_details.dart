import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/card_group.dart';
import 'package:gym_system/src/core/widgets/collapsing_card.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_list_tile.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/features/medical_records/data/medical_record_repository.dart';
import 'package:gym_system/src/features/medical_records/domain/medical_record.dart';
import 'package:gym_system/src/features/medical_records/presentation/controllers/medical_record_controller.dart';
import 'package:gym_system/src/features/medical_records/presentation/controllers/medical_records_controller.dart';
import 'package:gym_system/src/features/medical_records/presentation/sheets/medical_record_update_sheet.dart';
import 'package:gym_system/src/features/prescription/presentation/controllers/prescription_all_items_controller.dart';
import 'package:gym_system/src/features/prescription/presentation/widgets/prescription_list_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MedicalRecordDetails extends HookConsumerWidget {
  final MedicalRecord record;
  const MedicalRecordDetails({super.key, required this.record});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    /// onDelete
    ///
    onDelete(MedicalRecord record) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(medicalRecordRepositoryProvider);
      repo.softDeleteMulti([record.id]).run().then((result) {
            result.fold(
              (l) => AppSnackBar.rootFailure(l),
              (r) {
                ref.invalidate(medicalRecordsControllerProvider);
                AppSnackBar.root(message: 'Successfully Deleted');
                ref.invalidate(medicalRecordControllerProvider(record.id));
                if (context.canPop()) context.pop();
              },
            );
          });
    }


    ///
    ///
    ///
    onTap(MedicalRecord record) {
      MedicalRecordUpdateSheet.show(context, record: record);
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 30)),
        SliverList.list(
          children: [
            ///
            /// Details
            ///
            CollapsingCard(
              header: Text(
                'Details',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              child: Column(
                children: [
                  ///
                  /// Visit Date
                  ///
                  DynamicListTile.divider(
                    title: Text('Vist Date: '),
                    content: Text((record.visitDate.yyyyMMdd()).optional()),
                  ),

                  ///
                  /// Diagnosis
                  ///
                  DynamicListTile.divider(
                    title: Text('Diagnosis: '),
                    content: Text((record.diagnosis).optional()),
                  ),

                  ///
                  /// Treatment
                  ///
                  DynamicListTile.divider(
                    title: Text('Treatment: '),
                    content: Text((record.treatment).optional()),
                  ),

                  ///
                  /// Follow Up Date
                  ///
                  DynamicListTile.divider(
                    title: Text('Follow Up Date: '),
                    content: Text((record.followUpDate?.yyyyMMdd()).optional()),
                  ),

                  ///
                  /// Visit Date
                  ///
                  DynamicListTile(
                    title: Text('Created: '),
                    content: Text((record.created?.yyyyMMdd()).optional()),
                  ),
                ],
              ),
            ),
          ],
        ),

        ///
        /// Prescriptions
        ///
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          sliver: SliverList.list(children: [
            ///
            /// Prescription
            ///
            CollapsingCard(
              canCollapse: false,
              header: Row(
                children: [
                  Text(
                    'Prescriptions',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(width: 4),
                  RefreshButton(
                    onPressed: () => ref.invalidate(
                        prescriptionAllItemsControllerProvider(id: record.id)),
                  ),
                ],
              ),
              child: PrescriptionListView(record: record),
            ),
          ]),
        ),

        ///
        /// Actions
        ///
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          sliver: SliverList.list(children: [
            CardGroup(
              header: 'Actions',
              children: [
                ListTile(
                  leading: const Icon(Icons.edit_outlined),
                  title: const Text('Edit Medical Record Information'),
                  trailing: const Icon(
                    Icons.chevron_right_outlined,
                    size: 24,
                  ),
                  onTap: () => onTap(record),
                ),
                ListTile(
                  leading: const Icon(Icons.delete_outlined),
                  title: const Text('Delete Medical Record Permanently'),
                  trailing: const Icon(
                    Icons.chevron_right_outlined,
                    size: 24,
                  ),
                  onTap: () => onDelete(record),
                ),
              ],
            ),
          ]),
        )
      ],
    );
  }
}
