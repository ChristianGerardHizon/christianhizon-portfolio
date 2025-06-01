import 'package:sannjosevet/src/core/models/pb_repository.dart';
import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/packages/pocketbase.dart';
import 'package:sannjosevet/src/core/packages/pocketbase_collections.dart';
import 'package:sannjosevet/src/core/models/page_results.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/strings/pb_expand.dart';
import 'package:sannjosevet/src/features/appointment_schedules/domain/appointment_schedule.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_schedule_repository.g.dart';

@Riverpod(keepAlive: true)
PBCollectionRepository<AppointmentSchedule> appointmentScheduleRepository(
    Ref ref) {
  return AppointmentScheduleRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class AppointmentScheduleRepositoryImpl
    extends PBCollectionRepository<AppointmentSchedule> {
  final PocketBase pb;

  AppointmentScheduleRepositoryImpl({required this.pb});

  RecordService get collection =>
      pb.collection(PocketBaseCollections.appointmentSchedules);

  AppointmentSchedule mapToData(Map<String, dynamic> map) {
    return AppointmentSchedule.fromMap({...map, 'domain': pb.baseURL});
  }

  final expand = PBExpand.appointmentSchedule.toString();

  @override
  TaskResult<AppointmentSchedule> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id, expand: expand);
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<AppointmentSchedule> create(
    Map<String, dynamic> payload, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final response =
          await collection.create(body: payload, files: files, expand: expand);
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
  TaskResult<PageResults<AppointmentSchedule>> list({
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
        sort: sort,
      );
      return PageResults(
        page: result.page,
        perPage: result.perPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        items: result.items.map<AppointmentSchedule>((e) {
          return mapToData(e.toJson());
        }).toList(),
      );
    }, Failure.handle);
  }

  @override
  TaskResult<AppointmentSchedule> update(
    AppointmentSchedule appointmentSchedule,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final appointmentScheduleMap = appointmentSchedule.toMap();
      final combinedMap = {...appointmentScheduleMap, ...update};
      final result = await collection.update(
        appointmentSchedule.id,
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
          batch.collection(PocketBaseCollections.appointmentSchedules);
      for (final id in ids) {
        batchCollection.update(id, body: {'isDeleted': true});
      }

      await batch.send();
    }, Failure.handle);
  }

  @override
  TaskResult<List<AppointmentSchedule>> listAll({
    int batch = 500,
    String? filter,
    String? sort,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getFullList(
          filter: filter,
          expand: expand,
          sort: sort,
        );
        return result
            .map<AppointmentSchedule>((e) => mapToData(e.toJson()))
            .toList();
      },
      Failure.handle,
    );
  }
}
