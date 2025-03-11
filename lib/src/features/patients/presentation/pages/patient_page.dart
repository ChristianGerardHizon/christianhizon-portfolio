import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/features/medical_records/presentation/controllers/medical_record_page_controller.dart';
import 'package:gym_system/src/features/medical_records/presentation/controllers/medical_records_controller.dart';
import 'package:gym_system/src/features/medical_records/presentation/widgets/medical_records_view.dart';
import 'package:gym_system/src/features/vaccines/domain/vaccine.dart';
import 'package:gym_system/src/features/vaccines/presentation/controllers/vaccine/vaccines_controller.dart';
import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patient_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients_controller.dart';
import 'package:gym_system/src/features/patients/presentation/widgets/patient_details.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientPage extends HookConsumerWidget {
  const PatientPage(this.id, {super.key, this.page});

  final String id;
  final int? page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = patientControllerProvider(id);
    final state = ref.watch(provider);
    final vaccine = useState<Vaccine?>(null);

    /// for medical records tab. preloading the data
    ref.watch(medicalRecordsPageControllerProvider);
    ref.watch(medicalRecordSearchControllerProvider.notifier);
    ref.watch(medicalRecordsControllerProvider(id: id));

    ///
    /// Refresh
    ///
    refresh() {
      ref.invalidate(provider);
      ref.invalidate(vaccinesControllerProvider);
    }

    return DefaultTabController(
      length: 3,
      initialIndex: page ?? 0,
      child: Scaffold(
        body: state.when(
          skipError: false,
          skipLoadingOnRefresh: false,
          skipLoadingOnReload: false,
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          data: (patient) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  ///
                  /// AppBar
                  ///
                  SliverAppBar(
                    title: Text(patient.name),
                    actions: [
                      // IconButton(
                      //   icon: const Icon(Icons.edit),
                      //   onPressed: () =>
                      //       PatientUpdatePageRoute(id).go(context),
                      // ),
                      // IconButton(
                      //   icon: const Icon(Icons.delete),
                      //   onPressed: () => onDelete(),
                      // ),
                      // IconButton(
                      //   icon: const Icon(Icons.refresh),
                      //   onPressed: () => refresh(),
                      // )
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
                          isScrollable: false,
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
                              child: Text('Vaccines'),
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
                    FlutterLogo()
                    // PatientVaccineRecordView(patient: patient),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
