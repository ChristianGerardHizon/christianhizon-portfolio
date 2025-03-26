import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/dynamic_list/responsive_pagination_list_with_delete_view.dart';
import 'package:gym_system/src/core/widgets/dynamic_list/sliver_dynamic_base_list.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/presentation/controllers/products_controller.dart';
import 'package:gym_system/src/features/products/presentation/controllers/products_page_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
              child: Text('Sample'),
            ),
          ),

          ///
          /// Welcome Message
          ///
          // SliverPadding(
          //   padding: const EdgeInsets.only(left: 20, top: 30),
          //   sliver: SliverToBoxAdapter(
          //     child: ref.watch(authControllerProvider).when(
          //           data: (user) {
          //             if (user is AuthUser) {
          //               return Text(
          //                 'Welcome ${user.record.name}',
          //                 style:
          //                     Theme.of(context).textTheme.titleLarge?.copyWith(
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //               );
          //             }

          //             if (user is AuthAdmin) {
          //               return Text(
          //                 'Welcome ${user.record.name}',
          //                 style:
          //                     Theme.of(context).textTheme.titleLarge?.copyWith(
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //               );
          //             }

          //             return SizedBox();
          //           },
          //           error: (error, stacl) => SizedBox(),
          //           loading: () => Text('Loading...'),
          //         ),
          //   ),
          // ),

          ///
          /// Cards
          ///
          // SliverPadding(
          //   padding: const EdgeInsets.only(left: 20, top: 10),
          //   sliver: SliverList.list(children: [
          //     ///
          //     /// Total Number of Patients
          //     ///
          //     ResponsiveBuilder(builder: (context, si) {
          //       final contents = [
          //         Card(
          //           child: Padding(
          //             padding: const EdgeInsets.all(12.0),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Padding(
          //                   padding: const EdgeInsets.only(bottom: 10, top: 10),
          //                   child: Text(
          //                     '8',
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .titleLarge
          //                         ?.copyWith(
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                   ),
          //                 ),
          //                 Text('Your Patients for Today'),
          //                 SizedBox(width: 30),
          //               ],
          //             ),
          //           ),
          //         ),
          //         // Card(
          //         //   child: Padding(
          //         //     padding: const EdgeInsets.all(12.0),
          //         //     child: Column(
          //         //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         //       children: [
          //         //         Padding(
          //         //           padding: const EdgeInsets.only(bottom: 10, top: 10),
          //         //           child: Text(
          //         //             '10',
          //         //             style: Theme.of(context)
          //         //                 .textTheme
          //         //                 .titleLarge
          //         //                 ?.copyWith(
          //         //                   fontWeight: FontWeight.bold,
          //         //                 ),
          //         //           ),
          //         //         ),
          //         //         Text('Products Near Expiry'),
          //         //         SizedBox(width: 30),
          //         //       ],
          //         //     ),
          //         //   ),
          //         // ),
          //         Card(
          //           child: Padding(
          //             padding: const EdgeInsets.all(12.0),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Padding(
          //                   padding: const EdgeInsets.only(
          //                       bottom: 10, top: 10, left: 30, right: 30),
          //                   child: Text(
          //                     '₱0.00 PHP',
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .titleLarge
          //                         ?.copyWith(
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                   ),
          //                 ),
          //                 Text('Total Sales Today'),
          //                 SizedBox(width: 30),
          //               ],
          //             ),
          //           ),
          //         )
          //       ];

          //       if (si.isMobile) {
          //         return Column(
          //           children: contents,
          //         );
          //       }

          //       return Row(
          //         children: contents,
          //       );
          //     })
          //   ]),
          // ),
        ],
      ),
    );
  }
}
