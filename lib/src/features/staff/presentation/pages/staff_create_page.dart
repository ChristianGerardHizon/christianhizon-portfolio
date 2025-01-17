import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StaffCreatePage extends HookConsumerWidget {
  const StaffCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    return Scaffold(
      appBar: AppBar(),
      body: FormBuilder(
        key: formKey,
        child: CustomScrollView(
          slivers: [],
        ),
      ),
    );
  }
}
