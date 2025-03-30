import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:gym_system/src/features/patients/domain/patient_species.dart';

class PatientSpeciesFormField extends StatelessWidget {
  final String name;
  final List<PatientSpecies> list;
  final ValueTransformer<PatientSpecies?>? valueTransformer;
  final FormFieldValidator<PatientSpecies?>? validator;

  const PatientSpeciesFormField({
    super.key,
    required this.name,
    required this.list,
    this.valueTransformer,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTypeAhead<PatientSpecies>(
      valueTransformer: valueTransformer,
      validator: validator,
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
      name: name,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          bottom: 10,
          right: 8,
          left: 8,
          top: 30,
        ),
        labelText: 'Species',
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
