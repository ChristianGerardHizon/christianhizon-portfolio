import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/services.dart';

import '../dynamic_field.dart';

class DynamicNumberField extends DynamicField {
  final num? min;
  final num? max;
  final num? step;
  final num? initialValue;
  final String? Function(dynamic)? validator;
  final dynamic Function(dynamic)? fieldTransformer;
  final GlobalKey<FormBuilderFieldState>? formFieldKey;

  const DynamicNumberField({
    this.formFieldKey,
    required super.name,
    this.initialValue,
    this.validator,
    super.valueTransformer,
    this.min,
    this.max,
    this.fieldTransformer,
    this.step,
    super.decoration,
    super.margin,
    super.enabled,
  });
}

class DynamicFormFieldNumber extends HookWidget {
  final DynamicNumberField field;

  const DynamicFormFieldNumber(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(
      text: (field.initialValue ?? 0).toString(),
    );

    return FormBuilderField<num>(
      key: field.formFieldKey,
      name: field.name,
      initialValue: field.initialValue ?? 0,
      validator: field.validator,
      enabled: field.enabled,
      builder: (fbField) {
        return InputDecorator(
          decoration: field.decoration.copyWith(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            errorText: fbField.errorText,
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: field.enabled
                    ? () {
                        final newValue =
                            (fbField.value ?? 0) - (field.step ?? 1);
                        controller.text = newValue.toString();
                        fbField.didChange(newValue);
                      }
                    : null,
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  enabled: field.enabled,
                  textAlign: TextAlign.center,
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: true,
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^-?\d*\.?\d*'),
                    ),
                  ],
                  onChanged: (value) {
                    final numValue = num.tryParse(value);
                    fbField.didChange(numValue);
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: field.enabled
                    ? () {
                        final newValue =
                            (fbField.value ?? 0) + (field.step ?? 1);
                        controller.text = newValue.toString();
                        fbField.didChange(newValue);
                      }
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
}
