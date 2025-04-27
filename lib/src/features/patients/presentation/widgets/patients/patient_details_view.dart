import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/circle_widget.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/pb_image_circle.dart';
import 'package:gym_system/src/core/widgets/stack_loader.dart';
import 'package:gym_system/src/features/patients/data/patient/patient_repository.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients/patient_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients/patient_table_controller.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientDetailsView extends HookConsumerWidget {
  const PatientDetailsView(this.patient, {super.key});

  final Patient patient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    /// loading variable
    ///
    final isLoading = useState(false);

    ///
    /// repo
    ///
    final repo = ref.read(patientRepositoryProvider);

    ///
    /// refresh
    ///
    refresh(String id) {
      ref.invalidate(patientTableControllerProvider);
      ref.invalidate(patientControllerProvider(id));
    }

    ///
    /// on tap
    ///
    tap(Patient patient) {
      PatientFormPageRoute(id: patient.id).push(context);
    }

    ///
    /// onDelete
    ///
    onDelete(Patient patient) async {
      final fullTask = await
          // 1. Call Confirm Modal
          ConfirmModal.taskResult(context)
              // 2. Delete Network Call
              .flatMap((_) => repo.softDeleteMulti([patient.id]))
              // 3. Side effects
              .flatMap(
                (_) => _handleSuccessfulDeleteTaskSidEffects(
                  context: context,
                  patientId: patient.id,
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

    return StackLoader(
      isLoading: isLoading.value,
      child: CustomScrollView(
        slivers: [
          ///
          /// Image
          ///
          SliverPadding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            sliver: SliverToBoxAdapter(
              child: CircleWidget(
                size: 250,
                child: PbImageCircle(
                  radius: 120,
                  collection: patient.collectionId,
                  recordId: patient.id,
                  file: patient.avatar,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          ///
          /// Content
          ///
          SliverList.list(
            children: [
              SizedBox(height: 20),

              ///
              /// Information
              ///
              DynamicGroup(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
                header: 'Patient Information',
                items: [
                  DynamicGroupItem.text(
                    title: 'Name',
                    value: patient.name,
                  ),
                  DynamicGroupItem.text(
                    title: 'Last Updated',
                    value: (patient.updated?.toLocal().fullReadable).optional(),
                  ),
                  DynamicGroupItem.text(
                    title: 'Created',
                    value: (patient.created?.toLocal().fullReadable).optional(),
                  ),
                ],
              ),

              ///
              /// Owner Information
              ///
              DynamicGroup(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
                header: 'Owner Information',
                items: [
                  DynamicGroupItem.text(
                    title: 'Name',
                    value: patient.owner.optional(),
                  ),
                  DynamicGroupItem.text(
                    title: 'Address',
                    value: patient.address.optional(),
                  ),
                  DynamicGroupItem.text(
                    title: 'Email',
                    value: patient.email.optional(),
                  ),
                  DynamicGroupItem.text(
                    title: 'Contact Number',
                    value: patient.contactNumber.optional(),
                  ),
                ],
              ),

              ///
              /// Actions
              ///
              DynamicGroup(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
                header: 'Actions',
                items: [
                  DynamicGroupItem.action(
                    onTap: () => tap(patient),
                    leading: Icon(MIcons.fileEditOutline),
                    title: 'Edit Details',
                    trailing: Icon(MIcons.chevronRight),
                  ),
                  DynamicGroupItem.action(
                    titleColor: Theme.of(context).colorScheme.error,
                    onTap: () => onDelete(patient),
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
  }
}

///
/// Handles post-delete side effects like showing snackbar,
/// popping navigation, and refreshing local state.
///
TaskResult<void> _handleSuccessfulDeleteTaskSidEffects({
  required BuildContext context,
  required String patientId,
  required void Function(String id) refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Successfully Deleted');
    if (context.canPop()) context.pop();
    refresh(patientId);
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
