import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sannjosevet/src/core/extensions/date_time_extension.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/core/routing/router.dart';
import 'package:sannjosevet/src/core/strings/table_controller_keys.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/modals/confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/sliver_dynamic_table_view.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/dynamic_table_column.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:sannjosevet/src/core/widgets/failure_message.dart';
import 'package:sannjosevet/src/core/widgets/refresh_button.dart';
import 'package:sannjosevet/src/features/branches/data/branch_repository.dart';
import 'package:sannjosevet/src/features/branches/domain/branch.dart';
import 'package:sannjosevet/src/features/branches/presentation/controllers/branch_table_controller.dart';
import 'package:sannjosevet/src/features/branches/presentation/widgets/branch_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BranchesPage extends HookConsumerWidget {
  const BranchesPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = TableControllerKeys.branch;
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = branchTableControllerProvider(tableKey);
    final listState = ref.watch(listProvider);

    ///
    /// onTap
    ///
    onTap(Branch branch) {
      BranchPageRoute(branch.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(branchTableControllerProvider);
      ref.invalidate(provider);
      notifier.clearSelection();
    }

    ///
    /// onDelete
    ///
    onDelete(List<Branch> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(branchRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          notifier.clearSelection();
          ref.invalidate(branchTableControllerProvider);
          AppSnackBar.root(message: 'Successfully Deleted');
        },
      );
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      BranchFormPageRoute().push(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Branches'),
        actions: [
          RefreshButton(
            onPressed: onRefresh,
          ),
        ],
      ),
      body: SliverDynamicTableView<Branch>(
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
            header: 'Created',
            width: 180,
            alignment: Alignment.centerLeft,
            builder: (context, branch, row, column) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text((branch.created?.fullDateTime).optional(),
                    overflow: TextOverflow.ellipsis),
              );
            },
          ),
        ],

        ///
        /// Builder for mobile
        ///
        mobileBuilder: (context, index, branch, selected) {
          return BranchCard(
            branch: branch,
            onTap: () {
              if (selected)
                notifier.toggleRow(index);
              else
                onTap(branch);
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
