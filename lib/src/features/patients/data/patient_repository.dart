import 'package:cross_file/cross_file.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_repository.g.dart';

abstract class PatientRepository {
  TaskResult<Patient> get(String id);
  TaskResult<List<Patient>> list({
    String? query,
    required int pageNo,
    required int pageSize,
  });
  TaskResult<void> delete(String id);
  TaskResult<Patient> update(
      Patient patient, Map<String, dynamic> update, List<XFile> files);

  TaskResult<Patient> create(Map<String, dynamic> payload);
}

@Riverpod(keepAlive: true)
PatientRepository patientRepository(Ref ref) {
  return PatientRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class PatientRepositoryImpl extends PatientRepository {
  final PocketBase pb;

  PatientRepositoryImpl({required this.pb});

  RecordService get collection => pb.collection(PocketBaseCollections.patients);

  @override
  TaskResult<Patient> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id);
      return Patient.fromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<Patient> create(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload);
      return Patient.fromMap(response.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      throw UnimplementedError();
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<List<Patient>> list({
    String? query,
    required int pageNo,
    required int pageSize,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getList(
        page: pageNo,
        perPage: pageSize,
      );
      return result.items.map<Patient>((e) {
        return Patient.fromMap(e.toJson());
      }).toList();
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<Patient> update(
    Patient patient,
    Map<String, dynamic> update,
    List<XFile> files,
  ) {
    return TaskResult.tryCatch(() async {
      final result = await collection.update(
        patient.id,
        body: update,
      );
      return Patient.fromMap(result.toJson());
    }, Failure.tryCatchData);
  }
}
