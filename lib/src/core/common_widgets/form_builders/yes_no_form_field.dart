import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class YesNoFormField extends HookConsumerWidget {
  final String name;
  final bool enabled;
  final String? hint;
  final InputDecoration decoration;
  final dynamic Function(Object?)? valueTransformer;

  const YesNoFormField({
    super.key,
    required this.name,
    this.enabled = true,
    this.hint,
    this.valueTransformer,
    this.decoration = const InputDecoration(),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormBuilderDropdown(
      name: name,
      enabled: enabled,
      hint: Text(hint ?? ''),
      decoration: decoration,
      items: [
        DropdownMenuItem(
          value: true,
          child: Text('Yes'),
        ),
        DropdownMenuItem(
          value: false,
          child: Text('No'),
        ),
      ],
      valueTransformer: valueTransformer,
    );
  }
}
