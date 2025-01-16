import 'package:cross_file/cross_file.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/staff/domain/staff.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'staff_repository.g.dart';

abstract class StaffRepository {
  TaskResult<Staff> get(String id);
  TaskResult<PageResults<Staff>> list({
    String? query,
    required int pageNo,
    required int pageSize,
  });
  TaskResult<void> delete(String id);
  TaskResult<Staff> update(
    Staff staff,
    Map<String, dynamic> update, {
    List<XFile> files = const [],
  });

  TaskResult<Staff> create(Map<String, dynamic> payload);
}

@Riverpod(keepAlive: true)
StaffRepository staffRepository(Ref ref) {
  return StaffRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class StaffRepositoryImpl extends StaffRepository {
  final PocketBase pb;

  StaffRepositoryImpl({required this.pb});

  RecordService get collection => pb.collection(PocketBaseCollections.staffs);

  @override
  TaskResult<Staff> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id);
      return Staff.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<Staff> create(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload);
      return Staff.customFromMap(response.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<PageResults<Staff>> list({
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
        items: result.items.map<Staff>((e) {
          return Staff.customFromMap(e.toJson());
        }).toList(),
      );
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<Staff> update(
    Staff staff,
    Map<String, dynamic> update, {
    List<XFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final staffMap = staff.toMap();
      final combinedMap = {...staffMap, ...update};
      final result = await collection.update(
        staff.id,
        body: combinedMap,
      );
      return Staff.customFromMap(result.toJson());
    }, Failure.tryCatchData);
  }
}
