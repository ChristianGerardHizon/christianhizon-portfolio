import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/card_group.dart';
import 'package:gym_system/src/core/widgets/collapsing_card.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_list_tile.dart';
import 'package:gym_system/src/features/medical_records/data/medical_record_repository.dart';
import 'package:gym_system/src/features/medical_records/domain/medical_record.dart';
import 'package:gym_system/src/features/medical_records/presentation/controllers/medical_records_controller.dart';
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
                if (context.canPop()) context.pop();
              },
            );
          });
    }

    ///
    ///
    ///
    onTap(MedicalRecord record) {}

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
                  DynamicListTile(
                    title: Text('Follow Up Date: '),
                    content: Text((record.followUpDate?.yyyyMMdd()).optional()),
                  ),
                ],
              ),
            ),

            ///
            /// Details
            ///
            CollapsingCard(
              header: Text(
                'Other Information',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              child: Column(
                children: [
                  ///
                  /// Visit Date
                  ///
                  DynamicListTile.divider(
                    title: Text('Created: '),
                    content: Text((record.created?.yyyyMMdd()).optional()),
                  ),

                  ///
                  /// Diagnosis
                  ///
                  DynamicListTile(
                    title: Text('Updated: '),
                    content: Text((record.updated?.yyyyMMdd()).optional()),
                  ),
                ],
              ),
            )
          ],
        ),

        ///
        /// Actions
        ///
        SliverList.list(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CardGroup(
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
                  leading: const Icon(Icons.edit_outlined),
                  title: const Text('Update Prescriptions'),
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
          ),
        ])
      ],
    );
  }
}
