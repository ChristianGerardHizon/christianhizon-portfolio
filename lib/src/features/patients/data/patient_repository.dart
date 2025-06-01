import 'package:sannjosevet/src/core/models/pb_repository.dart';
import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/packages/pocketbase.dart';
import 'package:sannjosevet/src/core/packages/pocketbase_collections.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/models/page_results.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/strings/pb_expand.dart';
import 'package:sannjosevet/src/features/patients/domain/patient.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_repository.g.dart';

@Riverpod(keepAlive: true)
PBCollectionRepository<Patient> patientRepository(Ref ref) {
  return PatientRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class PatientRepositoryImpl extends PBCollectionRepository<Patient> {
  final PocketBase pb;

  PatientRepositoryImpl({required this.pb});

  final String expand = PBExpand.patient.toString();

  RecordService get collection => pb.collection(PocketBaseCollections.patients);

  Patient mapToData(Map<String, dynamic> map) {
    return Patient.fromMap({...map, 'domain': pb.baseURL});
  }

  @override
  TaskResult<Patient> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id, expand: expand);
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<Patient> create(
    Map<String, dynamic> payload, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(
        body: payload,
        expand: expand,
        files: files,
      );
      return mapToData(response.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.handle);
  }

  @override
  TaskResult<PageResults<Patient>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
    String? sort,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getList(
        filter: filter,
        page: pageNo,
        perPage: pageSize,
        expand: expand,
      );
      return PageResults(
        page: result.page,
        perPage: result.perPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        items: result.items.map<Patient>((e) {
          return mapToData(e.toJson());
        }).toList(),
      );
    }, Failure.handle);
  }

  @override
  TaskResult<Patient> update(
    Patient patient,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final patientMap = patient.toMap();
      final combinedMap = {...patientMap, ...update};
      final result = await collection.update(
        patient.id,
        body: combinedMap,
        files: files,
        expand: expand,
      );
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final batchCollection = batch.collection(PocketBaseCollections.patients);
      for (final id in ids) {
        batchCollection.update(id, body: {PatientField.isDeleted: true});
      }

      await batch.send();
    }, Failure.handle);
  }

  @override
  TaskResult<List<Patient>> listAll({
    int batch = 500,
    String? filter,
    String? sort,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getFullList(
          filter: filter,
          sort: sort,
        );
        return result.map<Patient>((e) => mapToData(e.toJson())).toList();
      },
      Failure.handle,
    );
  }
}
