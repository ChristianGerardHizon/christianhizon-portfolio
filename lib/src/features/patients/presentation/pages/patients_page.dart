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
import 'package:gym_system/src/features/patients/data/patient/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patients/domain/patient_search.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients/patients_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients/patients_page_controller.dart';
import 'package:gym_system/src/features/patients/presentation/widgets/patients/patient_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientsPage extends HookConsumerWidget {
  const PatientsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useMemoized(() => DynamicTableController());
    final searchCtrl = useTextEditingController();
    final notifier = ref.read(patientsPageControllerProvider.notifier);
    final provider = ref.watch(patientsControllerProvider);
    final searchNotifier = ref.read(patientSearchControllerProvider.notifier);
    final isLoading = useState(false);

    ///
    /// onTap
    ///
    onTap(int index, Patient patient, bool selected) {
      if (!selected && controller.selected.isNotEmpty) {
        controller.toggle(index);
        return;
      }
      if (selected) {
        controller.toggle(index);
        return;
      }
      PatientPageRoute(patient.id).push(context);
    }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(patientsControllerProvider);
      controller.clear();
    }

    ///
    /// onDelete
    ///
    onDelete(List<Patient> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(patientRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          controller.clear();
          ref.invalidate(patientsControllerProvider);
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
      PatientFormPageRoute().push(context);
    }

    ///
    /// onSearch
    ///
    onSearch() {
      final query = searchCtrl.text.trim();
      searchNotifier.updateParams(PatientSearch(name: query));
    }

    ///
    /// Handle Clear
    ///
    onClear() {
      searchCtrl.clear();
      searchNotifier.updateParams(PatientSearch(name: ''));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
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
          ResponsivePaginationListWithDeleteView<Patient>(
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
            header: 'Branch',
            alignment: Alignment.centerLeft,
            builder: (context, patient, row, column) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text((patient.expand.branch?.name).optional(),
                    overflow: TextOverflow.ellipsis),
              );
            },
          ),
          TableColumn(
            header: 'Date Created',
            alignment: Alignment.centerLeft,
            width: 150,
            builder: (context, patient, row, column) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text((patient.created?.yyyyMMddHHmmA()).optional(),
                    overflow: TextOverflow.ellipsis),
              );
            },
          ),
          // TableColumn(
          //   header: 'Actions',
          //   alignment: Alignment.centerLeft,
          //   width: 150,
          //   builder: (context, patient, row, column) {
          //     return Align(
          //       alignment: Alignment.centerLeft,
          //       child: TextButton(onPressed: () {}, child: Text('Add Stock')),
          //     );
          //   },
          // ),
        ],

        ///
        /// Builder for mobile
        ///
        mobileBuilder: (context, index, patient, selected) {
          return PatientCard(
            patient: patient,
            onTap: () => onTap(index, patient, selected),
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
