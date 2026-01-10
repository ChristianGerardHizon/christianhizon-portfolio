import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../dynamic_field.dart';

class DynamicSelectField<T> extends DynamicField {
  final List<SelectOption<T>> options;
  final T? initialValue;
  final String? Function(T?)? validator;
  final dynamic Function(T?)? fieldTransformer;
  final GlobalKey<FormBuilderFieldState>? formFieldKey;
  final Function(dynamic)? onChange;

  const DynamicSelectField({
    this.formFieldKey,
    required super.name,
    this.initialValue,
    this.validator,
    super.valueTransformer,
    required this.options,
    super.decoration,
    this.fieldTransformer,
    this.onChange,
    super.margin,
    super.enabled,
  });
}

class SelectOption<T> {
  final T value;
  final String display;

  const SelectOption({
    required this.value,
    required this.display,
  });
}

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
