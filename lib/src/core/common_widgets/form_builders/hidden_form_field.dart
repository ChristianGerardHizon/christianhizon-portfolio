import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

///
/// Simple Field to add hidden values to the form
/// will only be shown on debug mode unless [showOnDebug] is set
///
///
class HiddenFormField extends StatelessWidget {
  final String name;
  final bool showOnDebug;
  final dynamic Function(dynamic)? valueTransformer;

  const HiddenFormField({
    super.key,
    required this.name,
    this.showOnDebug = false,
    this.valueTransformer,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
        name: name,
        valueTransformer: valueTransformer,
        builder: (x) {
          if (showOnDebug && kDebugMode) {
            return ListTile(
              title: Text('$name: ${x.value}'),
              trailing: const Text('hidden field'),
            );
          }
          return const SizedBox();
        });
  }
}
