import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pb_filter.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/treatment_plan_item.dart';
import '../../domain/treatment_plan_item_status.dart';
import '../dto/treatment_plan_item_dto.dart';

part 'treatment_plan_item_repository.g.dart';

/// Repository interface for treatment plan items.
abstract class TreatmentPlanItemRepository {
  /// Fetches all items for a treatment plan.
  FutureEither<List<TreatmentPlanItem>> fetchByPlan(String planId);

  /// Fetches a single item by ID.
  FutureEither<TreatmentPlanItem> fetchOne(String id);

  /// Creates a new item.
  FutureEither<TreatmentPlanItem> create(TreatmentPlanItem item);

  /// Updates an existing item.
  FutureEither<TreatmentPlanItem> update(TreatmentPlanItem item);

  /// Updates the status of an item.
  FutureEither<TreatmentPlanItem> updateStatus(
    String id,
    TreatmentPlanItemStatus status, {
    DateTime? completedDate,
  });

  /// Links an appointment to an item and updates status to booked.
  FutureEither<TreatmentPlanItem> linkAppointment(
    String itemId,
    String appointmentId,
  );

  /// Unlinks an appointment from an item (when appointment is cancelled).
  FutureEither<TreatmentPlanItem> unlinkAppointment(String itemId);

  /// Reschedules an item to a new date.
  FutureEither<TreatmentPlanItem> reschedule(String id, DateTime newDate);

  /// Deletes an item (soft delete).
  FutureEither<void> delete(String id);

  /// Fetches upcoming scheduled items within the given days.
  FutureEither<List<TreatmentPlanItem>> fetchUpcoming(int daysAhead);
}

/// Provider for the treatment plan item repository.
@Riverpod(keepAlive: true)
TreatmentPlanItemRepository treatmentPlanItemRepository(Ref ref) {
  return TreatmentPlanItemRepositoryImpl(ref.watch(pocketbaseProvider));
}

/// Implementation of the treatment plan item repository.
class TreatmentPlanItemRepositoryImpl implements TreatmentPlanItemRepository {
  final PocketBase _pb;

  TreatmentPlanItemRepositoryImpl(this._pb);

  RecordService get _collection =>
      _pb.collection(PocketBaseCollections.treatmentPlanItems);

  @override
  FutureEither<List<TreatmentPlanItem>> fetchByPlan(String planId) async {
    return TaskEither.tryCatch(
      () async {
        final filter = PBFilter()
            .equals('plan', planId)
            .notDeleted()
            .build();
        final records = await _collection.getFullList(
          filter: filter,
          expand: 'appointment',
          sort: 'sequence',
        );
        return records
            .map((r) => TreatmentPlanItemDto.fromRecord(r).toEntity())
            .toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<TreatmentPlanItem> fetchOne(String id) async {
    return TaskEither.tryCatch(
      () async {
        final record = await _collection.getOne(id, expand: 'appointment');
        return TreatmentPlanItemDto.fromRecord(record).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<TreatmentPlanItem> create(TreatmentPlanItem item) async {
    return TaskEither.tryCatch(
      () async {
        final created = await _collection.create(
          body: TreatmentPlanItemDto.toCreateJson(item),
        );
        return TreatmentPlanItemDto.fromRecord(created).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<TreatmentPlanItem> update(TreatmentPlanItem item) async {
    return TaskEither.tryCatch(
      () async {
        final updated = await _collection.update(
          item.id,
          body: TreatmentPlanItemDto.toCreateJson(item),
          expand: 'appointment',
        );
        return TreatmentPlanItemDto.fromRecord(updated).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<TreatmentPlanItem> updateStatus(
    String id,
    TreatmentPlanItemStatus status, {
    DateTime? completedDate,
  }) async {
    return TaskEither.tryCatch(
      () async {
        final updated = await _collection.update(
          id,
          body: TreatmentPlanItemDto.toUpdateStatusJson(
            status,
            completedDate: completedDate,
          ),
          expand: 'appointment',
        );
        return TreatmentPlanItemDto.fromRecord(updated).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<TreatmentPlanItem> linkAppointment(
    String itemId,
    String appointmentId,
  ) async {
    return TaskEither.tryCatch(
      () async {
        final updated = await _collection.update(
          itemId,
          body: TreatmentPlanItemDto.toLinkAppointmentJson(
            appointmentId,
            TreatmentPlanItemStatus.booked,
          ),
          expand: 'appointment',
        );
        return TreatmentPlanItemDto.fromRecord(updated).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<TreatmentPlanItem> unlinkAppointment(String itemId) async {
    return TaskEither.tryCatch(
      () async {
        final updated = await _collection.update(
          itemId,
          body: {
            'appointment': null,
            'status': TreatmentPlanItemStatus.scheduled.pocketbaseValue,
          },
          expand: 'appointment',
        );
        return TreatmentPlanItemDto.fromRecord(updated).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<TreatmentPlanItem> reschedule(String id, DateTime newDate) async {
    return TaskEither.tryCatch(
      () async {
        final updated = await _collection.update(
          id,
          body: {'expectedDate': newDate.toUtcIso8601()},
          expand: 'appointment',
        );
        return TreatmentPlanItemDto.fromRecord(updated).toEntity();
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

  @override
  FutureEither<List<TreatmentPlanItem>> fetchUpcoming(int daysAhead) async {
    return TaskEither.tryCatch(
      () async {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final futureDate = today.add(Duration(days: daysAhead));

        final filter = PBFilter()
            .equals('status', 'scheduled')
            .notDeleted()
            .between('expectedDate', today, futureDate)
            .build();

        final records = await _collection.getFullList(
          filter: filter,
          expand: 'appointment,plan.patient,plan.treatment',
          sort: 'expectedDate',
        );
        return records
            .map((r) => TreatmentPlanItemDto.fromRecord(r).toEntity())
            .toList();
      },
      Failure.handle,
    ).run();
  }
}
