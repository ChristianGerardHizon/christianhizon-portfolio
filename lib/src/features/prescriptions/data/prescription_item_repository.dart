import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/prescriptions/domain/prescription_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prescription_item_repository.g.dart';

abstract class PrescriptionItemRepository {
  TaskResult<PrescriptionItem> get(String id);
  TaskResult<PageResults<PrescriptionItem>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
  });
  TaskResult<List<PrescriptionItem>> listAll({
    int batch = 500,
    String? filter,
  });
  TaskResult<void> delete(String id);
  TaskResult<void> softDeleteMulti(List<String> ids);
  TaskResult<PrescriptionItem> update(
    PrescriptionItem prescription,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  });

  TaskResult<PrescriptionItem> create(Map<String, dynamic> payload);
}

@Riverpod(keepAlive: true)
PrescriptionItemRepository prescriptionItemRepository(Ref ref) {
  return PrescriptionItemRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class PrescriptionItemRepositoryImpl extends PrescriptionItemRepository {
  final PocketBase pb;

  PrescriptionItemRepositoryImpl({required this.pb});

  RecordService get collection =>
      pb.collection(PocketBaseCollections.prescriptionItems);

  @override
  TaskResult<PrescriptionItem> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id);
      return PrescriptionItem.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<PrescriptionItem> create(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload);
      return PrescriptionItem.customFromMap(response.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<PageResults<PrescriptionItem>> list({
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
        items: result.items.map<PrescriptionItem>((e) {
          return PrescriptionItem.customFromMap(e.toJson());
        }).toList(),
      );
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<PrescriptionItem> update(
    PrescriptionItem prescription,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final prescriptionMap = prescription.toMap();
      final combinedMap = {...prescriptionMap, ...update};
      final result = await collection.update(
        prescription.id,
        body: combinedMap,
        files: files,
      );
      return PrescriptionItem.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final batchCollection =
          batch.collection(PocketBaseCollections.prescriptionItems);
      for (final id in ids) {
        batchCollection.update(id, body: {'isDeleted': true});
      }

      await batch.send();
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<List<PrescriptionItem>> listAll({
    int batch = 500,
    String? filter,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getFullList(
          filter: filter,
        );
        return result
            .map<PrescriptionItem>(
                (e) => PrescriptionItem.customFromMap(e.toJson()))
            .toList();
      },
      Failure.tryCatchData,
    );
  }
}
