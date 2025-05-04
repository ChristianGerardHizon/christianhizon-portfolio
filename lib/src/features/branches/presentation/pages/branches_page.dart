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
import 'package:gym_system/src/features/branches/data/branch_repository.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';
import 'package:gym_system/src/features/branches/presentation/controllers/branch_table_controller.dart';
import 'package:gym_system/src/features/branches/presentation/widget/branch_card.dart';
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
          if (context.canPop()) context.pop();
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
        title: Text('Branchs'),
        actions: [
          RefreshButton(
            onPressed: onRefresh,
          ),
        ],
      ),
      body: DynamicTableView<Branch>(
        tableKey: TableControllerKeys.branch,
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
          TableColumn(
            header: 'Branch',
            alignment: Alignment.centerLeft,
            builder: (context, branch, row, column) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text((branch.name).optional(),
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
