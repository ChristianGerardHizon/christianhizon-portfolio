import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomValidators {
  /// Returns a validator that checks whether this field’s value
  /// matches the value of [otherFieldName].
  static FormFieldValidator<String> matchFieldValidator(
    String otherFieldName, {
    String errorText = 'Fields do not match',
    required GlobalKey<FormBuilderState> formKey,
  }) {
    return (String? value) {
      // Grab the FormBuilderState so we can read another field’s value
      final formState = formKey.currentState;
      if (formState == null) return 'form state is null';

      final otherValue =
          formState.fields[otherFieldName]?.value?.toString() ?? '';

      if (value != otherValue) {
        return errorText;
      }
      return null;
    };
  }
}
