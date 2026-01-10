import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sannjosevet/src/core/extensions/date_time_extension.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/core/routing/router.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/strings/table_controller_keys.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/modals/confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/sliver_dynamic_table_view.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/dynamic_table_column.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:sannjosevet/src/core/widgets/failure_message.dart';
import 'package:sannjosevet/src/core/widgets/refresh_button.dart';
import 'package:sannjosevet/src/core/widgets/stack_loader.dart';
import 'package:sannjosevet/src/features/patients/records/data/patient_record_repository.dart';
import 'package:sannjosevet/src/features/patients/records/presentation/controllers/patient_record_controller.dart';
import 'package:sannjosevet/src/features/patients/records/presentation/controllers/patient_record_table_controller.dart';
import 'package:sannjosevet/src/features/patients/records/presentation/widgets/patient_record_card.dart';
import 'package:sannjosevet/src/features/patients/core/domain/patient.dart';
import 'package:sannjosevet/src/features/patients/records/domain/patient_record.dart';
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
    final tableKey = TableControllerKeys.patientRecordPatient(patient.id);
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider =
        patientRecordTableControllerProvider(tableKey, patientId: patient.id);
    final listState = ref.watch(listProvider);

    final isLoading = useState(false);

    ///
    /// onTap
    ///
    onTap(PatientRecord patientRecord) {
      PatientRecordPageRoute(patientRecord.id).push(context);
    }

    ///
    /// onEdit
    ///
    // onEdit(PatientRecord patientRecord) {
    //   PatientRecordFormPageRoute(
    //     parentId: patientRecord.patient,
    //     id: patientRecord.id,
    //   ).push(context);
    // }

    onShowActions(PatientRecord patientRecord) {
      PatientRecordFormPageRoute(
        parentId: patientRecord.patient,
        id: patientRecord.id,
      ).push(context);
    }

    ///
    ///
    ///
    // onFollowUp(PatientRecord patientRecord) {
    //   PatientRecordFormPageRoute(
    //     parentId: patientRecord.patient,
    //     id: patientRecord.id,
    //   ).push(context);
    // }

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
        },
      );
    }

    ///
    /// OnCreate
    ///
    // onCreate() {
    //   /// redirect
    //   PatientRecordFormPageRoute(parentId: patient.id).push(context);
    // }

    ///
    /// OnCreateWithPatient
    ///
    void onCreateWithPatient() async {
      final repository = ref.read(patientRecordRepositoryProvider);
      final value = {
        PatientRecordField.patient: patient.id,
        PatientRecordField.vistDate: DateTime.now().toUtc().toIso8601String(),
      };

      final task = repository.create(value);
      isLoading.value = true;
      final result = await task.run();
      if (!context.mounted) return;
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(patientRecordTableControllerProvider);
          ref.invalidate(patientRecordControllerProvider(r.id));
          PatientRecordPageRoute(r.id).push(context);
        },
      );
    }

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              centerTitle: false,
              title: Text('PatientRecords'),
              actions: [
                RefreshButton(onPressed: onRefresh),
              ],
            )
          : null,
      body: StackLoader(
        opacity: .8,
        isLoading: isLoading.value,
        child: SliverDynamicTableView<PatientRecord>(
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
          onCreate: onCreateWithPatient,

          ///
          /// Table Data
          ///
          columns: [
            DynamicTableColumn(
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
            DynamicTableColumn(
              header: 'Weight in Kg',
              width: 120,
              alignment: Alignment.centerLeft,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    data.displayWeightInKg.optional(),
                  ),
                );
              },
            ),
            DynamicTableColumn(
              header: 'Tests',
              width: 200,
              alignment: Alignment.centerLeft,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    data.tests.optional(),
                  ),
                );
              },
            ),
            DynamicTableColumn(
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
            DynamicTableColumn(
              header: 'Treatment',
              width: 200,
              alignment: Alignment.centerLeft,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    data.treatment.optional(),
                  ),
                );
              },
            ),
            DynamicTableColumn(
              header: 'Actions',
              width: 75,
              alignment: Alignment.center,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    tooltip: 'Show more actions',
                    onPressed: () => onShowActions(data),
                    icon: Icon(MIcons.dotsHorizontal),
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
      ),
    );
  }
}
