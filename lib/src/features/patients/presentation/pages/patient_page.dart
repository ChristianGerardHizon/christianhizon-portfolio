import 'package:flutter/material.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/features/medical_records/presentation/controllers/medical_record_page_controller.dart';
import 'package:gym_system/src/features/medical_records/presentation/controllers/medical_records_controller.dart';
import 'package:gym_system/src/features/medical_records/presentation/widgets/medical_records_view.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients/patient_controller.dart';
import 'package:gym_system/src/features/treatments/presentation/controllers/treatment/treatments_controller.dart';
import 'package:gym_system/src/features/patients/presentation/widgets/patient_details.dart';
import 'package:gym_system/src/features/treatments/presentation/controllers/treatment_record/treatment_record_page_controller.dart';
import 'package:gym_system/src/features/treatments/presentation/widgets/patient_treatment_record_view.dart';
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
    ref.watch(medicalRecordsPageControllerProvider);
    ref.watch(medicalRecordSearchControllerProvider.notifier);
    ref.watch(medicalRecordsControllerProvider(id: id));
    ref.watch(treatmentRecordSearchControllerProvider);

    ///
    /// Refresh
    ///
    refresh() {
      ref.invalidate(provider);
      ref.invalidate(treatmentsControllerProvider);
    }

    return DefaultTabController(
      length: 4,
      initialIndex: page ?? 0,
      child: Scaffold(
        body: state.when(
          skipError: false,
          skipLoadingOnRefresh: false,
          skipLoadingOnReload: false,
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Scaffold(
            appBar: AppBar(
              title: Text('Something Went Wrong'),
            ),
            body: Center(child: Text(error.toString())),
          ),
          data: (patient) {
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
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
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
                      PatientDetails(patient: patient),
                      MedicalRecordsView(patient: patient),
                      PatientTreatmentRecordView(patient: patient),
                      Center(
                        child: Text('No Files'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
