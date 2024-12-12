import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

///
/// Just a simple array of hidden fields
///  will take a list of ids then will loop over them and add them to the form
///
class FormHiddenFields extends StatelessWidget {
  const FormHiddenFields({super.key, required this.ids});
  final List<String> ids;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: ids.map(
        (id) {
          return FormBuilderField(
            name: id,
            builder: (_) => const SizedBox(),
          );
        },
      ).toList(),
    );
  }
}
