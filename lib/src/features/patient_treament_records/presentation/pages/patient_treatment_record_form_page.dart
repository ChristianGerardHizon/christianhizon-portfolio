import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/circle_widget.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/core/widgets/pb_image_circle.dart';
import 'package:gym_system/src/features/patient_treament_records/data/patient_treatment_record_repository.dart';
import 'package:gym_system/src/features/patient_treament_records/domain/patient_treatment_record.dart';
import 'package:gym_system/src/features/patient_treament_records/presentation/controllers/patient_treatment_record_controller.dart';
import 'package:gym_system/src/features/patient_treament_records/presentation/controllers/patient_treatment_record_form_controller.dart';
import 'package:gym_system/src/features/patient_treament_records/presentation/controllers/patient_treatment_record_table_controller.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientTreatmentRecordFormPage extends HookConsumerWidget {
  const PatientTreatmentRecordFormPage(
      {super.key, this.id, required this.parentId});

  final String? id;
  final String parentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(patientTreatmentRecordFormControllerProvider(
        patientId: parentId, id: id));

    ///
    /// Submit
    ///
    void onSave(
      PatientTreatmentRecord? patientTreatmentRecord,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(patientTreatmentRecordRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (patientTreatmentRecord == null
          ? repository.create(value, files: files)
          : repository.update(patientTreatmentRecord, value, files: files));

      final result = await task.run();
      if (!context.mounted) return;
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(patientTreatmentRecordTableControllerProvider);
          ref.invalidate(patientTreatmentRecordControllerProvider(r.id));
          context.pop();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('PatientTreatmentRecord Form Page'),
      ),
      body: provider.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
          data: (formState) {
            final patientTreatmentRecord = formState.patientTreatmentRecord;
            final patient = formState.patient;
            final branches = formState.branches;
            final patientTreatments = formState.patientTreatments;
            return DynamicFormBuilder(
              onChange: (value) {},
              itemPadding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 0,
              ),
              formKey: formKey,
              isLoading: isLoading.value,
              fields: [
                ///
                /// Patient
                ///
                DynamicViewField(
                    name: PatientTreatmentRecordField.patient,
                    initialValue: patient,
                    decoration: InputDecoration(
                      label: Text('Patient'),
                      border: OutlineInputBorder(),
                    ),
                    builder: (obj) {
                      if (obj is Patient) {
                        return ListTile(
                          leading: CircleWidget(
                            size: 40,
                            child: PbImageCircle(
                              collection: obj.collectionId,
                              recordId: obj.id,
                              file: obj.avatar,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          title: Text(obj.name),
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodySmall,
                                  children: [
                                    TextSpan(
                                      text: obj.expand.breed?.name.optional(),
                                    ),
                                    TextSpan(text: ' - '),
                                    TextSpan(
                                      text: obj.expand.species?.name.optional(),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Owner: ${obj.owner?.optional()}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                    valueTransformer: (patient) {
                      return patient?.id;
                    }),

                ///
                /// Treatment Date
                ///
                DynamicDateTimeField(
                  name: PatientTreatmentRecordField.date,
                  initialValue: patientTreatmentRecord?.date ?? DateTime.now(),
                  decoration: InputDecoration(
                    label: Text('Treatment Date'),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  valueTransformer: (p0) {
                    final value = p0;
                    if (value is DateTime)
                      return value.toUtc().toIso8601String();
                  },
                ),

                ///
                /// Treatment
                ///
                DynamicSelectField(
                  name: PatientTreatmentRecordField.treatment,
                  initialValue: patientTreatmentRecord?.treatment,
                  decoration: InputDecoration(
                    label: Text('Treatment'),
                    border: OutlineInputBorder(),
                  ),
                  options: patientTreatments
                      .map((e) => SelectOption(
                            value: e.id,
                            display: e.name,
                          ))
                      .toList(),
                ),

                ///
                /// Note
                ///
                DynamicTextField(
                  name: PatientTreatmentRecordField.note,
                  initialValue: patientTreatmentRecord?.notes,
                  decoration: InputDecoration(
                    label: Text('Notes'),
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  maxLines: 10,
                  validator: FormBuilderValidators.compose([]),
                ),
              ],
              onSubmit: (result) => onSave(patientTreatmentRecord, result),
            );
          }),
    );
  }
}
