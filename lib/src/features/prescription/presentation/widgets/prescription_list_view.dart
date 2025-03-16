import 'package:flutter/material.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/features/prescription/data/prescription_item_repository.dart';
import 'package:gym_system/src/features/prescription/domain/prescription_item.dart';
import 'package:gym_system/src/features/prescription/presentation/controllers/prescription_all_items_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PrescriptionListView extends HookConsumerWidget {
  final String medicalRecordId;

  const PrescriptionListView({super.key, required this.medicalRecordId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider =
        prescriptionAllItemsControllerProvider(id: medicalRecordId);
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
                    id: medicalRecordId));
                AppSnackBar.root(message: 'Successfully Deleted');
                ref.invalidate(provider);
              },
            );
          });
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
          return Container(
            height: 200,
            alignment: Alignment.center,
            child: Text(
              'Prescriptions not yet given',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];

            return ListTile(
              isThreeLine: true,
              leading: CircleAvatar(child: Text((index + 1).toString())),
              title: Text(
                item.medication.optional(placeholder: 'no medication'),
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.dosage.optional(placeholder: 'no dosage given')),
                  Text(
                    item.instructions.optional(placeholder: 'no instructions'),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => onDelete(item),
              ),
            );
          },
        );
      },
    );
  }
}
