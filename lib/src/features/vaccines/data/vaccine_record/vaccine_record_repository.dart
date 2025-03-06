import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/vaccines/domain/vaccine_record.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vaccine_record_repository.g.dart';

abstract class VaccineRecordRepository {
  TaskResult<VaccineRecord> get(String id);
  TaskResult<PageResults<VaccineRecord>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
  });
  TaskResult<List<VaccineRecord>> listAll({
    int batch = 500,
    String? filter,
  });
  TaskResult<void> delete(String id);
  TaskResult<void> softDeleteMulti(List<String> ids);
  TaskResult<VaccineRecord> update(
    VaccineRecord history,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  });

  TaskResult<VaccineRecord> create(Map<String, dynamic> payload);
}

@Riverpod(keepAlive: true)
VaccineRecordRepository historyRepository(Ref ref) {
  return VaccineRecordRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class VaccineRecordRepositoryImpl extends VaccineRecordRepository {
  final PocketBase pb;

  VaccineRecordRepositoryImpl({required this.pb});

  RecordService get collection =>
      pb.collection(PocketBaseCollections.vaccineRecords);

  @override
  TaskResult<VaccineRecord> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id);
      return VaccineRecord.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<VaccineRecord> create(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload);
      return VaccineRecord.customFromMap(response.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<PageResults<VaccineRecord>> list({
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
        items: result.items.map<VaccineRecord>((e) {
          return VaccineRecord.customFromMap(e.toJson());
        }).toList(),
      );
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<VaccineRecord> update(
    VaccineRecord history,
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
      return VaccineRecord.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final batchCollection =
          batch.collection(PocketBaseCollections.vaccineRecords);
      for (final id in ids) {
        batchCollection.update(id, body: {'isDeleted': true});
      }

      await batch.send();
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<List<VaccineRecord>> listAll({
    int batch = 500,
    String? filter,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getFullList(
          filter: filter,
        );
        return result
            .map<VaccineRecord>((e) => VaccineRecord.customFromMap(e.toJson()))
            .toList();
      },
      Failure.tryCatchData,
    );
  }
}
