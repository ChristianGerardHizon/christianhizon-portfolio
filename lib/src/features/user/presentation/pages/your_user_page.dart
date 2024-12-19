import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class YourUserPage extends HookConsumerWidget {
  const YourUserPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your User Page'),
      ),
      body: Center(
        child: Text('Your User Page'),
      ),
    );
  }
}
