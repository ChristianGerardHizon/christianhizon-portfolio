import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/strings/table_controller_keys.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/dynamic_table_view.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_column.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/features/users/data/user_repository.dart';
import 'package:gym_system/src/features/users/domain/user.dart';
import 'package:gym_system/src/features/users/presentation/controllers/user_table_controller.dart';
import 'package:gym_system/src/features/users/presentation/widgets/user_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UsersPage extends HookConsumerWidget {
  const UsersPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = TableControllerKeys.user;
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = userTableControllerProvider(tableKey);
    final listState = ref.watch(listProvider);

    ///
    /// onTap
    ///
    onTap(User user) {
      UserPageRoute(user.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(userTableControllerProvider);
      ref.invalidate(provider);
      // controller.clear();
    }

    ///
    /// onDelete
    ///
    onDelete(List<User> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(userRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          // controller.clear();
          ref.invalidate(userTableControllerProvider);
          AppSnackBar.root(message: 'Successfully Deleted');
          if (context.canPop()) context.pop();
        },
      );
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      UserFormPageRoute().push(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          RefreshButton(
            onPressed: onRefresh,
          ),
        ],
      ),
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
        data: (items) => DynamicTableView<User>(
          tableKey: TableControllerKeys.user,
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
              header: 'Email',
              width: 200,
              alignment: Alignment.centerLeft,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    data.email,
                  ),
                );
              },
            ),
            TableColumn(
              header: 'Verfied',
              width: 100,
              alignment: Alignment.centerLeft,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    data.verified ? 'Yes' : 'No',
                  ),
                );
              },
            ),
            TableColumn(
              header: 'Date Created',
              alignment: Alignment.centerLeft,
              width: 150,
              builder: (context, user, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text((user.created?.yyyyMMddHHmmA()).optional(),
                      overflow: TextOverflow.ellipsis),
                );
              },
            ),
          ],

          ///
          /// Builder for mobile
          ///
          mobileBuilder: (context, index, user, selected) {
            return UserCard(
              user: user,
              onTap: () {
                if (selected)
                  notifier.toggleRow(index);
                else
                  onTap(user);
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
