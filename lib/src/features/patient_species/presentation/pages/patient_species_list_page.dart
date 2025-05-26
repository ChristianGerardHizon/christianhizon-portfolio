import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sannjosevet/src/core/routing/router.dart';
import 'package:sannjosevet/src/core/strings/table_controller_keys.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/modals/confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/sliver_dynamic_table_view.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/dynamic_table_column.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:sannjosevet/src/core/widgets/failure_message.dart';
import 'package:sannjosevet/src/core/widgets/refresh_button.dart';
import 'package:sannjosevet/src/core/widgets/stack_loader.dart';
import 'package:sannjosevet/src/features/patient_species/data/patient_species_repository.dart';
import 'package:sannjosevet/src/features/patient_species/domain/patient_species.dart';
import 'package:sannjosevet/src/features/patient_species/presentation/controllers/patient_species_table_controller.dart';
import 'package:sannjosevet/src/features/patient_species/presentation/widgets/patient_species_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientSpeciesListPage extends HookConsumerWidget {
  const PatientSpeciesListPage({
    super.key,
    this.showAppBar = true,
  });
  final bool showAppBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = TableControllerKeys.patientSpecies;
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = patientSpeciesTableControllerProvider(
      tableKey,
    );
    final listState = ref.watch(listProvider);

    final isLoading = useState(false);

    ///
    /// onTap
    ///
    onTap(PatientSpecies patientSpecies) {
      PatientSpeciesPageRoute(patientSpecies.id).push(context);
    }

    ///
    /// onEdit
    ///
    // onEdit(PatientSpecies patientSpecies) {
    //   PatientSpeciesFormPageRoute(
    //     id: patientSpecies.id,
    //   ).push(context);
    // }

    onShowActions(PatientSpecies patientSpecies) {
      // PatientSpeciesFormPageRoute(
      //   id: patientSpecies.id,
      // ).push(context);
    }

    ///
    /// onRefresh
    ///
    refresh() {
      ref.invalidate(patientSpeciesTableControllerProvider);
      ref.invalidate(provider);
      notifier.clearSelection();
    }

    ///
    /// onDelete
    ///
    onDelete(List<PatientSpecies> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(patientSpeciesRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          notifier.clearSelection();
          ref.invalidate(patientSpeciesTableControllerProvider);
          AppSnackBar.root(message: 'Successfully Deleted');
        },
      );
    }

    ///
    /// OnCreate
    ///
    onCreate() async {
      /// redirect
      final result = await PatientSpeciesFormPageRoute().push(context);
      if (result != null) refresh();
    }

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              centerTitle: false,
              title: Text('Patient Species'),
              actions: [
                RefreshButton(onPressed: refresh),
              ],
            )
          : null,
      body: StackLoader(
        opacity: .8,
        isLoading: isLoading.value,
        child: SliverDynamicTableView<PatientSpecies>(
          tableKey: tableKey,
          error: FailureMessage.asyncValue(listState),
          isLoading: listState.isLoading,
          items: listState.valueOrNull ?? [],
          onDelete: onDelete,
          onRowTap: onTap,

          ///
          /// Search Features
          ///
          searchCtrl: searchCtrl,
          onCreate: onCreate,

          ///
          /// Table Data
          ///
          columns: [
            DynamicTableColumn(
              header: 'Name',
              width: 200,
              alignment: Alignment.centerLeft,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    data.name,
                  ),
                );
              },
            ),
            DynamicTableColumn(
              header: 'Actions',
              width: 75,
              alignment: Alignment.center,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    tooltip: 'Show more actions',
                    onPressed: () => onShowActions(data),
                    icon: Icon(MIcons.dotsHorizontal),
                  ),
                );
              },
            ),
          ],

          ///
          /// Builder for mobile
          ///
          mobileBuilder: (context, index, patientSpecies, selected) {
            return PatientSpeciesCard(
              patientSpecies: patientSpecies,
              onTap: () {
                if (selected)
                  notifier.toggleRow(index);
                else
                  onTap(patientSpecies);
              },
              selected: selected,
              onLongPress: () {
                notifier.toggleRow(index);
              },
            );
          },
        ),
      ),
    );
  }
}
