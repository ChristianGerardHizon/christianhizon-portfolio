import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/patient_repository.dart';
import '../../domain/patient.dart';

part 'patient_provider.g.dart';

/// Provider for a single patient by ID.
@riverpod
Future<Patient?> patient(Ref ref, String id) async {
  final repository = ref.read(patientRepositoryProvider);
  final result = await repository.fetchOne(id);

  return result.fold(
    (failure) => null,
    (patient) => patient,
  );
}
