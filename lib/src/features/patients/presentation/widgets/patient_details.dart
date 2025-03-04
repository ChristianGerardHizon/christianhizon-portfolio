import 'package:flutter/material.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/widgets/collapsing_card.dart';
import 'package:gym_system/src/core/widgets/dynamic_list_tile.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

class PatientDetails extends HookConsumerWidget {
  final Patient patient;
  const PatientDetails({super.key, required this.patient});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
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
                  DynamicListTile(
                    title: Text('Name: '),
                    content: Text(patient.name),
                  ),
                  Divider(),

                  ///
                  /// Breed
                  ///
                  DynamicListTile(
                    title: Text('Breed: '),
                    content: Text(patient.breed.optional()),
                  ),
                  Divider(),

                  ///
                  /// Species
                  ///
                  DynamicListTile(
                    title: Text('Species: '),
                    content: Text(patient.species.optional()),
                  ),
                  Divider(),

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
                  SizedBox(height: 30),
                  DynamicListTile(
                    title: Text('Owner: '),
                    content: Text(patient.owner.optional()),
                  ),
                  Divider(),
                  DynamicListTile(
                    title: Text('Address: '),
                    content: Text(patient.address.optional()),
                  ),
                  Divider(),
                  DynamicListTile(
                    title: Text('Email: '),
                    content: Text(patient.email.optional()),
                  ),
                  Divider(),
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
                  SizedBox(height: 30),
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

        ///
        ///
        ///
      ],
    );
  }
}
