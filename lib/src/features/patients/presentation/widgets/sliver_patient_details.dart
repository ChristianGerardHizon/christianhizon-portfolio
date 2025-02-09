import 'package:flutter/material.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patients/presentation/widgets/patient_circle_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverPatientDetails extends HookConsumerWidget {
  final Patient patient;
  const SliverPatientDetails({super.key, required this.patient});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MultiSliver(
      children: [
        ///
        /// Patient General Info
        ///
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          sliver: SliverList.list(children: [
            ///
            /// Header
            ///
            ListTile(
              contentPadding: EdgeInsets.only(left: 14),
              title: Text(
                'Patient Info',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            ///
            /// name
            ///
            ListTile(
              leading: Text('Name: '),
              title: Text(patient.name),
            ),

            ///
            /// Breed
            ///
            ListTile(
              leading: Text('Breed: '),
              title: Text(patient.breed.optional()),
            ),

            ///
            /// Species
            ///
            ListTile(
              leading: Text('Species: '),
              title: Text(patient.species.optional()),
            ),

            ///
            /// date of birth
            ///
            ListTile(
              leading: Text('Date of Birth: '),
              title:
                  Text((patient.dateOfBirth?.toLocal().yyyyMMdd()).optional()),
            ),
          ]),
        ),

        ///
        /// Owner Details
        ///
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          sliver: SliverList.list(children: [
            SizedBox(height: 30),

            ///
            /// Header
            ///
            ListTile(
              contentPadding: EdgeInsets.only(left: 14),
              title: Text(
                'Owner Info',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            ///
            /// owner
            ///
            ListTile(
              leading: Text('Owner: '),
              title: Text(patient.owner.optional()),
            ),

            ///
            /// address
            ///
            ListTile(
              leading: Text('Address: '),
              title: Text(patient.address.optional()),
            ),

            ///
            /// email
            ///
            ListTile(
              leading: Text('Email: '),
              title: Text(patient.email.optional()),
            ),

            ///
            /// contact number
            ///
            ListTile(
              leading: Text('Contact Number: '),
              title: Text(patient.contactNumber.optional()),
            ),
          ]),
        ),

        ///
        /// System Details
        ///
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          sliver: SliverList.list(children: [
            SizedBox(height: 30),

            ///
            /// Header
            ///
            ListTile(
              contentPadding: EdgeInsets.only(left: 14),
              title: Text(
                'Other Info',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            ///
            /// created
            ///
            ListTile(
              leading: Text('Created At: '),
              title:
                  Text((patient.created?.toLocal().yyyyMMddHHmmA()).optional()),
            ),

            ///
            /// updated
            ///
            ListTile(
              leading: Text('Updated At: '),
              title:
                  Text((patient.created?.toLocal().yyyyMMddHHmmA()).optional()),
            ),
          ]),
        ),
      ],
    );
  }
}
