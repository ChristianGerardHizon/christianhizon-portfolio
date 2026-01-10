import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/core/routing/router.dart';
import 'package:sannjosevet/src/core/strings/table_controller_keys.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/circle_widget.dart';
import 'package:sannjosevet/src/core/widgets/modals/confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/sliver_dynamic_table_view.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/dynamic_table_column.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:sannjosevet/src/core/widgets/failure_message.dart';
import 'package:sannjosevet/src/core/widgets/pb_image_circle.dart';
import 'package:sannjosevet/src/core/widgets/refresh_button.dart';
import 'package:sannjosevet/src/features/patients/core/data/patient_repository.dart';
import 'package:sannjosevet/src/features/patients/core/domain/patient.dart';
import 'package:sannjosevet/src/features/patients/core/presentation/controllers/patient_table_controller.dart';
import 'package:sannjosevet/src/features/patients/core/presentation/widgets/patient_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientsPage extends HookConsumerWidget {
  const PatientsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = TableControllerKeys.patient;
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = patientTableControllerProvider(tableKey);
    final listState = ref.watch(listProvider);

    ///
    /// onTap
    ///
    onTap(Patient patient) {
      PatientPageRoute(patient.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(patientTableControllerProvider);
      ref.invalidate(provider);
      notifier.clearSelection();
    }

    ///
    /// onDelete
    ///
    onDelete(List<Patient> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(patientRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          notifier.clearSelection();
          ref.invalidate(patientTableControllerProvider);
          AppSnackBar.root(message: 'Successfully Deleted');
        },
      );
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      PatientFormPageRoute().push(context);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Patients'),
          actions: [
            RefreshButton(
              onPressed: onRefresh,
            ),
          ],
        ),
        body: SliverDynamicTableView<Patient>(
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
              header: 'Name',
              width: 250,
              alignment: Alignment.centerLeft,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      CircleWidget(
                        size: Size.square(40),
                        child: PbImageCircle(
                          collection: data.collectionId,
                          recordId: data.id,
                          file: data.avatar,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        data.name,
                      ),
                    ],
                  ),
                );
              },
            ),
            DynamicTableColumn(
              header: 'Branch',
              alignment: Alignment.centerLeft,
              builder: (context, patient, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text((patient.expand.branch?.name).optional(),
                      overflow: TextOverflow.ellipsis),
                );
              },
            ),
            DynamicTableColumn(
              header: 'Owner',
              alignment: Alignment.centerLeft,
              builder: (context, patient, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text((patient.owner).optional(),
                      overflow: TextOverflow.ellipsis),
                );
              },
            ),
          ],

          ///
          /// Builder for mobile
          ///
          mobileBuilder: (context, index, patient, selected) {
            return PatientCard(
              patient: patient,
              onTap: () {
                if (selected)
                  notifier.toggleRow(index);
                else
                  onTap(patient);
              },
              selected: selected,
              onLongPress: () {
                notifier.toggleRow(index);
              },
            );
          },
        )

        // listState.when(
        //   skipError: false,
        //   skipLoadingOnRefresh: false,
        //   skipLoadingOnReload: false,
        //   error: (error, stack) => Center(
        //     child: Text(error.toString()),
        //   ),
        //   loading: () => Center(
        //     child: CircularProgressIndicator(),
        //   ),
        //   data: (items) => DynamicTableView<Patient>(
        //     tableKey: TableControllerKeys.patient,
        //     error: null,
        //     items: items,
        //     onDelete: onDelete,
        //     onRowTap: onTap,

        //     ///
        //     /// Search Features
        //     ///
        //     searchCtrl: searchCtrl,
        //     onCreate: onCreate,

        //     ///
        //     /// Table Data
        //     ///
        //     columns: [
        //       TableColumn(
        //         header: 'Name',
        //         width: 250,
        //         alignment: Alignment.centerLeft,
        //         builder: (context, data, row, column) {
        //           return Align(
        //             alignment: Alignment.centerLeft,
        //             child: Row(
        //               children: [
        //                 CircleWidget(
        //                   size: 40,
        //                   child: PbImageCircle(
        //                     collection: data.collectionId,
        //                     recordId: data.id,
        //                     file: data.avatar,
        //                     fit: BoxFit.fitWidth,
        //                   ),
        //                 ),
        //                 SizedBox(width: 10),
        //                 Text(
        //                   overflow: TextOverflow.ellipsis,
        //                   data.name,
        //                 ),
        //               ],
        //             ),
        //           );
        //         },
        //       ),
        //       TableColumn(
        //         header: 'Branch',
        //         alignment: Alignment.centerLeft,
        //         builder: (context, patient, row, column) {
        //           return Align(
        //             alignment: Alignment.centerLeft,
        //             child: Text((patient.expand.branch?.name).optional(),
        //                 overflow: TextOverflow.ellipsis),
        //           );
        //         },
        //       ),
        //       TableColumn(
        //         header: 'Owner',
        //         alignment: Alignment.centerLeft,
        //         builder: (context, patient, row, column) {
        //           return Align(
        //             alignment: Alignment.centerLeft,
        //             child: Text((patient.owner).optional(),
        //                 overflow: TextOverflow.ellipsis),
        //           );
        //         },
        //       ),
        //     ],

        //     ///
        //     /// Builder for mobile
        //     ///
        //     mobileBuilder: (context, index, patient, selected) {
        //       return PatientCard(
        //         patient: patient,
        //         onTap: () {
        //           if (selected)
        //             notifier.toggleRow(index);
        //           else
        //             onTap(patient);
        //         },
        //         selected: selected,
        //         onLongPress: () {
        //           notifier.toggleRow(index);
        //         },
        //       );
        //     },
        //   ),
        // ),
        );
  }
}
