import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/page_actions.dart';
import 'package:gym_system/src/core/widgets/page_selector.dart';
import 'package:gym_system/src/core/widgets/pdf_generator.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/core/widgets/text_search_bar.dart';
import 'package:gym_system/src/features/medical_records/domain/medical_record.dart';
import 'package:gym_system/src/features/prescription/data/prescription_item_repository.dart';
import 'package:gym_system/src/features/prescription/domain/prescription_search.dart';
import 'package:gym_system/src/features/prescription/presentation/controllers/prescription_item_page_controller.dart';
import 'package:gym_system/src/features/prescription/presentation/controllers/prescription_items_controller.dart';
import 'package:gym_system/src/features/prescription/presentation/sheets/prescription_item_create_sheet.dart';
import 'package:gym_system/src/features/prescription/presentation/widgets/prescription_items_table.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PrescriptionItemsView extends HookConsumerWidget {
  final MedicalRecord record;
  const PrescriptionItemsView({super.key, required this.record});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final pageState = ref.watch(prescriptionItemsPageControllerProvider);
    final searchNotif =
        ref.read(prescriptionItemSearchControllerProvider.notifier);
    final provider = prescriptionItemsControllerProvider(id: record.id);
    final state = ref.watch(provider);
    final selected = useState<List<int>>([]);
    final searchCtrl = useTextEditingController();

    final hasNext = useState(false);

    ///
    /// on start
    ///
    useEffect(() {
      ref.listen(provider, (prev, next) {
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
      final repo = ref.read(prescriptionItemRepositoryProvider);
      final ids = selected.value.map((e) => state.value!.items[e].id).toList();
      repo.softDeleteMulti(ids).run().then((result) {
        result.fold(
          (l) => AppSnackBar.rootFailure(l),
          (r) {
            selected.value = [];
            ref.invalidate(provider);
            AppSnackBar.root(message: 'Successfully Deleted');
            // if (context.canPop()) context.pop();
          },
        );
      });
    }

    ///
    /// Stack
    ///
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 20,
                  bottom: 8,
                ),
                child: Row(
                  children: [
                    Text(
                      'Prescriptions',
                      style: theme.textTheme.headlineSmall,
                    ),
                    RefreshButton(
                      onPressed: () => ref.invalidate(provider),
                    )
                  ],
                ),
              ),
            ),

            ///
            /// Serch Bar
            ///
            SliverToBoxAdapter(
              child: TextSearchBar(
                controller: searchCtrl,
                onClear: () {
                  searchCtrl.clear();
                  searchNotif.updateParams(
                    PrescriptionItemSearch.buildQuery(
                      searchCtrl.text,
                    ),
                  );
                },
                onSearch: () {
                  searchNotif.updateParams(
                    PrescriptionItemSearch.buildQuery(
                      searchCtrl.text,
                      includeDiagnosis: true,
                    ),
                  );
                },
                onCreate: () {
                  PrescriptionItemCreateSheet.show(
                    context,
                    record: record,
                  );
                },
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
                        child: Text('No Prescriptions found'),
                      ),
                    ),
                  );
                }
                return PrescriptionItemsTable(
                  list: list,
                  selected: selected.value,
                  onSelected: (p0) => selected.value = p0,
                  onRowTap: (row) async {
                    AppSnackBar.show(context, message: 'Successfully Printed');
                    await PdfGenerator.print();
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
                  hasNext: hasNext.value,
                  page: pageState.page,
                  onPageChange: (value) {
                    /// clear selected after
                    ///
                    selected.value = [];
                    ref
                        .read(prescriptionItemsPageControllerProvider.notifier)
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
    );
  }
}
