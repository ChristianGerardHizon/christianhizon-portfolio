import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CurrencyFormField extends StatelessWidget {
  final String name;
  final Function(String?)? onChanged;
  final InputDecoration decoration;
  final bool allowDecimal;
  final dynamic Function(String?)? valueTransformer;
  final bool enabled;

  const CurrencyFormField({
    this.enabled = true,
    super.key,
    required this.name,
    this.onChanged,
    this.decoration = const InputDecoration(),
    this.valueTransformer,
    this.allowDecimal = true,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      enabled: enabled,
      valueTransformer:
          valueTransformer ?? (value) => double.tryParse(value ?? ''),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            allowDecimal ? RegExp(r'[0-9.]') : RegExp(r'[0-9]')),
      ],
      keyboardType: TextInputType.numberWithOptions(
        decimal: allowDecimal,
        signed: false,
      ),
      decoration: decoration,
    );
  }
}
