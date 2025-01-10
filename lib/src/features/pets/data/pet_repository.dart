import 'package:cross_file/cross_file.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/pets/domain/pet.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pet_repository.g.dart';

abstract class PetRepository {
  TaskResult<Pet> get(String id);
  TaskResult<PageResults<Pet>> list({
    String? query,
    required int pageNo,
    required int pageSize,
  });
  TaskResult<void> delete(String id);
  TaskResult<Pet> update(
    Pet pet,
    Map<String, dynamic> update, {
    List<XFile> files = const [],
  });

  TaskResult<Pet> create(Map<String, dynamic> payload);
}

@Riverpod(keepAlive: true)
PetRepository petRepository(Ref ref) {
  return PetRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class PetRepositoryImpl extends PetRepository {
  final PocketBase pb;

  PetRepositoryImpl({required this.pb});

  RecordService get collection => pb.collection(PocketBaseCollections.pets);

  @override
  TaskResult<Pet> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id);
      return Pet.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<Pet> create(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload);
      return Pet.customFromMap(response.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      throw UnimplementedError();
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<PageResults<Pet>> list({
    String? query,
    required int pageNo,
    required int pageSize,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getList(
        page: pageNo,
        perPage: pageSize,
      );
      print(result);
      return PageResults(
        page: result.page,
        perPage: result.perPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        items: result.items.map<Pet>((e) {
          return Pet.customFromMap(e.toJson());
        }).toList(),
      );
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<Pet> update(
    Pet pet,
    Map<String, dynamic> update, {
    List<XFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final petMap = pet.toMap();
      final combinedMap = {...petMap, ...update};
      final result = await collection.update(
        pet.id,
        body: combinedMap,
      );
      return Pet.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }
}
