import 'package:flutter/material.dart';
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
