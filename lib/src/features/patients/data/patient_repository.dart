import 'package:cross_file/cross_file.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_repository.g.dart';

abstract class PatientRepository {
  TaskResult<Patient> get(String id);
  TaskResult<PageResults<Patient>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
  });
  TaskResult<void> delete(String id);
  TaskResult<void> softDeleteMulti(List<String> ids);
  TaskResult<Patient> update(
    Patient patient,
    Map<String, dynamic> update, {
    List<XFile> files = const [],
  });

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
      return Patient.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<Patient> create(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload);
      return Patient.customFromMap(response.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<PageResults<Patient>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getList(
        filter: filter,
        page: pageNo,
        perPage: pageSize,
      );
      print(result);
      return PageResults(
        page: result.page,
        perPage: result.perPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        items: result.items.map<Patient>((e) {
          return Patient.customFromMap(e.toJson());
        }).toList(),
      );
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<Patient> update(
    Patient patient,
    Map<String, dynamic> update, {
    List<XFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final patientMap = patient.toMap();
      final combinedMap = {...patientMap, ...update};
      final result = await collection.update(
        patient.id,
        body: combinedMap,
      );
      return Patient.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final batchCollection = batch.collection(PocketBaseCollections.patients);
      for (final id in ids) {
        batchCollection.update(id, body: {'isDeleted': true});
      }

      await batch.send();
    }, Failure.tryCatchData);
  }
}
