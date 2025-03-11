import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/page_actions.dart';
import 'package:gym_system/src/core/widgets/page_selector.dart';
import 'package:gym_system/src/core/widgets/text_search_bar.dart';
import 'package:gym_system/src/features/users/data/user_repository.dart';
import 'package:gym_system/src/features/users/presentation/controllers/user_search_controller.dart';
import 'package:gym_system/src/features/users/presentation/controllers/users_controller.dart';
import 'package:gym_system/src/features/users/presentation/controllers/users_page_controller.dart';
import 'package:gym_system/src/features/users/presentation/widgets/users_table.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UsersPage extends HookConsumerWidget {
  const UsersPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageState = ref.watch(usersPageControllerProvider);
    final searchNotif = ref.read(userSearchControllerProvider.notifier);
    final state = ref.watch(usersControllerProvider);
    final selected = useState<List<int>>([]);
    final searchCtrl = useTextEditingController();

    final hasNext = useState(false);

    ///
    /// on start
    ///
    useEffect(() {
      ref.listen(usersControllerProvider, (prev, next) {
        final value = next.value;
        if (value != null) {
          hasNext.value = value.items.length == value.perPage;
        }
      });

      return null;
    }, [pageState]);

    ///
    /// on Delete
    ///
    onDelete() async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(userRepositoryProvider);
      final ids = selected.value.map((e) => state.value!.items[e].id).toList();
      repo.softDeleteMulti(ids).run().then((result) {
        result.fold(
          (l) => AppSnackBar.rootFailure(l),
          (r) {
            selected.value = [];
            ref.invalidate(usersControllerProvider);
            AppSnackBar.root(message: 'Successfully Deleted');
            UsersPageRoute().go(context);
          },
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(usersControllerProvider),
          ),
        ],
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              ///
              /// Serch Bar
              ///
              SliverToBoxAdapter(
                child: TextSearchBar(
                  controller: searchCtrl,
                  onClear: () {
                    searchCtrl.clear();
                    searchNotif.change(searchCtrl.text);
                  },
                  onSearch: () {
                    searchNotif.change(searchCtrl.text);
                  },
                  onCreate: () => UserCreatePageRoute().push(context),
                ),
              ),

              ///
              /// list
              ///
              state.when(
                skipError: false,
                skipLoadingOnRefresh: false,
                skipLoadingOnReload: false,
                loading: () => SliverPadding(
                  padding: const EdgeInsets.all(20.0),
                  sliver: SliverToBoxAdapter(
                      child: Center(
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator()),
                  )),
                ),
                error: (error, stackTrace) => SliverToBoxAdapter(
                  child: Center(
                    child: Text(error.toString()),
                  ),
                ),
                data: (data) {
                  final list = data.items;

                  if (list.isEmpty) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 100,
                        child: Center(
                          child: Text('No users found'),
                        ),
                      ),
                    );
                  }
                  return UsersTable(
                    list: list,
                    selected: selected.value,
                    onSelected: (p0) => selected.value = p0,
                    onRowTap: (row) => UserPageRoute(list[row].id).go(context),
                  );
                },
              ),

              ///
              /// page
              ///
              SliverPadding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 20,
                  bottom: 8,
                ),
                sliver: SliverToBoxAdapter(
                  child: PageSelector(
                    hasNext: hasNext.value,
                    page: pageState.page,
                    onPageChange: (value) {
                      /// clear selected after
                      ///
                      selected.value = [];
                      ref
                          .read(usersPageControllerProvider.notifier)
                          .changePage(value);
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: selected.value.isNotEmpty
                  ? PageActions(
                      size: selected.value.length,
                      onDelete: () {
                        onDelete();
                      },
                      onReset: () {
                        selected.value = [];
                      },
                    )
                  : SizedBox(),
            ),
          )
        ],
      ),
    );
  }
}
