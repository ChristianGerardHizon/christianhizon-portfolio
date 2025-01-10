import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/page_selector.dart';
import 'package:gym_system/src/features/pets/presentation/controllers/pets_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PetsPage extends HookConsumerWidget {
  const PetsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = useState(1);

    final state = ref.watch(petsControllerProvider(page.value));

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
              if (data.isEmpty) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: const Center(
                      child: Text('No data'),
                    ),
                  ),
                );
              }
              return SliverList.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => PetPageRoute(data[index].id).go(context),
                    title: Text(data[index].name),
                  );
                },
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
                page: page.value,
                onPageChange: (value) {
                  page.value = value;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
