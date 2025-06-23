import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/circle_widget.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:sannjosevet/src/core/widgets/pb_image_circle.dart';
import 'package:sannjosevet/src/features/patient_records/data/patient_record_repository.dart';
import 'package:sannjosevet/src/features/patient_records/presentation/controllers/patient_record_controller.dart';
import 'package:sannjosevet/src/features/patient_records/presentation/controllers/patient_record_form_controller.dart';
import 'package:sannjosevet/src/features/patient_records/presentation/controllers/patient_record_table_controller.dart';
import 'package:sannjosevet/src/features/patients/domain/patient.dart';
import 'package:sannjosevet/src/features/patient_records/domain/patient_record.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientRecordFormPage extends HookConsumerWidget {
  const PatientRecordFormPage({super.key, this.id, required this.parentId});

  final String? id;
  final String parentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _id = useState<String?>(id);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final _provider =
        patientRecordFormControllerProvider(patientId: parentId, id: _id.value);
    final provider = ref.watch(_provider);

    ///
    /// Submit
    ///
    void onSave(
      PatientRecord? patientRecord,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(patientRecordRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (patientRecord == null
          ? repository.create(value, files: files)
          : repository.update(patientRecord, value, files: files));

      final result = await task.run();
      if (!context.mounted) return;
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(patientRecordTableControllerProvider);
          ref.invalidate(patientRecordControllerProvider(r.id));
          context.pop(r);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('PatientRecord Form Page'),
      ),
      body: provider.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
          data: (formState) {
            final patientRecord = formState.patientRecord;
            final patient = formState.patient;
            final branches = formState.branches;
            final auth = formState.auth;
            final authBranch = auth.map(
              (user) => user.record.branch,
              (admin) => null,
            );
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
                    name: PatientRecordField.patient,
                    initialValue: patient,
                    decoration: InputDecoration(
                      label: Text('Patient'),
                      border: OutlineInputBorder(),
                    ),
                    builder: (obj) {
                      if (obj is Patient) {
                        return ListTile(
                          leading: CircleWidget(
                            size: Size.square(40),
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
                /// Visit Date and Time
                ///
                DynamicDateTimeField(
                  name: PatientRecordField.vistDate,
                  initialValue: patientRecord?.visitDate ?? DateTime.now(),
                  decoration: InputDecoration(
                    label: Text('Visit Date and Time'),
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
                /// Tests
                ///
                DynamicTextField(
                  name: PatientRecordField.tests,
                  initialValue: patientRecord?.tests,
                  decoration: InputDecoration(
                    label: Text('Tests Done'),
                    border: OutlineInputBorder(),
                  ),
                  minLines: 2,
                  maxLines: 30,
                  validator: FormBuilderValidators.compose([]),
                ),

                ///
                /// Diagnosis
                ///
                DynamicTextField(
                  name: PatientRecordField.diagnosis,
                  initialValue: patientRecord?.diagnosis,
                  decoration: InputDecoration(
                    label: Text('Diagnosis'),
                    border: OutlineInputBorder(),
                  ),
                  minLines: 2,
                  maxLines: 30,
                  validator: FormBuilderValidators.compose([]),
                ),

                ///
                /// Treatment
                ///
                DynamicTextField(
                  name: PatientRecordField.treatment,
                  initialValue: patientRecord?.treatment,
                  decoration: InputDecoration(
                    label: Text('Treatment'),
                    border: OutlineInputBorder(),
                  ),
                  minLines: 2,
                  maxLines: 30,
                  validator: FormBuilderValidators.compose([]),
                ),

                ///
                /// Weight in Kg
                ///
                DynamicNumberField(
                  name: PatientRecordField.weightInKg,
                  initialValue: patientRecord?.weightInKg,
                  decoration: InputDecoration(
                    label: Text('Weight in Kg'),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                  ]),
                  valueTransformer: (value) {
                    if (value is String) return num.parse(value);
                  },
                ),

                ///
                /// Note
                ///
                DynamicTextField(
                  name: PatientRecordField.notes,
                  initialValue: patientRecord?.notes,
                  decoration: InputDecoration(
                    label: Text('Notes'),
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  maxLines: 10,
                  validator: FormBuilderValidators.compose([]),
                ),

                DynamicFieldGroup(
                  padding: const EdgeInsets.only(top: 16),
                  title: Text('Additional Details'),
                  fields: [
                    // DynamicHiddenField(
                    //   name: PatientRecordField.admin,
                    //   initialValue: auth.map((user) => user.id, (_) => null),
                    // ),
                    // DynamicHiddenField(
                    //   name: PatientRecordField.admin,
                    //   initialValue: auth.map((_) => null, (admin) => admin.id),
                    // ),
                    DynamicSelectField(
                      name: PatientRecordField.branch,
                      initialValue: patientRecord?.branch ??
                          authBranch ??
                          branches.firstOrNull?.id,
                      decoration: InputDecoration(
                        label: Text('Branch'),
                        border: OutlineInputBorder(),
                      ),
                      options: branches
                          .map((e) => SelectOption(
                                value: e.id,
                                display: e.name,
                              ))
                          .toList(),
                    ),
                  ],
                )
              ],
              onSubmit: (result) => onSave(patientRecord, result),
            );
          }),
    );
  }
}
