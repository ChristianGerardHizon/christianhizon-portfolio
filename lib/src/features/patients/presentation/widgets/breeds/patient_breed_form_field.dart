import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:gym_system/src/features/patients/domain/patient_breed.dart';

class PatientBreedFormField extends StatelessWidget {
  final String name;
  final List<PatientBreed> list;
  final ValueTransformer<PatientBreed?>? valueTransformer;
  final FormFieldValidator<PatientBreed>? validator;

  const PatientBreedFormField({
    super.key,
    required this.name,
    required this.list,
    this.valueTransformer,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTypeAhead<PatientBreed>(
      name: name,
      validator: validator,
      valueTransformer: valueTransformer,
      selectionToTextTransformer: (suggestion) => suggestion.name,
      suggestionsCallback: (p0) async {
        return list
            .where((e) => e.name.toLowerCase().contains(p0.toLowerCase()))
            .toList();
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.name),
        );
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          bottom: 10,
          right: 8,
          left: 8,
          top: 30,
        ),
        labelText: 'Breed',
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
