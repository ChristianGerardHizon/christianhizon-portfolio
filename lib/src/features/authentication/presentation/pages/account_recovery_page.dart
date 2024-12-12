import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountRecoveryPage extends HookConsumerWidget {
  const AccountRecoveryPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Recover your account'),
      ),
      body: Column(
        children: [
          const ListTile(
            title: Text('Email'),
            subtitle: TextField(),
          ),
          OutlinedButton(
            onPressed: () {},
            child: const Text('Send Email Recovery'),
          ),
        ],
      ),
    );
  }
}
