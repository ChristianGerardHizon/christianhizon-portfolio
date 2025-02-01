import 'package:flutter/material.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SalesPage extends HookConsumerWidget {
  const SalesPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => YourAccountPageRoute().go(context),
        ),
        title: Text('Sales'),
      ),
    );
  }
}
