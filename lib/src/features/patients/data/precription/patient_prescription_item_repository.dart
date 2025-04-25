import 'package:gym_system/src/core/classes/pb_repository.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/patients/domain/prescription/patient_prescription_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_prescription_item_repository.g.dart';

@Riverpod(keepAlive: true)
PBCollectionRepository<PrescriptionItem> patientPrescriptionItemRepository(
    Ref ref) {
  return PrescriptionItemRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class PrescriptionItemRepositoryImpl
    extends PBCollectionRepository<PrescriptionItem> {
  final PocketBase pb;

  PrescriptionItemRepositoryImpl({required this.pb});

  RecordService get collection =>
      pb.collection(PocketBaseCollections.prescriptionItems);

  PrescriptionItem mapToData(Map<String, dynamic> map) {
    return PrescriptionItem.fromMap({...map, 'domain': pb.baseURL});
  }

  @override
  TaskResult<PrescriptionItem> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id);
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<PrescriptionItem> create(
    Map<String, dynamic> payload, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload);
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
  TaskResult<PageResults<PrescriptionItem>> list({
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
      );
      return PageResults(
        page: result.page,
        perPage: result.perPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        items: result.items.map<PrescriptionItem>((e) {
          return mapToData(e.toJson());
        }).toList(),
      );
    }, Failure.handle);
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
      return mapToData(result.toJson());
    }, Failure.handle);
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
    }, Failure.handle);
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
            .map<PrescriptionItem>((e) => mapToData(e.toJson()))
            .toList();
      },
      Failure.handle,
    );
  }
}
