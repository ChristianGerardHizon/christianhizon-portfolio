import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StaffsPage extends HookConsumerWidget {
  const StaffsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staffs'),
      ),
    );
  }
}
