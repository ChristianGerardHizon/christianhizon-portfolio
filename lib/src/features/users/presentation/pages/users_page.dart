import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/responsive_pagination_list_with_delete_view.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/sliver_dynamic_base_list.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/update/table_column.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/features/users/data/user_repository.dart';
import 'package:gym_system/src/features/users/domain/user.dart';
import 'package:gym_system/src/features/users/domain/user_search.dart';
import 'package:gym_system/src/features/users/presentation/controllers/users_controller.dart';
import 'package:gym_system/src/features/users/presentation/controllers/users_page_controller.dart';
import 'package:gym_system/src/features/users/presentation/widgets/user_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UsersPage extends HookConsumerWidget {
  const UsersPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useMemoized(() => DynamicTableController());
    final searchCtrl = useTextEditingController();
    final notifier = ref.read(usersPageControllerProvider.notifier);
    final provider = ref.watch(usersControllerProvider);
    final searchNotifier = ref.read(userSearchControllerProvider.notifier);
    final isLoading = useState(false);

    ///
    /// onTap
    ///
    onTap(int index, User user, bool selected) {
      if (!selected && controller.selected.isNotEmpty) {
        controller.toggle(index);
        return;
      }
      if (selected) {
        controller.toggle(index);
        return;
      }
      UserPageRoute(user.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(usersControllerProvider);
      controller.clear();
    }

    ///
    /// onDelete
    ///
    onDelete(List<User> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(userRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          controller.clear();
          ref.invalidate(usersControllerProvider);
          AppSnackBar.root(message: 'Successfully Deleted');
          if (context.canPop()) context.pop();
        },
      );
    }

    bool buildIsLoading() {
      if (isLoading.value) return true;
      return provider.maybeWhen(
        skipError: true,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        loading: () => true,
        orElse: () => false,
      );
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      UserFormPageRoute().push(context);
    }

    ///
    /// onSearch
    ///
    onSearch() {
      final query = searchCtrl.text.trim();
      searchNotifier.updateParams(UserSearch(name: query));
    }

    ///
    /// Handle Clear
    ///
    onClear() {
      searchCtrl.clear();
      searchNotifier.updateParams(UserSearch(name: ''));
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
      body:

          ///
          /// Table
          ///
          ResponsivePaginationListWithDeleteView<User>(
        controller: controller,
        onPageChange: notifier.changePage,
        error: provider.maybeWhen(
          skipError: false,
          skipLoadingOnRefresh: true,
          skipLoadingOnReload: true,
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          orElse: () => null,
        ),
        isLoading: buildIsLoading(),
        results: provider.when(
          skipError: true,
          skipLoadingOnRefresh: false,
          skipLoadingOnReload: false,
          data: (x) => x,
          error: (error, stackTrace) => null,
          loading: () => null,
        ),
        onDelete: onDelete,

        ///
        /// Search Features
        ///
        searchCtrl: searchCtrl,
        onClear: onClear,
        onCreate: onCreate,
        onSearch: onSearch,

        ///
        /// Table Data
        ///
        onHeaderTap: (headerKey) {},
        onTap: (x) => onTap(0, x, false),
        data: [
          TableColumn(
            header: 'Name',
            width: 200,
            alignment: Alignment.centerLeft,
            builder: (context, data, row, column) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  '${data.name}',
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
            onTap: () => onTap(index, user, selected),
            selected: selected,
            onLongPress: () {
              controller.toggle(index);
            },
          );
        },
      ),
    );
  }
}
