import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/failure_message.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/core/widgets/stack_loader.dart';
import 'package:gym_system/src/features/patient_treament_records/data/patient_treatment_record_repository.dart';
import 'package:gym_system/src/features/patient_treament_records/domain/patient_treatment_record.dart';
import 'package:gym_system/src/features/patient_treament_records/presentation/controllers/patient_treatment_record_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientTreatmentRecordPage extends HookConsumerWidget {
  const PatientTreatmentRecordPage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    /// loading variable
    ///
    final isLoading = useState(false);

    ///
    /// repo
    ///
    final repo = ref.read(patientTreatmentRecordRepositoryProvider);

    ///
    /// refresh
    ///
    refresh(String id) {
      ref.invalidate(patientTreatmentRecordControllerProvider(id));
    }

    ///
    /// on tap
    ///
    tap(PatientTreatmentRecord patientTreatmentRecord) {
      PatientTreatmentRecordFormPageRoute(
              parentId: patientTreatmentRecord.patient,
              id: patientTreatmentRecord.id)
          .push(context);
    }

    ///
    /// onDelete
    ///
    onDelete(PatientTreatmentRecord patientTreatmentRecord) async {
      final fullTask = await
          // 1. Call Confirm Modal
          ConfirmModal.taskResult(context)
              // 2. Delete Network Call
              .flatMap((_) => repo.softDeleteMulti([patientTreatmentRecord.id]))
              // 3. Side effects
              .flatMap(
                (_) => _handleSuccessfulDeleteTaskSidEffects(
                  context: context,
                  patientTreatmentRecordId: patientTreatmentRecord.id,
                  refresh: refresh,
                ),
              );

      isLoading.value = true;
      final result = await fullTask.run();
      isLoading.value = false;

      // 4. Handle Error
      result.match(
        (failure) => _handleFailure(context, failure),
        (_) {},
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('PatientTreatmentRecord Details'),
        actions: [
          RefreshButton(
            onPressed: () => refresh(id),
          )
        ],
      ),
      body: ref.watch(patientTreatmentRecordControllerProvider(id)).when(
            error: (error, stack) => FailureMessage(error, stack),
            loading: () => Center(child: CircularProgressIndicator()),
            data: (patientTreatmentRecordState) {
              final patientTreatmentRecord =
                  patientTreatmentRecordState.patientTreatmentRecord;
              return StackLoader(
                isLoading: isLoading.value,
                child: CustomScrollView(
                  slivers: [
                    ///
                    /// Content
                    ///
                    SliverList.list(
                      children: [
                        SizedBox(height: 20),

                        ///
                        /// Diagnosis
                        ///
                        DynamicGroup(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 12),
                          header: 'Record Information',
                          items: [],
                        ),

                        ///
                        /// Actions
                        ///
                        DynamicGroup(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 12),
                          header: 'Actions',
                          items: [
                            DynamicGroupItem.action(
                              onTap: () => tap(patientTreatmentRecord),
                              leading: Icon(MIcons.fileEditOutline),
                              title: 'Edit Details',
                              trailing: Icon(MIcons.chevronRight),
                            ),
                            DynamicGroupItem.action(
                              titleColor: Theme.of(context).colorScheme.error,
                              onTap: () => onDelete(patientTreatmentRecord),
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
                ),
              );
            },
          ),
    );
  }
}

///
/// Handles post-delete side effects like showing snackbar,
/// popping navigation, and refreshing local state.
///
TaskResult<void> _handleSuccessfulDeleteTaskSidEffects({
  required BuildContext context,
  required String patientTreatmentRecordId,
  required void Function(String id) refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Successfully Deleted');
    if (context.canPop()) context.pop();
    refresh(patientTreatmentRecordId);
    return null;
  }).toTaskEither<Failure>();
}

///
/// Handles Failure
/// Shows a snackbar when a failure occurs
///
void _handleFailure(BuildContext context, Failure failure) {
  if (failure is CancelledFailure) return;
  AppSnackBar.rootFailure(failure);
}
