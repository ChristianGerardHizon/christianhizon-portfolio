import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pb_expand.dart' show PBExpand;
import '../../../../core/packages/pocketbase/pb_filter.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/appointment_schedule.dart';
import '../dto/appointment_schedule_dto.dart';

part 'appointment_schedule_repository.g.dart';

/// Repository interface for appointment schedules.
abstract class AppointmentScheduleRepository {
  /// Fetches all appointments.
  FutureEither<List<AppointmentSchedule>> fetchAll();

  /// Fetches appointments with pagination.
  FutureEitherPaginated<AppointmentSchedule> fetchPaginated({
    int page = 1,
    int perPage = Pagination.defaultPageSize,
    String? sort,
    String? filter,
  });

  /// Fetches all appointments for a specific patient.
  FutureEither<List<AppointmentSchedule>> fetchByPatient(String patientId);

  /// Fetches appointments for a specific patient with pagination.
  FutureEitherPaginated<AppointmentSchedule> fetchByPatientPaginated(
    String patientId, {
    int page = 1,
    int perPage = Pagination.defaultPageSize,
  });

  /// Fetches appointments within a date range.
  FutureEither<List<AppointmentSchedule>> fetchByDateRange(
    DateTime start,
    DateTime end, {
    String? filter,
  });

  /// Fetches appointments for a specific date.
  FutureEither<List<AppointmentSchedule>> fetchByDate(
    DateTime date, {
    String? filter,
  });

  /// Fetches a single appointment by ID.
  FutureEither<AppointmentSchedule> fetchOne(String id);

  /// Creates a new appointment.
  FutureEither<AppointmentSchedule> create(AppointmentSchedule appointment);

  /// Updates an existing appointment.
  FutureEither<AppointmentSchedule> update(AppointmentSchedule appointment);

  /// Updates an appointment's status.
  FutureEither<AppointmentSchedule> updateStatus(
    String id,
    AppointmentScheduleStatus status,
  );

  /// Deletes an appointment (soft delete).
  FutureEither<void> delete(String id);
}

/// Provider for the appointment schedule repository.
@Riverpod(keepAlive: true)
AppointmentScheduleRepository appointmentScheduleRepository(Ref ref) {
  return AppointmentScheduleRepositoryImpl(ref.watch(pocketbaseProvider));
}

/// Implementation of the appointment schedule repository.
class AppointmentScheduleRepositoryImpl implements AppointmentScheduleRepository {
  final PocketBase _pb;

  AppointmentScheduleRepositoryImpl(this._pb);

  RecordService get _collection =>
      _pb.collection(PocketBaseCollections.appointments);

  @override
  FutureEither<List<AppointmentSchedule>> fetchAll() async {
    return TaskEither.tryCatch(
      () async {
        final records = await _collection.getFullList(
          filter: PBFilters.active.build(),
          sort: '-date',
          expand: PBExpand.appointment.toString(),
        );
        return records
            .map((r) => AppointmentScheduleDto.fromRecord(r).toEntity())
            .toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEitherPaginated<AppointmentSchedule> fetchPaginated({
    int page = 1,
    int perPage = Pagination.defaultPageSize,
    String? sort,
    String? filter,
  }) async {
    return TaskEither.tryCatch(
      () async {
        final baseFilter = PBFilters.active.build();
        final filterString =
            filter != null ? '$baseFilter && $filter' : baseFilter;

        final result = await _collection.getList(
          page: page,
          perPage: perPage,
          filter: filterString,
          sort: sort ?? '-date',
          expand: PBExpand.appointment.toString(),
        );
        return PaginatedResult<AppointmentSchedule>(
          items: result.items
              .map((r) => AppointmentScheduleDto.fromRecord(r).toEntity())
              .toList(),
          page: result.page,
          totalItems: result.totalItems,
          totalPages: result.totalPages,
        );
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<List<AppointmentSchedule>> fetchByPatient(String patientId) async {
    return TaskEither.tryCatch(
      () async {
        final records = await _collection.getFullList(
          filter: PBFilters.forPatient(patientId).build(),
          sort: '-date',
          expand: PBExpand.appointment.toString(),
        );
        return records
            .map((r) => AppointmentScheduleDto.fromRecord(r).toEntity())
            .toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEitherPaginated<AppointmentSchedule> fetchByPatientPaginated(
    String patientId, {
    int page = 1,
    int perPage = Pagination.defaultPageSize,
  }) async {
    return TaskEither.tryCatch(
      () async {
        final result = await _collection.getList(
          page: page,
          perPage: perPage,
          filter: PBFilters.forPatient(patientId).build(),
          sort: '-date',
          expand: PBExpand.appointment.toString(),
        );
        return PaginatedResult<AppointmentSchedule>(
          items: result.items
              .map((r) => AppointmentScheduleDto.fromRecord(r).toEntity())
              .toList(),
          page: result.page,
          totalItems: result.totalItems,
          totalPages: result.totalPages,
        );
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<List<AppointmentSchedule>> fetchByDateRange(
    DateTime start,
    DateTime end, {
    String? filter,
  }) async {
    return TaskEither.tryCatch(
      () async {
        final dateFilter = PBFilter()
            .between('date', start, end)
            .notDeleted();
        final baseFilter = dateFilter.build();
        final filterString =
            filter != null ? '$baseFilter && $filter' : baseFilter;

        final records = await _collection.getFullList(
          filter: filterString,
          sort: 'date',
          expand: PBExpand.appointment.toString(),
        );
        return records
            .map((r) => AppointmentScheduleDto.fromRecord(r).toEntity())
            .toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<List<AppointmentSchedule>> fetchByDate(
    DateTime date, {
    String? filter,
  }) async {
    // Get start and end of the day
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    return fetchByDateRange(startOfDay, endOfDay, filter: filter);
  }

  @override
  FutureEither<AppointmentSchedule> fetchOne(String id) async {
    return TaskEither.tryCatch(
      () async {
        final record = await _collection.getOne(
          id,
          expand: PBExpand.appointment.toString(),
        );
        return AppointmentScheduleDto.fromRecord(record).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<AppointmentSchedule> create(AppointmentSchedule appointment) async {
    return TaskEither.tryCatch(
      () async {
        final created = await _collection.create(
          body: AppointmentScheduleDto.toCreateJson(appointment),
          expand: PBExpand.appointment.toString(),
        );
        return AppointmentScheduleDto.fromRecord(created).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<AppointmentSchedule> update(AppointmentSchedule appointment) async {
    return TaskEither.tryCatch(
      () async {
        final updated = await _collection.update(
          appointment.id,
          body: AppointmentScheduleDto.toCreateJson(appointment),
          expand: PBExpand.appointment.toString(),
        );
        return AppointmentScheduleDto.fromRecord(updated).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<AppointmentSchedule> updateStatus(
    String id,
    AppointmentScheduleStatus status,
  ) async {
    return TaskEither.tryCatch(
      () async {
        final updated = await _collection.update(
          id,
          body: AppointmentScheduleDto.toStatusJson(status),
          expand: PBExpand.appointment.toString(),
        );
        return AppointmentScheduleDto.fromRecord(updated).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<void> delete(String id) async {
    return TaskEither.tryCatch(
      () async {
        await _collection.update(id, body: {'isDeleted': true});
      },
      Failure.handle,
    ).run();
  }
}
