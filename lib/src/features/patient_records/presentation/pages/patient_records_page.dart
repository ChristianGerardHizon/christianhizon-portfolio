import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/strings/table_controller_keys.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/dynamic_table_view.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_column.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/core/widgets/failure_message.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/features/patient_records/data/patient_record_repository.dart';
import 'package:gym_system/src/features/patient_records/presentation/controllers/patient_record_table_controller.dart';
import 'package:gym_system/src/features/patient_records/presentation/widgets/patient_record_card.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patient_records/domain/patient_record.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientRecordsPage extends HookConsumerWidget {
  const PatientRecordsPage({
    super.key,
    required this.patient,
    this.showAppBar = true,
  });
  final Patient patient;
  final bool showAppBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = TableControllerKeys.patientRecord;
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = patientRecordTableControllerProvider(tableKey);
    final listState = ref.watch(listProvider);

    ///
    /// onTap
    ///
    onTap(PatientRecord patientRecord) {
      PatientRecordPageRoute(patientRecord.id).push(context);
    }

    ///
    /// onEdit
    ///
    onEdit(PatientRecord patientRecord) {
      PatientRecordFormPageRoute(
        parentId: patientRecord.patient,
        id: patientRecord.id,
      ).push(context);
    }

    onShowActions(PatientRecord patientRecord) {
      PatientRecordFormPageRoute(
        parentId: patientRecord.patient,
        id: patientRecord.id,
      ).push(context);
    }

    ///
    ///
    ///
    onFollowUp(PatientRecord patientRecord) {
      PatientRecordFormPageRoute(
        parentId: patientRecord.patient,
        id: patientRecord.id,
      ).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(patientRecordTableControllerProvider);
      ref.invalidate(provider);
      notifier.clearSelection();
    }

    ///
    /// onDelete
    ///
    onDelete(List<PatientRecord> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(patientRecordRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          notifier.clearSelection();
          ref.invalidate(patientRecordTableControllerProvider);
          AppSnackBar.root(message: 'Successfully Deleted');
          if (context.canPop()) context.pop();
        },
      );
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      PatientRecordFormPageRoute(parentId: patient.id).push(context);
    }

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              leading: SizedBox(),
              centerTitle: false,
              title: Text('PatientRecords'),
              actions: [
                RefreshButton(onPressed: onRefresh),
              ],
            )
          : null,
      body: DynamicTableView<PatientRecord>(
        tableKey: TableControllerKeys.patientRecord,
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
          TableColumn(
            header: 'Visit',
            width: 200,
            alignment: Alignment.centerLeft,
            builder: (context, data, row, column) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  data.visitDate.toLocal().fullDateTime,
                ),
              );
            },
          ),
          TableColumn(
            header: 'Diagnosis',
            width: 200,
            alignment: Alignment.centerLeft,
            builder: (context, data, row, column) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  data.diagnosis.optional(),
                ),
              );
            },
          ),
          TableColumn(
            header: 'Actions',
            width: 75,
            alignment: Alignment.center,
            builder: (context, data, row, column) {
              return Align(
                alignment: Alignment.center,
                child: IconButton(
                  tooltip: 'Show more actions',
                  onPressed: () => onShowActions(data),
                  icon: Icon(MIcons.dotsHorizontalCircleOutline),
                ),
              );
            },
          ),
        ],

        ///
        /// Builder for mobile
        ///
        mobileBuilder: (context, index, patientRecord, selected) {
          return PatientRecordCard(
            patientRecord: patientRecord,
            onTap: () {
              if (selected)
                notifier.toggleRow(index);
              else
                onTap(patientRecord);
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
