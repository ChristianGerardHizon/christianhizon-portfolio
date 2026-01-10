import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/failure_message.dart';
import 'package:sannjosevet/src/core/widgets/refresh_button.dart';
import 'package:sannjosevet/src/features/patients/breeds/presentation/pages/patient_breeds_page.dart';
import 'package:sannjosevet/src/features/patients/species/presentation/controllers/patient_species_controller.dart';
import 'package:sannjosevet/src/features/patients/species/presentation/widgets/patient_species_details_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientSpeciesPage extends HookConsumerWidget {
  const PatientSpeciesPage(this.id, {super.key, this.page});

  final String id;
  final int? page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = patientSpeciesControllerProvider(id);
    final state = ref.watch(provider);

    /// for medical records tab. preloading the data

    ///
    /// Refresh
    ///
    refresh() {
      ref.invalidate(provider);
    }

    return DefaultTabController(
      length: 2,
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
          final patientSpecies = state.value!;
          return SafeArea(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  ///
                  /// AppBar
                  ///
                  SliverAppBar(
                    title: Text(patientSpecies.name),
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
                          tabs: [
                            Tab(
                              icon: Icon(MIcons.accountOutline),
                              child: Text('Details'),
                            ),
                            Tab(
                              icon: Icon(MIcons.informationOutline),
                              child: Text('Breeds'),
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
                    PatientSpeciesDetailsView(patientSpecies),
                    PatientBreedsPage(
                      species: patientSpecies,
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
