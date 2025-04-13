import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/card_group.dart';
import 'package:gym_system/src/core/widgets/circle_widget.dart';
import 'package:gym_system/src/core/widgets/collapsing_card.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_list_tile.dart';
import 'package:gym_system/src/core/widgets/pb_image_circle.dart';
import 'package:gym_system/src/features/patients/data/patient/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients/patients_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientDetails extends HookConsumerWidget {
  final Patient patient;
  const PatientDetails({super.key, required this.patient});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    /// onDelete
    ///
    onDelete() async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(patientRepositoryProvider);
      repo.softDeleteMulti([patient.id]).run().then((result) {
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

    return ListView(
      children: [
        SizedBox(height: 20),

        CircleWidget(
          size: 250,
          child: PbImageCircle(
            radius: 120,
            collection: patient.collectionId,
            recordId: patient.id,
            file: patient.avatar,
          ),
        ),

        SizedBox(height: 50),

        ///
        /// Patient General Info
        ///
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            child: CollapsingCard(
              header: Text(
                'Patient Info',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              child: Column(
                children: [
                  ///
                  /// name
                  ///
                  DynamicListTile.divider(
                    title: Text('Name: '),
                    content: Text(patient.name),
                  ),

                  ///
                  /// Breed
                  ///
                  DynamicListTile.divider(
                    title: Text('Breed: '),
                    content: Text(patient.breed.optional()),
                  ),

                  ///
                  /// Species
                  ///
                  DynamicListTile.divider(
                    title: Text('Species: '),
                    content: Text(patient.species.optional()),
                  ),

                  ///
                  /// date of birth
                  ///
                  DynamicListTile(
                    title: Text('Date of Birth: '),
                    content: Text(
                        (patient.dateOfBirth?.toLocal().yyyyMMdd()).optional()),
                  ),
                ],
              ),
            ),
          ),
        ),

        ///
        /// Owner Details
        ///
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            child: CollapsingCard(
              header: Text(
                'Owner Info',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              child: Column(
                children: [
                  DynamicListTile.divider(
                    title: Text('Owner: '),
                    content: Text(patient.owner.optional()),
                  ),
                  DynamicListTile.divider(
                    title: Text('Address: '),
                    content: Text(patient.address.optional()),
                  ),
                  DynamicListTile.divider(
                    title: Text('Email: '),
                    content: Text(patient.email.optional()),
                  ),
                  DynamicListTile(
                    title: Text('Contact Number: '),
                    content: Text(patient.contactNumber.optional()),
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
                    content: Text((patient.created?.toLocal().yyyyMMddHHmmA())
                        .optional()),
                  ),
                  Divider(),
                  DynamicListTile(
                    title: Text('Updated At: '),
                    content: Text((patient.updated?.toLocal().yyyyMMddHHmmA())
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
                title: const Text('Edit Patient Information'),
                trailing: const Icon(
                  Icons.chevron_right_outlined,
                  size: 24,
                ),
                onTap: () => PatientUpdatePageRoute(patient.id).push(context),
              ),
              ListTile(
                leading: Icon(
                  Icons.delete_outlined,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: Text(
                  'Delete Patient Record',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right_outlined,
                  size: 24,
                  color: Theme.of(context).colorScheme.error,
                ),
                onTap: onDelete,
              ),
            ],
          ),
        ),

        ///
        /// Spacer
        ///
        SizedBox(height: 50),
      ],
    );
  }
}
