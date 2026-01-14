import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/patient_record_repository.dart';
import '../../domain/patient_record.dart';

part 'patient_record_provider.g.dart';

/// Provider for a single patient record by ID.
@riverpod
Future<PatientRecord?> patientRecord(Ref ref, String id) async {
  final repository = ref.read(patientRecordRepositoryProvider);
  final result = await repository.fetchOne(id);

  return result.fold(
    (failure) => null,
    (record) => record,
  );
}
