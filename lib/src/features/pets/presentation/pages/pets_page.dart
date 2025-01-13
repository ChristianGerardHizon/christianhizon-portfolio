import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/page_selector.dart';
import 'package:gym_system/src/features/pets/presentation/controllers/pets_controller.dart';
import 'package:gym_system/src/features/pets/presentation/controllers/pets_page_controller.dart';
import 'package:gym_system/src/features/pets/presentation/widgets/pets_table.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PetsPage extends HookConsumerWidget {
  const PetsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageState = ref.watch(petsPageControllerProvider);
    final state = ref.watch(petsControllerProvider);
    final selected = useState<List<int>>([]);

    final hasNext = useState(false);

    useEffect(() {


      ref.listen(petsControllerProvider, (prev,next) {
        final value = next.value;
        if(value != null) {
          
          hasNext.value = value.items.length == value.perPage;
        }
      });

      return null;
    }, [pageState]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(petsControllerProvider),
          ),
          IconButton(
            icon: Icon(MIcons.plusCircle),
            onPressed: () => PetCreatePageRoute().go(context),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
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
              return PetsTable(
                list: list,
                selected: selected.value,
                onSelected: (p0) => selected.value = p0,
                onRowTap: (row) => PetPageRoute(data.items[row].id).go(context),
              );

              // return SliverList.builder(
              //   itemCount: data.items.length,
              //   itemBuilder: (context, index) {
              //     return ListTile(
              //       onTap: () => PetPageRoute(data.items[index].id).go(context),
              //       title: Text(data.items[index].name),
              //     );
              //   },
              // );
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
                      .read(petsPageControllerProvider.notifier)
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
