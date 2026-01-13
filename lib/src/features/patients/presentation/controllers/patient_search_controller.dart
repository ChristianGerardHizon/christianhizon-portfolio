import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_search_controller.g.dart';

/// Available search fields for patients.
const patientSearchableFields = [
  'name',
  'owner',
  'species',
  'breed',
  'contactNumber',
  'email',
  'address',
];

/// Provider for patient search query state.
@riverpod
class PatientSearchQuery extends _$PatientSearchQuery {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }

  void clear() {
    state = '';
  }
}

/// Provider for managing which fields are included in patient search.
@riverpod
class PatientSearchFields extends _$PatientSearchFields {
  @override
  Set<String> build() => {'name'}; // Default: only name

  void toggleField(String field) {
    // Name is always required
    if (field == 'name') return;

    if (state.contains(field)) {
      state = {...state}..remove(field);
    } else {
      state = {...state, field};
    }
  }

  void reset() {
    state = {'name'};
  }

  void setFields(Set<String> fields) {
    // Ensure name is always included
    state = {...fields, 'name'};
  }
}
