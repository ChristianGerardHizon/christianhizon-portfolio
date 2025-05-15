import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/strings/table_controller_keys.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/modals/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/sliver_dynamic_table_view.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/dynamic_table_column.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/core/widgets/failure_message.dart';
import 'package:gym_system/src/core/widgets/popover_widget.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/core/widgets/stack_loader.dart';
import 'package:gym_system/src/features/patient_treaments/data/patient_treatment_repository.dart';
import 'package:gym_system/src/features/patient_treaments/domain/patient_treatment.dart';
import 'package:gym_system/src/features/patient_treaments/presentation/controllers/patient_treatment_table_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gym_system/src/features/patient_treaments/presentation/widgets/patient_treatment_card.dart';

class PatientTreatmentsPage extends HookConsumerWidget {
  const PatientTreatmentsPage({
    super.key,
    this.showAppBar = true,
  });
  final bool showAppBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = TableControllerKeys.patientTreatment;
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = patientTreatmentTableControllerProvider(tableKey);
    final listState = ref.watch(listProvider);
    final isLoading = useState(false);

    void onRefresh() {
      ref.invalidate(listProvider);
      ref.invalidate(provider);
      notifier.clearSelection();
    }

    void onEdit(PatientTreatment treatment) {
      PatientTreamentFormPageRoute(id: treatment.id).push(context);
    }

    Future<void> onDelete(List<PatientTreatment> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(patientTreatmentRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      final result = await repo.softDeleteMulti(ids).run();
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          notifier.clearSelection();
          ref.invalidate(listProvider);
          AppSnackBar.root(message: 'Successfully Deleted');
        },
      );
    }

    void onCreate() {
      PatientTreamentFormPageRoute().push(context);
    }

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              centerTitle: false,
              title: const Text('Patient Treatments'),
              actions: [
                RefreshButton(onPressed: onRefresh),
              ],
            )
          : null,
      body: StackLoader(
        opacity: .8,
        isLoading: isLoading.value,
        child: SliverDynamicTableView<PatientTreatment>(
          tableKey: tableKey,
          error: FailureMessage.asyncValue(listState),
          isLoading: listState.isLoading,
          items: listState.valueOrNull ?? [],
          onDelete: onDelete,
          onRowTap: null,
          searchCtrl: searchCtrl,
          onCreate: onCreate,
          columns: [
            DynamicTableColumn(
              header: 'Name',
              width: 200,
              alignment: Alignment.centerLeft,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    data.name,
                  ),
                );
              },
            ),
            DynamicTableColumn(
              header: 'Actions',
              width: 159,
              alignment: Alignment.center,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.center,
                  child: PopoverWidget.icon(
                    icon: Icon(MIcons.dotsHorizontal),
                    bottomSheetHeader: const Text('Action'),
                    items: [
                      PopoverMenuItemData(
                        name: 'Edit',
                        onTap: () {
                          onEdit(data);
                        },
                      ),
                      PopoverMenuItemData(
                        name: 'Delete',
                        onTap: () {
                          onDelete([data]);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
          mobileBuilder: (context, index, treatment, selected) {
            return PatientTreatmentCard(
              treatment: treatment,
              onTap: () {
                // You can implement navigation or selection logic here if needed
              },
            );
          },
        ),
      ),
    );
  }
}
