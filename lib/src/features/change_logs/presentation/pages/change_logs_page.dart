import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/strings/table_controller_keys.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/dynamic_table_view.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_column.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/core/widgets/failure_message.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/features/change_logs/data/change_log_repository.dart';
import 'package:gym_system/src/features/change_logs/domain/change_log.dart';
import 'package:gym_system/src/features/change_logs/presentation/controllers/change_log_table_controller.dart';
import 'package:gym_system/src/features/change_logs/presentation/widgets/change_log_card.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/breeds/patient_breeds_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/species/patient_species_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangeLogsPage extends HookConsumerWidget {
  const ChangeLogsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();

    final tableKey = TableControllerKeys.changeLog;
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = changeLogTableControllerProvider(tableKey);
    final listState = ref.watch(listProvider);

    ref.watch(patientBreedsControllerProvider);
    ref.watch(patientSpeciesControllerProvider);

    ///
    /// onTap
    ///
    onTap(ChangeLog changeLog) {
      ChangeLogPageRoute(changeLog.id).push(context);
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      ChangeLogFormPageRoute().push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(changeLogTableControllerProvider);
      ref.invalidate(provider);
      notifier.clearSelection();
    }

    ///
    /// onDelete
    ///
    onDelete(List<ChangeLog> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(changeLogRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          notifier.clearSelection();
          ref.invalidate(changeLogTableControllerProvider);
          AppSnackBar.root(message: 'Successfully Deleted');
          if (context.canPop()) context.pop();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('ChangeLogs'),
        actions: [
          RefreshButton(
            onPressed: onRefresh,
          ),
        ],
      ),
      body: DynamicTableView<ChangeLog>(
        tableKey: TableControllerKeys.changeLog,
        error: listState.maybeWhen(
          skipError: false,
          skipLoadingOnRefresh: true,
          skipLoadingOnReload: true,
          orElse: () => null,
          error: (error, stackTrace) => FailureMessage(error, stackTrace),
        ),
        items: listState.maybeWhen(
          skipError: true,
          skipLoadingOnRefresh: false,
          skipLoadingOnReload: true,
          data: (items) => items,
          orElse: () => [],
        ),
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
            header: 'Type',
            width: 200,
            alignment: Alignment.centerLeft,
            builder: (context, data, row, column) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  data.type.name,
                ),
              );
            },
          ),
          TableColumn(
            header: 'Message',
            width: 200,
            alignment: Alignment.centerLeft,
            builder: (context, data, row, column) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  data.message.optional(),
                ),
              );
            },
          ),
          TableColumn(
            header: 'User',
            width: 200,
            alignment: Alignment.centerLeft,
            builder: (context, data, row, column) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  data.message.optional(),
                ),
              );
            },
          ),
        ],

        ///
        /// Builder for mobile
        ///
        mobileBuilder: (context, index, changeLog, selected) {
          return ChangeLogCard(
            changeLog: changeLog,
            onTap: () {
              if (selected)
                notifier.toggleRow(index);
              else
                onTap(changeLog);
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
