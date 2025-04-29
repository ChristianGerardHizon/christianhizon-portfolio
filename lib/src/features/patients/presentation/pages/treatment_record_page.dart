import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/card_group.dart';
import 'package:gym_system/src/core/widgets/collapsing_card.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_list_tile.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients/patient_table_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/record/patient_record_page_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/record/patient_records_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/treatment_record/patient_treatment_record_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/treatment_record/patient_treatment_records_controller.dart';
import 'package:gym_system/src/features/patients/data/treatment_record/patient_treatment_record_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient_treatment_record.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientTreatmentRecordPage extends HookConsumerWidget {
  const PatientTreatmentRecordPage(this.id, {super.key, this.page});

  final String id;
  final int? page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = patientTreatmentRecordControllerProvider(id);
    final state = ref.watch(provider);
    // final patientTreatmentRecord = useState<PatientTreatmentRecord?>(null);

    /// for medical records tab. preloading the data
    ref.watch(patientRecordsPageControllerProvider);
    ref.watch(patientRecordSearchControllerProvider.notifier);
    ref.watch(patientRecordsControllerProvider(id: id));

    ///
    /// onDelete
    ///
    onDelete(PatientTreatmentRecord patientTreatmentRecord) async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(treatmentRecordRepositoryProvider);
      repo.softDeleteMulti([patientTreatmentRecord.id]).run().then((result) {
            result.fold(
              (l) => AppSnackBar.rootFailure(l),
              (r) {
                ref.invalidate(patientTableControllerProvider);
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
      ref.invalidate(patientTreatmentRecordsControllerProvider);
    }

    return Scaffold(
      body: state.when(
        skipError: false,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (patientTreatmentRecord) {
          return CustomScrollView(
            slivers: [
              ///
              /// AppBar
              ///
              SliverAppBar(
                title: Text('PatientTreatment Details'),
              ),

              ///
              /// Content
              ///
              SliverList.list(
                children: [
                  SizedBox(height: 20),

                  ///
                  /// PatientTreatmentRecord General Info
                  ///
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      child: CollapsingCard(
                        header: Text(
                          'PatientTreatmentRecord Info',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        child: Column(
                          children: [
                            ///
                            /// name
                            ///
                            DynamicListTile.divider(
                              title: Text('Date: '),
                              content: Text(
                                  (patientTreatmentRecord.date?.yyyyMMdd())
                                      .optional()),
                            ),

                            ///
                            /// name
                            ///
                            DynamicListTile(
                              title: Text('Notes: '),
                              content:
                                  Text(patientTreatmentRecord.notes.optional()),
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
                              content: Text((patientTreatmentRecord.created
                                      ?.toLocal()
                                      .yyyyMMddHHmmA())
                                  .optional()),
                            ),
                            Divider(),
                            DynamicListTile(
                              title: Text('Updated At: '),
                              content: Text((patientTreatmentRecord.updated
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
                          title: const Text(
                              'Edit PatientTreatmentRecord Information'),
                          trailing: const Icon(
                            Icons.chevron_right_outlined,
                            size: 24,
                          ),
                          // onTap: () =>
                          //     PatientTreatmentRecordUpdatePageRoute(patientTreatmentRecord.id)
                          //         .push(context),
                        ),
                        ListTile(
                          leading: const Icon(Icons.delete_outlined),
                          title: const Text(
                              'Delete PatientTreatment Record Permanently'),
                          trailing: const Icon(
                            Icons.chevron_right_outlined,
                            size: 24,
                          ),
                          onTap: () => onDelete(patientTreatmentRecord),
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
