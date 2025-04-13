import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../dynamic_field.dart';

class DynamicFormFieldDate extends StatelessWidget {
  final DynamicDateField field;

  const DynamicFormFieldDate(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<DateTime?>(
      key: field.formFieldKey,
      enabled: field.enabled,
      name: field.name,
      validator: field.validator,
      valueTransformer: field.valueTransformer,
      builder: (FormFieldState<DateTime?> state) {
        return InputDecorator(
          decoration: field.decoration.copyWith(
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.value != null)
                  IconButton(
                    tooltip: 'Clear date',
                    icon: const Icon(Icons.clear),
                    onPressed: () => state.didChange(null),
                  ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: state.value ?? DateTime.now(),
                      firstDate: field.firstDate ?? DateTime(1900),
                      lastDate: field.lastDate ?? DateTime(2100),
                    );
                    if (picked != null) {
                      state.didChange(picked);
                    }
                  },
                ),
              ],
            ),
          ),
          isEmpty: state.value == null,
          child: Text(
            state.value != null
                ? MaterialLocalizations.of(context)
                    .formatMediumDate(state.value!)
                : '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );
  }
}
