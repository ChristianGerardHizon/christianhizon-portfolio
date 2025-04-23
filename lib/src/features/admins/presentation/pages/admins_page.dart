import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_list/responsive_pagination_list_with_delete_view.dart';
import 'package:gym_system/src/core/widgets/dynamic_list/sliver_dynamic_base_list.dart';
import 'package:gym_system/src/core/widgets/dynamic_list/table_column.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/features/admins/domain/admin.dart';
import 'package:gym_system/src/features/admins/presentation/widgets/admin_card.dart';
import 'package:gym_system/src/features/admins/data/admin_repository.dart';
import 'package:gym_system/src/features/admins/domain/admin.dart';
import 'package:gym_system/src/features/admins/domain/admin_search.dart';
import 'package:gym_system/src/features/admins/presentation/controllers/admins_controller.dart';
import 'package:gym_system/src/features/admins/presentation/controllers/admins_page_controller.dart';
import 'package:gym_system/src/features/admins/presentation/widgets/admin_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminsPage extends HookConsumerWidget {
  const AdminsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useMemoized(() => DynamicTableController());
    final searchCtrl = useTextEditingController();
    final notifier = ref.read(adminsPageControllerProvider.notifier);
    final provider = ref.watch(adminsControllerProvider);
    final searchNotifier = ref.read(adminSearchControllerProvider.notifier);
    final isLoading = useState(false);

    ///
    /// onTap
    ///
    onTap(int index, Admin admin, bool selected) {
      if (!selected && controller.selected.isNotEmpty) {
        controller.toggle(index);
        return;
      }
      if (selected) {
        controller.toggle(index);
        return;
      }
      AdminPageRoute(admin.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(adminsControllerProvider);
      controller.clear();
    }

    ///
    /// onDelete
    ///
    onDelete(List<Admin> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(adminRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          controller.clear();
          ref.invalidate(adminsControllerProvider);
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
      AdminFormPageRoute().push(context);
    }

    ///
    /// onSearch
    ///
    onSearch() {
      final query = searchCtrl.text.trim();
      searchNotifier.updateParams(AdminSearch(name: query));
    }

    ///
    /// Handle Clear
    ///
    onClear() {
      searchCtrl.clear();
      searchNotifier.updateParams(AdminSearch(name: ''));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Admins'),
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
          ResponsivePaginationListWithDeleteView<Admin>(
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
            builder: (context, data, extra) {
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
            builder: (context, admin, extra) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text((admin.created?.yyyyMMddHHmmA()).optional(),
                    overflow: TextOverflow.ellipsis),
              );
            },
          ),
        ],

        ///
        /// Builder for mobile
        ///
        mobileBuilder: (context, index, admin, selected) {
          return AdminCard(
            admin: admin,
            onTap: () => onTap(index, admin, selected),
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
