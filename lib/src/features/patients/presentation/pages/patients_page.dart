import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/page_selector.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients_page_controller.dart';
import 'package:gym_system/src/features/patients/presentation/widgets/patients_table.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientsPage extends HookConsumerWidget {
  const PatientsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageState = ref.watch(patientsPageControllerProvider);
    final state = ref.watch(patientsControllerProvider);
    final selected = useState<List<int>>([]);
    final searchCtrl = useTextEditingController();

    final hasNext = useState(false);

    useEffect(() {
      ref.listen(patientsControllerProvider, (prev, next) {
        final value = next.value;
        if (value != null) {
          hasNext.value = value.items.length == value.perPage;
        }
      });

      return null;
    }, [pageState]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(patientsControllerProvider),
          ),
          IconButton(
            icon: Icon(MIcons.plusCircle),
            onPressed: () => PatientCreatePageRoute().go(context),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                onSubmitted: (x) {
                  searchCtrl.clear();
                },
                controller: searchCtrl,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FilledButton(
                        child: Text('Search'),
                        onPressed: () {},
                      ),
                      SizedBox(width: 14),
                      TextButton(
                        child: Text('Clear'),
                        onPressed: () {
                          searchCtrl.clear();
                        },
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                  hintText: 'Search term here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).primaryColor.withOpacity(.1),
                  filled: true,
                ),
              ),
            ),
          ),

          ///
          /// list
          ///
          state.maybeWhen(
            skipError: false,
            skipLoadingOnRefresh: false,
            skipLoadingOnReload: false,
            orElse: () => SliverToBoxAdapter(),
            data: (data) {
              final list = data.items;

              if (list.isEmpty) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                    child: Center(
                      child: Text('No patients found'),
                    ),
                  ),
                );
              }
              return PatientsTable(
                list: list,
                selected: selected.value,
                onSelected: (p0) => selected.value = p0,
                onRowTap: (row) => PatientPageRoute(list[row].id).go(context),
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
                  ref
                      .read(patientsPageControllerProvider.notifier)
                      .changePage(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
