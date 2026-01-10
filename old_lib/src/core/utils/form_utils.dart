import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';

class FormUtils {
  ///
  /// get the form state
  ///
  static TaskResult<FormBuilderState> getFormState(FormBuilderState? key) {
    final failure = PresentationFailure('form value is null');
    return Option.fromNullable(key).fold(
      () => TaskResult.left(failure),
      TaskResult.right,
    );
  }

  ///
  /// Save and Validate
  ///
  static TaskResult<Map<String, dynamic>> saveAndValidate(
    FormBuilderState form, {
    bool focusOnInvalid = true,
    bool autoScrollWhenFocusOnInvalid = false,
  }) {
    return TaskResult.tryCatch(
      () async {
        form.save();
        // await Future.delayed(const Duration(seconds: 1));

        final isValid = form.saveAndValidate(
          autoScrollWhenFocusOnInvalid: autoScrollWhenFocusOnInvalid,
          focusOnInvalid: focusOnInvalid,
        );

        if (!isValid) throw PresentationFailure('form is not valid');

        return form.value;
      },
      Failure.handle,
    );
  }

  ///
  /// Get Form values
  ///
  static TaskResult<Map<String, dynamic>> getFormValues(
    FormBuilderState? key, {
    bool focusOnInvalid = true,
    bool autoScrollWhenFocusOnInvalid = false,
  }) {
    return getFormState(key).flatMap((form) {
      return saveAndValidate(
        form,
        focusOnInvalid: focusOnInvalid,
        autoScrollWhenFocusOnInvalid: autoScrollWhenFocusOnInvalid,
      );
    });
  }

  ///
  /// reset form
  ///
  static TaskResult<void> reset(FormBuilderState? key) {
    return TaskResult.Do(($) async {
      final form = await $(getFormState(key));
      form.reset();
      return;
    });
  }
}
