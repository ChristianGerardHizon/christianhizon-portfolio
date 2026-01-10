import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/failure_message.dart';
import 'package:sannjosevet/src/core/widgets/refresh_button.dart';
import 'package:sannjosevet/src/features/appointment_schedules/presentation/pages/appointment_schedules_page.dart';
import 'package:sannjosevet/src/features/patient_files/presentation/presentation/pages/patient_files_page.dart';
import 'package:sannjosevet/src/features/patient_records/presentation/pages/patient_records_page.dart';
import 'package:sannjosevet/src/features/patient_treatment_records/presentation/pages/patient_treatment_records_page.dart';
import 'package:sannjosevet/src/features/patient_treatments/presentation/controllers/patient_treatments_controller.dart';
import 'package:sannjosevet/src/features/patients/presentation/controllers/patient_controller.dart';
import 'package:sannjosevet/src/features/patients/presentation/widgets/patient_details_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientPage extends HookConsumerWidget {
  const PatientPage(this.id, {super.key, this.page});

  final String id;
  final int? page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = patientControllerProvider(id);
    final state = ref.watch(provider);

    /// for medical records tab. preloading the data

    ///
    /// Refresh
    ///
    refresh() {
      ref.invalidate(provider);
      ref.invalidate(patientTreatmentsControllerProvider);
    }

    return DefaultTabController(
      length: 5,
      initialIndex: page ?? 0,
      child: Scaffold(
        body: Builder(builder: (context) {
          ///
          /// Loading
          ///
          if (state.isLoading)
            return const Center(child: CircularProgressIndicator());

          ///
          /// Error
          ///
          if (state.hasError) return FailureMessage.asyncValueWidget(state);

          ///
          /// Content
          ///
          final patient = state.value!;
          return SafeArea(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  ///
                  /// AppBar
                  ///
                  SliverAppBar(
                    title: Text(patient.name),
                    actions: [
                      RefreshButton(onPressed: () {
                        refresh();
                      })
                    ],
                  ),

                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: PinnedHeaderSliver(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).appBarTheme.backgroundColor,
                        ),
                        child: TabBar(
                          isScrollable: true,
                          tabs: [
                            Tab(
                              icon: Icon(MIcons.accountOutline),
                              child: Text('Details'),
                            ),
                            Tab(
                              icon: Icon(MIcons.informationOutline),
                              child: Text('Records'),
                            ),
                            Tab(
                              icon: Icon(MIcons.hospitalBoxOutline),
                              child: Text('Treatments'),
                            ),
                            Tab(
                              icon: Icon(MIcons.calendarCheckOutline),
                              child: Text('Appointments'),
                            ),
                            Tab(
                              icon: Icon(MIcons.fileOutline),
                              child: Text('Files'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: Padding(
                padding: const EdgeInsets.only(top: 75),
                child: TabBarView(
                  children: [
                    PatientDetailsView(patient),
                    PatientRecordsPage(
                      patient: patient,
                      showAppBar: false,
                    ),
                    PatientTreatmentRecordsPage(
                      id: patient.id,
                      showAppBar: false,
                    ),
                    AppointmentSchedulesPage(
                      patientId: patient.id,
                      showAppBar: false,
                    ),
                    PatientFilesPage(
                      patientId: patient.id,
                      showAppBar: false,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
