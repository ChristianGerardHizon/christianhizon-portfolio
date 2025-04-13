import 'package:flutter/material.dart';
import 'package:gym_system/src/core/widgets/refresh_button.dart';
import 'package:gym_system/src/features/patient_records/presentation/controllers/patient_record_controller.dart';
import 'package:gym_system/src/features/patient_records/presentation/widgets/patient_record_details.dart';
import 'package:gym_system/src/features/prescription/presentation/controllers/prescription_all_items_controller.dart';
import 'package:gym_system/src/features/prescription/presentation/controllers/prescription_item_page_controller.dart';
import 'package:gym_system/src/features/prescription/presentation/controllers/prescription_items_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Define the PrescriptionItem class

class PatientRecordPage extends HookConsumerWidget {
  final String id;
  const PatientRecordPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(prescriptionItemsControllerProvider(id: id));
    ref.watch(prescriptionItemsPageControllerProvider);
    ref.watch(prescriptionAllItemsControllerProvider(id: id));
    final provider = patientRecordControllerProvider(id);
    final state = ref.watch(provider);

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: state.when(
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
          data: (record) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Medical Record Details'),
                actions: [
                  RefreshButton(onPressed: () => ref.invalidate(provider)),
                ],
              ),
              body: PatientRecordDetails(record: record),
            );
            // return Scaffold(
            //   body: SafeArea(
            //     child: NestedScrollView(
            //       headerSliverBuilder: (context, innerBoxIsScrolled) {
            //         return [
            //           ///
            //           /// AppBar
            //           ///
            //           SliverAppBar(
            //             title: Text('Medical Record'),
            //           ),

            //           SliverOverlapAbsorber(
            //             handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
            //                 context),
            //             sliver: PinnedHeaderSliver(
            //               child: DecoratedBox(
            //                 decoration: BoxDecoration(
            //                   color:
            //                       Theme.of(context).appBarTheme.backgroundColor,
            //                 ),
            //                 child: TabBar(
            //                   isScrollable: false,
            //                   tabs: [
            //                     Tab(
            //                       icon: Icon(MIcons.accountOutline),
            //                       child: Text('Details'),
            //                     ),
            //                     Tab(
            //                       icon: Icon(MIcons.informationOutline),
            //                       child: Text('Prescriptions'),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           )
            //         ];
            //       },
            //       body: Padding(
            //         padding: const EdgeInsets.only(top: 75),
            //         child: TabBarView(
            //           children: [
            //             PatientRecordDetails(record: record),
            //             PrescriptionItemsView(record: record),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // );
          }),
    );
  }
}
