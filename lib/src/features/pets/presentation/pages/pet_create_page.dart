import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/features/pets/data/pet_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PetCreatePage extends HookConsumerWidget {
  const PetCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    void onSubmit() async {
      isLoading.value = true;
      final form = formKey.currentState;
      if (form == null) {
        isLoading.value = false;
        return;
      }
      final isValid = form.saveAndValidate();
      if (!isValid) {
        isLoading.value = false;
        return;
      }

      ///
      /// separate the List<xFiles> and convert it to List<MultipartFile>
      ///
      final files = form.value[PetField.images];

      final result =
          await ref.read(petRepositoryProvider).create(form.value).run();
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          PetsPageRoute().go(context);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(
          onPressed: () => PetsPageRoute().go(context),
        ),
        title: Text('Pet Create Page'),
      ),
      body: FormBuilder(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 10, right: 10),
          children: [
            ///
            /// name
            ///
            FormBuilderTextField(
              name: PetField.name,
              decoration: InputDecoration(labelText: 'Pet Name'),
            ),

            ///
            /// address
            ///
            FormBuilderTextField(
              name: PetField.address,
              decoration: InputDecoration(labelText: 'Address'),
            ),

            ///
            /// Owner
            ///
            FormBuilderTextField(
              name: PetField.owner,
              decoration: InputDecoration(labelText: 'Owner'),
            ),

            ///
            /// ContactNumber
            ///
            FormBuilderTextField(
              name: PetField.contactNumber,
              decoration: InputDecoration(labelText: 'Contact Number'),
            ),

            ///
            /// Email
            ///
            FormBuilderTextField(
              name: PetField.email,
              decoration: InputDecoration(labelText: 'Email'),
            ),

            ///
            /// Species
            ///
            FormBuilderTextField(
              name: PetField.species,
              decoration: InputDecoration(labelText: 'Species'),
            ),

            ///
            /// Breed
            ///
            FormBuilderTextField(
              name: PetField.breed,
              decoration: InputDecoration(labelText: 'Breed'),
            ),

            ///
            /// Color
            ///
            FormBuilderTextField(
              name: PetField.color,
              decoration: InputDecoration(labelText: 'Color'),
            ),

            ///
            /// Sex
            ///
            FormBuilderDropdown<String>(
              name: PetField.sex,
              decoration: InputDecoration(labelText: 'Sex'),
              items: ['male', 'female']
                  .map((sex) => DropdownMenuItem(
                        value: sex,
                        child: Text(sex),
                      ))
                  .toList(),
            ),

            ///
            /// Date Of Birth
            ///
            FormBuilderDateTimePicker(
              initialEntryMode: DatePickerEntryMode.inputOnly,
              inputType: InputType.date,
              name: PetField.dateOfBirth,
              valueTransformer: (dateTime) {
                if (dateTime == null) return null;
                return dateTime.toUtc().toIso8601String();
              },
            ),

            SizedBox(height: 20),

            ///
            /// save button
            ///
            LoadingFilledButton(
              isLoading: isLoading.value,
              child: Text('Save'),
              onPressed: onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
