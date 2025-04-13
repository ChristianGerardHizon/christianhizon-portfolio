import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/page_actions.dart';
import 'package:gym_system/src/core/widgets/page_selector.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/core/widgets/text_search_bar.dart';
import 'package:gym_system/src/features/patient_records/data/patient_record_repository.dart';
import 'package:gym_system/src/features/patient_records/domain/patient_record_search.dart';
import 'package:gym_system/src/features/patient_records/presentation/controllers/patient_record_page_controller.dart';
import 'package:gym_system/src/features/patient_records/presentation/controllers/patient_records_controller.dart';
import 'package:gym_system/src/features/patient_records/presentation/sheets/patient_record_create_sheet.dart';
import 'package:gym_system/src/features/patient_records/presentation/widgets/patient_records_table.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientRecordsView extends HookConsumerWidget {
  final Patient patient;
  const PatientRecordsView({super.key, required this.patient});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final pageState = ref.watch(patientRecordsPageControllerProvider);
    final searchNotif =
        ref.read(patientRecordSearchControllerProvider.notifier);
    final provider = patientRecordsControllerProvider(id: patient.id);
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
      final repo = ref.read(patientRecordRepositoryProvider);
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
                      'Medical Records',
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
                    PatientRecordSearch.buildQuery(
                      searchCtrl.text,
                      includeDiagnosis: true,
                    ),
                  );
                },
                onSearch: () {
                  searchNotif.updateParams(
                    PatientRecordSearch.buildQuery(
                      searchCtrl.text,
                      includeDiagnosis: true,
                    ),
                  );
                },
                onCreate: () {
                  PatientRecordCreateSheet.show(context, patient: patient);
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
                        child: Text('No Medical Records found'),
                      ),
                    ),
                  );
                }
                return PatientRecordsTable(
                  list: list,
                  selected: selected.value,
                  onSelected: (p0) => selected.value = p0,
                  onRowTap: (row) => PatientPatientRecordPageRoute(
                    patientRecordId: list[row].id,
                  ).push(context),
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
                        .read(patientRecordsPageControllerProvider.notifier)
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
