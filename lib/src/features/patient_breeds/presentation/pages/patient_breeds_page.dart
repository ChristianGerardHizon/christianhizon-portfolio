import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/strings/table_controller_keys.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/modals/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/dynamic_table_view.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_column.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/core/widgets/failure_message.dart';
import 'package:gym_system/src/core/widgets/popover_widget.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/core/widgets/stack_loader.dart';
import 'package:gym_system/src/features/patient_breeds/data/patient_breed_repository.dart';
import 'package:gym_system/src/features/patient_breeds/domain/patient_breed.dart';
import 'package:gym_system/src/features/patient_breeds/presentation/controllers/patient_breed_table_controller.dart';
import 'package:gym_system/src/features/patient_breeds/presentation/widgets/patient_breed_card.dart';
import 'package:gym_system/src/features/patient_species/domain/patient_species.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientBreedsPage extends HookConsumerWidget {
  const PatientBreedsPage({
    super.key,
    required this.species,
    this.showAppBar = true,
  });
  final PatientSpecies species;
  final bool showAppBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = TableControllerKeys.patientBreed;
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = patientBreedTableControllerProvider(
      tableKey,
      patientSpeciesId: species.id,
    );
    final listState = ref.watch(listProvider);

    final isLoading = useState(false);

    ///
    /// onTap
    ///
    onTap(PatientBreed patientBreed) {
      // PatientBreedPageRoute(patientBreed.id).push(context);
    }

    ///
    /// onEdit
    ///
    onEdit(PatientBreed patientBreed) {
      PatientBreedFormPageRoute(
        parentId: species.id,
        id: patientBreed.id,
      ).push(context);
    }

    onShowActions(PatientBreed patientBreed) {
      // PatientBreedFormPageRoute(
      //   id: patientBreed.id,
      // ).push(context);
    }

    ///
    ///
    ///
    // onFollowUp(PatientBreed patientBreed) {
    //   PatientBreedFormPageRoute(
    //     parentId: patientBreed.patient,
    //     id: patientBreed.id,
    //   ).push(context);
    // }

    ///
    /// onRefresh
    ///
    onRefresh() {
      ref.invalidate(listProvider);
      ref.invalidate(provider);
      notifier.clearSelection();
    }

    ///
    /// onDelete
    ///
    onDelete(List<PatientBreed> items) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(patientBreedRepositoryProvider);
      final ids = items.map((e) => e.id).toList();
      // isLoading.value = true;
      final result = await repo.softDeleteMulti(ids).run();
      // if (context.mounted) isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          notifier.clearSelection();
          ref.invalidate(listProvider);
          AppSnackBar.root(message: 'Successfully Deleted');
        },
      );
    }

    ///
    /// OnCreate
    ///
    onCreate() {
      /// redirect
      PatientBreedFormPageRoute(parentId: species.id).push(context);
    }

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              centerTitle: false,
              title: Text('PatientBreeds'),
              actions: [
                RefreshButton(onPressed: onRefresh),
              ],
            )
          : null,
      body: StackLoader(
        opacity: .8,
        isLoading: isLoading.value,
        child: DynamicTableView<PatientBreed>(
          tableKey: TableControllerKeys.patientBreed,
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
            TableColumn(
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
            TableColumn(
              header: 'Actions',
              width: 159,
              alignment: Alignment.center,
              builder: (context, data, row, column) {
                return Align(
                  alignment: Alignment.center,
                  child: PopoverWidget.icon(
                    icon: Icon(MIcons.dotsHorizontal),
                    bottomSheetHeader: const Text('Action'),
                    items: [
                      PopoverMenuItemData(
                        name: 'Edit',
                        onTap: () {
                          onEdit(data);
                        },
                      ),
                      PopoverMenuItemData(
                        name: 'Delete',
                        onTap: () {
                          onDelete([data]);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],

          ///
          /// Builder for mobile
          ///
          mobileBuilder: (context, index, patientBreed, selected) {
            return PatientBreedCard(
              patientBreed: patientBreed,
              onTap: () {
                if (selected)
                  notifier.toggleRow(index);
                else
                  onTap(patientBreed);
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
