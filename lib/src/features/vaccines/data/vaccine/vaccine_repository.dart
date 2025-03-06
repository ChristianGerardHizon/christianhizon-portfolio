import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/vaccines/domain/vaccine.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vaccine_repository.g.dart';

abstract class VaccineRepository {
  TaskResult<Vaccine> get(String id);
  TaskResult<PageResults<Vaccine>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
  });
  TaskResult<List<Vaccine>> listAll({
    int batch = 500,
    String? filter,
  });
  TaskResult<void> delete(String id);
  TaskResult<void> softDeleteMulti(List<String> ids);
  TaskResult<Vaccine> update(
    Vaccine historyType,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  });

  TaskResult<Vaccine> create(Map<String, dynamic> payload);
}

@Riverpod(keepAlive: true)
VaccineRepository historyTypeRepository(Ref ref) {
  return VaccineRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class VaccineRepositoryImpl extends VaccineRepository {
  final PocketBase pb;

  VaccineRepositoryImpl({required this.pb});

  RecordService get collection => pb.collection(PocketBaseCollections.vaccines);

  @override
  TaskResult<Vaccine> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id);
      return Vaccine.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<Vaccine> create(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload);
      return Vaccine.customFromMap(response.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<PageResults<Vaccine>> list({
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
        items: result.items.map<Vaccine>((e) {
          return Vaccine.customFromMap(e.toJson());
        }).toList(),
      );
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<Vaccine> update(
    Vaccine historyType,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final historyTypeMap = historyType.toMap();
      final combinedMap = {...historyTypeMap, ...update};
      final result = await collection.update(
        historyType.id,
        body: combinedMap,
        files: files,
      );
      return Vaccine.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final batchCollection = batch.collection(PocketBaseCollections.vaccines);
      for (final id in ids) {
        batchCollection.update(id, body: {'isDeleted': true});
      }

      await batch.send();
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<List<Vaccine>> listAll({
    int batch = 500,
    String? filter,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getFullList(
        filter: filter,
      );
      return result
          .map<Vaccine>(
            (e) => Vaccine.customFromMap(e.toJson()),
          )
          .toList();
    }, Failure.tryCatchData);
  }
}
