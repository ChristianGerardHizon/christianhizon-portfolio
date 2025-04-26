import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../dynamic_field.dart';

class DynamicFormFieldSelect extends StatelessWidget {
  final DynamicSelectField field;

  const DynamicFormFieldSelect(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<dynamic>(
      key: field.formFieldKey,
      name: field.name,
      enabled: field.enabled,
      validator: field.validator,
      onChanged: (x) => field.onChange?.call(x),
      builder: (FormFieldState<dynamic> state) {
        return InputDecorator(
          decoration: field.decoration.copyWith(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            errorText: state.errorText,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.value != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: IconButton(
                      tooltip: 'Clear selection',
                      icon: const Icon(Icons.clear),
                      onPressed: () => state.didChange(null),
                    ),
                  ),
              ],
            ),
          ),
          isEmpty: state.value == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              isExpanded: true,
              value: state.value,
              hint: Text(field.decoration.hintText ?? ''),
              onChanged: field.enabled
                  ? (val) {
                      state.didChange(val);
                      field.onChange?.call(val);
                    }
                  : null,
              items: field.options
                  .map((opt) => DropdownMenuItem(
                        value: opt.value,
                        child: Text(opt.display),
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
