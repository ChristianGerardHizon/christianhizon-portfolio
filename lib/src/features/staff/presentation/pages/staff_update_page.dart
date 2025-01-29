import 'package:flutter/material.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StaffUpdatePage extends HookConsumerWidget {
  final String id;

  const StaffUpdatePage(this.id, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => StaffPageRoute(id).go(context),
        ),
      ),
      body: Center(
        child: Text('Sample'),
      ),
    );
  }
}
