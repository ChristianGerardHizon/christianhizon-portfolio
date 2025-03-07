import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/medical_records/domain/medical_record.dart';
import 'package:gym_system/src/features/vaccines/domain/vaccine_record.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medical_repository.g.dart';

abstract class MedicalRecordRepository {
  TaskResult<MedicalRecord> get(String id);
  TaskResult<PageResults<MedicalRecord>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
  });
  TaskResult<List<MedicalRecord>> listAll({
    int batch = 500,
    String? filter,
  });
  TaskResult<void> delete(String id);
  TaskResult<void> softDeleteMulti(List<String> ids);
  TaskResult<MedicalRecord> update(
    MedicalRecord history,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  });

  TaskResult<MedicalRecord> create(Map<String, dynamic> payload);
}

@Riverpod(keepAlive: true)
MedicalRecordRepository historyRepository(Ref ref) {
  return MedicalRecordRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class MedicalRecordRepositoryImpl extends MedicalRecordRepository {
  final PocketBase pb;

  MedicalRecordRepositoryImpl({required this.pb});

  RecordService get collection =>
      pb.collection(PocketBaseCollections.medicalRecords);

  @override
  TaskResult<MedicalRecord> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id);
      return MedicalRecord.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<MedicalRecord> create(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload);
      return MedicalRecord.customFromMap(response.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<PageResults<MedicalRecord>> list({
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
      return PageResults(
        page: result.page,
        perPage: result.perPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        items: result.items.map<MedicalRecord>((e) {
          return MedicalRecord.customFromMap(e.toJson());
        }).toList(),
      );
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<MedicalRecord> update(
    MedicalRecord history,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final historyMap = history.toMap();
      final combinedMap = {...historyMap, ...update};
      final result = await collection.update(
        history.id,
        body: combinedMap,
        files: files,
      );
      return MedicalRecord.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final batchCollection =
          batch.collection(PocketBaseCollections.medicalRecords);
      for (final id in ids) {
        batchCollection.update(id, body: {'isDeleted': true});
      }

      await batch.send();
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<List<MedicalRecord>> listAll({
    int batch = 500,
    String? filter,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getFullList(
          filter: filter,
        );
        return result
            .map<MedicalRecord>((e) => MedicalRecord.customFromMap(e.toJson()))
            .toList();
      },
      Failure.tryCatchData,
    );
  }
}
