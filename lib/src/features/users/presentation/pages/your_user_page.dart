import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class YourUserPage extends HookConsumerWidget {
  const YourUserPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('App Bar Sample'),
          ),
          SliverAppBar(
            pinned: true,
            title: Text('Contetn'),
          )
        ],
      ),
    );
  }
}
