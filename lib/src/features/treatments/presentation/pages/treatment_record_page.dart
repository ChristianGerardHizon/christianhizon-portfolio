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
import 'package:gym_system/src/features/treatments/data/treatment_record/treatment_record_repository.dart';
import 'package:gym_system/src/features/treatments/domain/treatment_record.dart';
import 'package:gym_system/src/features/treatments/presentation/controllers/treatment_record/treatment_record_controller.dart';
import 'package:gym_system/src/features/treatments/presentation/controllers/treatment_record/treatment_records_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TreatmentRecordPage extends HookConsumerWidget {
  const TreatmentRecordPage(this.id, {super.key, this.page});

  final String id;
  final int? page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = treatmentRecordControllerProvider(id);
    final state = ref.watch(provider);
    final treatmentRecord = useState<TreatmentRecord?>(null);

    /// for medical records tab. preloading the data
    ref.watch(medicalRecordsPageControllerProvider);
    ref.watch(medicalRecordSearchControllerProvider.notifier);
    ref.watch(medicalRecordsControllerProvider(id: id));

    ///
    /// onDelete
    ///
    onDelete(TreatmentRecord treatmentRecord) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(treatmentRecordRepositoryProvider);
      repo.softDeleteMulti([treatmentRecord.id]).run().then((result) {
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
      ref.invalidate(treatmentRecordsControllerProvider);
    }

    return Scaffold(
      body: state.when(
        skipError: false,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (treatmentRecord) {
          return CustomScrollView(
            slivers: [
              ///
              /// AppBar
              ///
              SliverAppBar(
                title: Text('Treatment Details'),
              ),

              ///
              /// Content
              ///
              SliverList.list(
                children: [
                  SizedBox(height: 20),

                  ///
                  /// TreatmentRecord General Info
                  ///
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      child: CollapsingCard(
                        header: Text(
                          'TreatmentRecord Info',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        child: Column(
                          children: [
                            ///
                            /// name
                            ///
                            DynamicListTile.divider(
                              title: Text('Date: '),
                              content: Text((treatmentRecord.date?.yyyyMMdd())
                                  .optional()),
                            ),

                            ///
                            /// name
                            ///
                            DynamicListTile(
                              title: Text('Notes: '),
                              content: Text(treatmentRecord.notes.optional()),
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
                              content: Text((treatmentRecord.created
                                      ?.toLocal()
                                      .yyyyMMddHHmmA())
                                  .optional()),
                            ),
                            Divider(),
                            DynamicListTile(
                              title: Text('Updated At: '),
                              content: Text((treatmentRecord.updated
                                      ?.toLocal()
                                      .yyyyMMddHHmmA())
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
                          title: const Text('Edit TreatmentRecord Information'),
                          trailing: const Icon(
                            Icons.chevron_right_outlined,
                            size: 24,
                          ),
                          // onTap: () =>
                          //     TreatmentRecordUpdatePageRoute(treatmentRecord.id)
                          //         .push(context),
                        ),
                        ListTile(
                          leading: const Icon(Icons.delete_outlined),
                          title:
                              const Text('Delete Treatment Record Permanently'),
                          trailing: const Icon(
                            Icons.chevron_right_outlined,
                            size: 24,
                          ),
                          onTap: () => onDelete(treatmentRecord),
                        ),
                      ],
                    ),
                  ),

                  ///
                  /// Spacer
                  ///
                  SizedBox(height: 50),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
