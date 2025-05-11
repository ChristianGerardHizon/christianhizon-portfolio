import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/card_group.dart';
import 'package:gym_system/src/core/widgets/collapsing_card.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:gym_system/src/core/widgets/modals/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_list_tile.dart';
import 'package:gym_system/src/features/patient_species/data/patient_species_repository.dart';
import 'package:gym_system/src/features/patient_species/domain/patient_species.dart';
import 'package:gym_system/src/features/patient_species/presentation/controllers/patient_species_controller.dart';
import 'package:gym_system/src/features/patient_species/presentation/controllers/patient_species_table_controller.dart';
import 'package:gym_system/src/features/product_stocks/data/product_stock_repository.dart';
import 'package:gym_system/src/features/product_stocks/domain/product_stock.dart';
import 'package:gym_system/src/features/product_stocks/presentation/controllers/product_stock_controller.dart';
import 'package:gym_system/src/features/product_stocks/presentation/controllers/product_stock_table_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientSpeciesDetailsView extends HookConsumerWidget {
  const PatientSpeciesDetailsView(this.species, {super.key});

  final PatientSpecies species;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    /// onDelete
    ///
    onDelete(PatientSpecies stock) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(patientSpeciesRepositoryProvider);
      repo.softDeleteMulti([stock.id]).run().then((result) {
            result.fold(
              (l) => AppSnackBar.rootFailure(l),
              (r) {
                ref.invalidate(patientSpeciesTableControllerProvider);
                AppSnackBar.root(message: 'Successfully Deleted');
                if (context.canPop()) context.pop();
              },
            );
          });
    }

    onEdit(PatientSpecies species) {
      PatientSpeciesFormPageRoute(
        id: species.id,
      ).push(context);
    }

    return CustomScrollView(
      slivers: [
        ///
        /// Content
        ///
        SliverList.list(
          children: [
            SizedBox(height: 20),

            ///
            /// Product General Info
            ///
            DynamicGroup(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
              header: 'Information',
              items: [
                DynamicGroupItem.text(
                  title: 'Name',
                  value: species.name,
                ),
              ],
            ),

            DynamicGroup(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
              header: 'Actions',
              items: [
                DynamicGroupItem.action(
                  onTap: () => onEdit(species),
                  leading: Icon(MIcons.fileEditOutline),
                  title: 'Edit Details',
                  trailing: Icon(MIcons.chevronRight),
                ),
                DynamicGroupItem.action(
                  titleColor: Theme.of(context).colorScheme.error,
                  onTap: () => onDelete(species),
                  leading: Icon(
                    MIcons.trashCan,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  title: 'Delete',
                  trailing: Icon(MIcons.chevronRight),
                ),
              ],
            ),

            ///
            /// Spacer
            ///
            SizedBox(height: 50),
          ],
        )
      ],
    );
    ;
  }
}
