import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sannjosevet/src/core/extensions/date_time_extension.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/core/routing/router.dart';
import 'package:sannjosevet/src/core/strings/table_controller_keys.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/modals/confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/sliver_dynamic_table_view.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/dynamic_table_column.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:sannjosevet/src/core/widgets/failure_message.dart';
import 'package:sannjosevet/src/core/widgets/popover_widget.dart';
import 'package:sannjosevet/src/core/widgets/refresh_button.dart';
import 'package:sannjosevet/src/features/patient_treament_records/data/patient_treatment_record_repository.dart';
import 'package:sannjosevet/src/features/patient_treament_records/domain/patient_treatment_record.dart';
import 'package:sannjosevet/src/features/patient_treament_records/presentation/controllers/patient_treatment_record_table_controller.dart';
import 'package:sannjosevet/src/features/patient_treament_records/presentation/widgets/patient_treament_record_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientTreatmentRecordsPage extends HookConsumerWidget {
  const PatientTreatmentRecordsPage({
    super.key,
    required this.id,
    this.showAppBar = true,
  });
  final String id;
  final bool showAppBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = TableControllerKeys.patientTreatmentRecordPatient(id);
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider =
        patientTreatmentRecordTableControllerProvider(tableKey, id);
    final listState = ref.watch(listProvider);

    ///
    /// onTap
    ///
    onTap(PatientTreatmentRecord patientTreatmentRecord) {
      PatientTreatmentRecordPageRoute(patientTreatmentRecord.id).push(context);
    }

    ///
    /// onEdit
    ///
    // onEdit(PatientTreatmentRecord patientTreatmentRecord) {
    //   PatientTreatmentRecordFormPageRoute(
    //     parentId: patientTreatmentRecord.patient,
    //     id: patientTreatmentRecord.id,
    //   ).push(context);
    // }

    // onShowActions(PatientTreatmentRecord patientTreatmentRecord) {
    //   PatientTreatmentRecordFormPageRoute(
    //     parentId: patientTreatmentRecord.patient,
    //     id: patientTreatmentRecord.id,
    //   ).push(context);
    // }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(patientTreatmentRecordTableControllerProvider);
      ref.invalidate(provider);
      notifier.clearSelection();
    }

    ///
    /// onDelete
    ///
    onDelete(List<PatientTreatmentRecord> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(patientTreatmentRecordRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          notifier.clearSelection();
          ref.invalidate(patientTreatmentRecordTableControllerProvider);
          AppSnackBar.root(message: 'Successfully Deleted');
        },
      );
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      PatientTreatmentRecordFormPageRoute(parentId: id).push(context);
    }

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              centerTitle: false,
              title: Text('PatientTreatmentRecords'),
              actions: [
                RefreshButton(onPressed: onRefresh),
              ],
            )
          : null,
      body: SliverDynamicTableView<PatientTreatmentRecord>(
        tableKey: tableKey,
        error: FailureMessage.asyncValue(listState),
        isLoading: listState.isLoading,
        items: listState.value ?? [],
        onDelete: onDelete,
        onRowTap: onTap,

        ///
        /// Search Features
        ///
        searchCtrl: searchCtrl,
        onCreate: onCreate,

        ///
        /// Table Data
        ///
        columns: [
          DynamicTableColumn(
            header: 'Treatment',
            width: 300,
            alignment: Alignment.centerLeft,
            builder: (context, data, row, column) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  (data.expand.treatment.name).optional(),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          ),
          DynamicTableColumn(
            header: 'Date',
            width: 200,
            alignment: Alignment.centerLeft,
            builder: (context, data, row, column) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  (data.date?.toLocal().fullReadable).optional(),
                  overflow: TextOverflow.ellipsis,
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

        ///
        /// Builder for mobile
        ///
        mobileBuilder: (context, index, patientTreatmentRecord, selected) {
          return PatientTreatmentRecordCard(
            patientTreatmentRecord: patientTreatmentRecord,
            onTap: () {
              if (selected)
                notifier.toggleRow(index);
              else
                onTap(patientTreatmentRecord);
            },
            selected: selected,
            onLongPress: () {
              notifier.toggleRow(index);
            },
          );
        },
      ),
    );
  }
}
