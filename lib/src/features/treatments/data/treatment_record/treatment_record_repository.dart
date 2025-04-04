import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/packages/pocketbase_sort_value.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/treatments/domain/treatment_record.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'treatment_record_repository.g.dart';

abstract class TreatmentRecordRepository {
  TaskResult<TreatmentRecord> get(String id);
  TaskResult<PageResults<TreatmentRecord>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
    PocketbaseSortValue? sort,
  });
  TaskResult<List<TreatmentRecord>> listAll({
    int batch = 500,
    String? filter,
  });
  TaskResult<void> delete(String id);
  TaskResult<void> softDeleteMulti(List<String> ids);
  TaskResult<TreatmentRecord> update(
    TreatmentRecord treatment,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  });

  TaskResult<TreatmentRecord> create(Map<String, dynamic> payload);
}

@Riverpod(keepAlive: true)
TreatmentRecordRepository treatmentRecordRepository(Ref ref) {
  return TreatmentRecordRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class TreatmentRecordRepositoryImpl extends TreatmentRecordRepository {
  final PocketBase pb;

  TreatmentRecordRepositoryImpl({required this.pb});

  RecordService get collection =>
      pb.collection(PocketBaseCollections.treatmentRecords);

  final expand = 'type';

  TreatmentRecord mapToData(Map<String, dynamic> map) {
    return TreatmentRecord.fromMap({...map, 'domain': pb.baseURL});
  }

  @override
  TaskResult<TreatmentRecord> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id, expand: expand);
      return mapToData(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<TreatmentRecord> create(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload);
      return mapToData(response.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<PageResults<TreatmentRecord>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
    PocketbaseSortValue? sort,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getList(
        filter: filter,
        page: pageNo,
        perPage: pageSize,
        sort: sort?.value,
        expand: expand,
      );
      return PageResults(
        page: result.page,
        perPage: result.perPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        items: result.items.map<TreatmentRecord>((e) {
          return mapToData({
            ...e.toJson(),
            'expand': {
              'type': e.get('expand.type'),
            },
          });
        }).toList(),
      );
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<TreatmentRecord> update(
    TreatmentRecord treatment,
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
    }, Failure.tryCatchData);
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
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<List<TreatmentRecord>> listAll({
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
            .map<TreatmentRecord>((e) => mapToData(e.toJson()))
            .toList();
      },
      Failure.tryCatchData,
    );
  }
}
