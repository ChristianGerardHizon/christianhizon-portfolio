import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/strings/table_controller_keys.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/dynamic_table_view.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_column.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/core/widgets/failure_message.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/core/widgets/stack_loader.dart';
import 'package:gym_system/src/features/patient_files/data/patient_file_repository.dart';
import 'package:gym_system/src/features/patient_files/domain/patient_file.dart';
import 'package:gym_system/src/features/patient_files/presentation/presentation/controllers/patient_file_table_controller.dart';
import 'package:gym_system/src/features/patient_files/presentation/presentation/widgets/patient_file_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientFilesPage extends HookConsumerWidget {
  const PatientFilesPage({
    super.key,
    required this.patientId,
    this.showAppBar = true,
  });
  final String patientId;
  final bool showAppBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = TableControllerKeys.patientFilePatient(patientId);
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider =
        patientFileTableControllerProvider(tableKey, patientId: patientId);
    final listState = ref.watch(listProvider);

    final isLoading = useState(false);

    onShowActions(PatientFile patientFile) {}

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(patientFileTableControllerProvider);
      ref.invalidate(provider);
      notifier.clearSelection();
    }

    ///
    /// onDelete
    ///
    onDelete(List<PatientFile> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(patientFileRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          notifier.clearSelection();
          ref.invalidate(patientFileTableControllerProvider);
          AppSnackBar.root(message: 'Successfully Deleted');
          if (context.canPop()) context.pop();
        },
      );
    }

    onTap(PatientFile file) {}

    ///
    /// OnCreate
    ///
    onCreate() {
      PatientFileFormPageRoute(parentId: patientId).push(context);
    }

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              leading: SizedBox(),
              centerTitle: false,
              title: Text('PatientFiles'),
              actions: [
                RefreshButton(onPressed: onRefresh),
              ],
            )
          : null,
      body: StackLoader(
        opacity: .8,
        isLoading: isLoading.value,
        child: DynamicTableView<PatientFile>(
          tableKey: TableControllerKeys.patientFile,
          error: FailureMessage.asyncValue(listState),
          isLoading: listState.isLoading,
          items: listState.valueOrNull ?? [],
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
              header: 'File',
              width: 200,
              alignment: Alignment.centerLeft,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    data.file.toString(),
                  ),
                );
              },
            ),
            TableColumn(
              header: 'Created',
              width: 200,
              alignment: Alignment.centerLeft,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    (data.created?.fullReadable).optional(),
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
          mobileBuilder: (context, index, patientFile, selected) {
            return PatientFileCard(
              patientFile: patientFile,
              onTap: () {
                if (selected)
                  notifier.toggleRow(index);
                else
                  onTap(patientFile);
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
