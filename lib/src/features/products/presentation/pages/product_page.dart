import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/card_group.dart';
import 'package:gym_system/src/core/widgets/collapsing_card.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_list_tile.dart';
import 'package:gym_system/src/features/medical_records/presentation/controllers/medical_record_page_controller.dart';
import 'package:gym_system/src/features/medical_records/presentation/controllers/medical_records_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients_controller.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product_controller.dart';
import 'package:gym_system/src/features/treatments/domain/treatment.dart';
import 'package:gym_system/src/features/treatments/presentation/controllers/treatment/treatments_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductPage extends HookConsumerWidget {
  const ProductPage(this.id, {super.key, this.page});

  final String id;
  final int? page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = productControllerProvider(id);
    final state = ref.watch(provider);
    final treatment = useState<Treatment?>(null);

    /// for medical records tab. preloading the data
    ref.watch(medicalRecordsPageControllerProvider);
    ref.watch(medicalRecordSearchControllerProvider.notifier);
    ref.watch(medicalRecordsControllerProvider(id: id));

    ///
    /// onDelete
    ///
    onDelete(Product product) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(productRepositoryProvider);
      repo.softDeleteMulti([product.id]).run().then((result) {
            result.fold(
              (l) => AppSnackBar.rootFailure(l),
              (r) {
                ref.invalidate(patientsControllerProvider);
                AppSnackBar.root(message: 'Successfully Deleted');
                if (context.canPop()) context.pop();
              },
            );
          });
    }

    ///
    /// Refresh
    ///
    refresh() {
      ref.invalidate(provider);
      ref.invalidate(treatmentsControllerProvider);
    }

    return Scaffold(
      body: state.when(
        skipError: false,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (product) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                ///
                /// AppBar
                ///
                SliverAppBar(
                  title: Text(product.name),
                  actions: [
                    // IconButton(
                    //   icon: const Icon(Icons.edit),
                    //   onPressed: () =>
                    //       ProductUpdatePageRoute(id).go(context),
                    // ),
                    // IconButton(
                    //   icon: const Icon(Icons.delete),
                    //   onPressed: () => onDelete(),
                    // ),
                    // IconButton(
                    //   icon: const Icon(Icons.refresh),
                    //   onPressed: () => refresh(),
                    // )
                  ],
                ),

                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: PinnedHeaderSliver(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                      ),
                      child: TabBar(
                        isScrollable: false,
                        tabs: [
                          Tab(
                            icon: Icon(MIcons.accountOutline),
                            child: Text('Details'),
                          ),
                          Tab(
                            icon: Icon(MIcons.informationOutline),
                            child: Text('Records'),
                          ),
                          Tab(
                            icon: Icon(MIcons.hospitalBoxOutline),
                            child: Text('Treatments'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ];
            },
            body: ListView(
              children: [
                SizedBox(height: 20),

                ///
                /// Product General Info
                ///
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    child: CollapsingCard(
                      header: Text(
                        'Product Info',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      child: Column(
                        children: [
                          ///
                          /// name
                          ///
                          DynamicListTile.divider(
                            title: Text('Name: '),
                            content: Text(product.name),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                ///
                /// System Details
                ///
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    child: CollapsingCard(
                      header: Text(
                        'Other Info',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      child: Column(
                        children: [
                          DynamicListTile(
                            title: Text('Created At: '),
                            content: Text(
                                (product.created?.toLocal().yyyyMMddHHmmA())
                                    .optional()),
                          ),
                          Divider(),
                          DynamicListTile(
                            title: Text('Updated At: '),
                            content: Text(
                                (product.updated?.toLocal().yyyyMMddHHmmA())
                                    .optional()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CardGroup(
                    header: 'Actions',
                    children: [
                      ListTile(
                        leading: const Icon(Icons.edit_outlined),
                        title: const Text('Edit Product Information'),
                        trailing: const Icon(
                          Icons.chevron_right_outlined,
                          size: 24,
                        ),
                        onTap: () =>
                            ProductUpdatePageRoute(product.id).push(context),
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete_outlined),
                        title: const Text('Delete User Permanently'),
                        trailing: const Icon(
                          Icons.chevron_right_outlined,
                          size: 24,
                        ),
                        onTap: () => onDelete(product),
                      ),
                    ],
                  ),
                ),

                ///
                /// Spacer
                ///
                SizedBox(height: 50),
              ],
            ),
          );
        },
      ),
    );
  }
}
