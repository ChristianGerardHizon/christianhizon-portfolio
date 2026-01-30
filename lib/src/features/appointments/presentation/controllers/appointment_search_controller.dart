import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_search_controller.g.dart';

/// Available search fields for appointments.
const appointmentSearchableFields = [
  'patientName',
  'ownerName',
  'purpose',
  'ownerContact',
  'notes',
];

/// Provider for appointment search query state.
@riverpod
class AppointmentSearchQuery extends _$AppointmentSearchQuery {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }

  void clear() {
    state = '';
  }
}

/// Provider for managing which fields are included in appointment search.
@riverpod
class AppointmentSearchFields extends _$AppointmentSearchFields {
  @override
  Set<String> build() => {'patientName'}; // Default: only patient name

  void toggleField(String field) {
    if (state.contains(field)) {
      // Prevent removing if it's the last field
      if (state.length <= 1) return;
      state = {...state}..remove(field);
    } else {
      state = {...state, field};
    }
  }

  void reset() {
    state = {'patientName'};
  }

  void setFields(Set<String> fields) {
    // Ensure at least one field is selected
    if (fields.isEmpty) {
      state = {'patientName'}; // fallback to patientName
    } else {
      state = fields;
    }
  }
}
