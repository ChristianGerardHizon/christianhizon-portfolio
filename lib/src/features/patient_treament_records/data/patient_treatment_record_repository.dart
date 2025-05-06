import 'package:gym_system/src/core/models/pb_repository.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/models/page_results.dart';
import 'package:gym_system/src/core/strings/pb_expand.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/features/patient_treament_records/domain/patient_treatment_record.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_treatment_record_repository.g.dart';

@Riverpod(keepAlive: true)
PBCollectionRepository<PatientTreatmentRecord> patientTreatmentRecordRepository(
    Ref ref) {
  return PatientTreatmentRecordRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class PatientTreatmentRecordRepositoryImpl
    extends PBCollectionRepository<PatientTreatmentRecord> {
  final PocketBase pb;

  PatientTreatmentRecordRepositoryImpl({required this.pb});

  RecordService get collection =>
      pb.collection(PocketBaseCollections.treatmentRecords);

  final expand = PBExpand.patientTreatmentRecord;

  PatientTreatmentRecord mapToData(Map<String, dynamic> map) {
    return PatientTreatmentRecord.fromMap({...map, 'domain': pb.baseURL});
  }

  @override
  TaskResult<PatientTreatmentRecord> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id, expand: expand);
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<PatientTreatmentRecord> create(
    Map<String, dynamic> payload, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(
        body: payload,
        files: files,
        expand: expand,
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
  TaskResult<PageResults<PatientTreatmentRecord>> list({
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
        sort: sort,
        expand: expand,
      );

      return PageResults(
        page: result.page,
        perPage: result.perPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        items: result.items.map<PatientTreatmentRecord>((e) {
          return mapToData({
            ...e.toJson(),
          });
        }).toList(),
      );
    }, Failure.handle);
  }

  @override
  TaskResult<PatientTreatmentRecord> update(
    PatientTreatmentRecord treatment,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final treatmentMap = treatment.toMap();
      final combinedMap = {...treatmentMap, ...update};
      final result = await collection.update(
        treatment.id,
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
      final batchCollection =
          batch.collection(PocketBaseCollections.treatmentRecords);
      for (final id in ids) {
        batchCollection.update(id, body: {'isDeleted': true});
      }

      await batch.send();
    }, Failure.handle);
  }

  @override
  TaskResult<List<PatientTreatmentRecord>> listAll({
    int batch = 500,
    String? filter,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getFullList(
          filter: filter,
          expand: expand,
        );
        return result
            .map<PatientTreatmentRecord>((e) => mapToData(e.toJson()))
            .toList();
      },
      Failure.handle,
    );
  }
}
