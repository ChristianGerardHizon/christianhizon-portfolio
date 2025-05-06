import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../dynamic_field.dart';

class DynamicDateTimeField extends DynamicField {
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialValue;
  final DateFormat? format;
  final String? Function(DateTime?)? validator;
  final dynamic Function(DateTime?)? fieldTransformer;
  final GlobalKey<FormBuilderFieldState>? formFieldKey;
  final TimeOfDay? defaultTime;

  const DynamicDateTimeField({
    this.formFieldKey,
    this.defaultTime,
    required super.name,
    this.initialValue,
    this.validator,
    super.decoration,
    super.valueTransformer,
    this.firstDate,
    this.lastDate,
    this.fieldTransformer,
    super.margin,
    super.enabled,
    this.format,
  });
}

class DynamicFormFieldDateTime extends StatelessWidget {
  final DynamicDateTimeField field;

  const DynamicFormFieldDateTime(this.field, {super.key});

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
            errorText: state.errorText,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.value != null)
                  IconButton(
                    tooltip: 'Clear date & time',
                    icon: const Icon(Icons.clear),
                    onPressed: () => state.didChange(null),
                  ),
                IconButton(
                  tooltip: 'Pick date',
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: state.value ?? DateTime.now(),
                      firstDate: field.firstDate ?? DateTime(1900),
                      lastDate: field.lastDate ?? DateTime(2100),
                    );
                    if (pickedDate != null) {
                      final old = state.value ?? DateTime.now();
                      final newDateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        old.hour,
                        old.minute,
                      );
                      state.didChange(newDateTime);
                    }
                  },
                ),
                IconButton(
                  tooltip: 'Pick time',
                  icon: const Icon(Icons.access_time),
                  onPressed: () async {
                    final current = state.value ?? DateTime.now();
                    final initialTime =
                        field.defaultTime ?? TimeOfDay.fromDateTime(current);
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: initialTime,
                      initialEntryMode: TimePickerEntryMode.inputOnly,
                    );
                    if (pickedTime != null) {
                      final datePart = state.value ?? DateTime.now();
                      final newDateTime = DateTime(
                        datePart.year,
                        datePart.month,
                        datePart.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                      state.didChange(newDateTime);
                    }
                  },
                ),
              ],
            ),
          ),
          isEmpty: state.value == null,
          child: Text(
            state.value != null
                ? (field.format?.format(state.value!) ??
                    DateFormat.yMMMd().add_jm().format(state.value!))
                : '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );
  }
}
