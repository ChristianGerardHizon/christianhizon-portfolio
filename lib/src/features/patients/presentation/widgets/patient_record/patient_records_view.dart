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
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/features/patients/data/patient_record_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patients/domain/patient_record.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patient_record/patient_record_table_controller.dart';
import 'package:gym_system/src/features/patients/presentation/widgets/patient_record/patient_record_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientRecordsView extends HookConsumerWidget {
  final Patient patient;
  const PatientRecordsView({super.key, required this.patient});

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
      // appBar: AppBar(
      //   leading: SizedBox(),
      //   centerTitle: false,
      //   title: Text('PatientRecords'),
      //   actions: [
      //     RefreshButton(onPressed: onRefresh),
      //   ],
      // ),
      body: listState.when(
        skipError: false,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        error: (error, stack) => Center(
          child: Text(error.toString()),
        ),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
        data: (items) => DynamicTableView<PatientRecord>(
          tableKey: TableControllerKeys.patientRecord,
          error: null,
          items: items,
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
              width: 200,
              alignment: Alignment.center,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          onEdit(data);
                        },
                        icon: Icon(
                          MIcons.pencilOutline,
                          color: const Color.fromARGB(255, 28, 49, 66),
                        ),
                        label: Text(
                          'Edit',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 28, 49, 66),
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          onDelete([data]);
                        },
                        icon: Icon(MIcons.deleteOutline, color: Colors.red),
                        label: Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
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
