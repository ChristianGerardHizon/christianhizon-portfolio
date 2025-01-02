import 'package:flutter/material.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UsersPage extends HookConsumerWidget {
  const UsersPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () => UserPageRoute().go(context),
          child: Text('User'),
        ),
      ),
    );
  }
}
