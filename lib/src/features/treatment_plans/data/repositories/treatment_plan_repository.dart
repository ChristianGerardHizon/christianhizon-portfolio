import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pb_filter.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/treatment_plan.dart';
import '../../domain/treatment_plan_item.dart';
import '../../domain/treatment_plan_item_status.dart';
import '../../domain/treatment_plan_status.dart';
import '../dto/treatment_plan_dto.dart';
import '../dto/treatment_plan_item_dto.dart';

part 'treatment_plan_repository.g.dart';

/// Repository interface for treatment plans.
abstract class TreatmentPlanRepository {
  /// Fetches all treatment plans for a patient.
  FutureEither<List<TreatmentPlan>> fetchByPatient(String patientId);

  /// Fetches only active treatment plans for a patient.
  FutureEither<List<TreatmentPlan>> fetchActiveByPatient(String patientId);

  /// Fetches a single plan by ID with all items.
  FutureEither<TreatmentPlan> fetchOne(String id);

  /// Creates a new treatment plan.
  FutureEither<TreatmentPlan> create(TreatmentPlan plan);

  /// Updates an existing treatment plan.
  FutureEither<TreatmentPlan> update(TreatmentPlan plan);

  /// Updates the status of a treatment plan.
  FutureEither<TreatmentPlan> updateStatus(String id, TreatmentPlanStatus status);

  /// Deletes a treatment plan (soft delete).
  FutureEither<void> delete(String id);

  /// Creates a treatment plan with all its items in a batch operation.
  FutureEither<TreatmentPlan> createPlanWithItems(
    TreatmentPlan plan,
    List<DateTime> scheduledDates,
  );
}

/// Provider for the treatment plan repository.
@Riverpod(keepAlive: true)
TreatmentPlanRepository treatmentPlanRepository(Ref ref) {
  return TreatmentPlanRepositoryImpl(ref.watch(pocketbaseProvider));
}

/// Implementation of the treatment plan repository.
class TreatmentPlanRepositoryImpl implements TreatmentPlanRepository {
  final PocketBase _pb;

  TreatmentPlanRepositoryImpl(this._pb);

  RecordService get _planCollection =>
      _pb.collection(PocketBaseCollections.treatmentPlans);

  RecordService get _itemCollection =>
      _pb.collection(PocketBaseCollections.treatmentPlanItems);

  static const String _defaultExpand =
      'patient,treatment,treatmentPlanItems_via_plan';

  @override
  FutureEither<List<TreatmentPlan>> fetchByPatient(String patientId) async {
    return TaskEither.tryCatch(
      () async {
        final filter = PBFilters.forPatient(patientId).build();
        final records = await _planCollection.getFullList(
          filter: filter,
          expand: _defaultExpand,
          sort: '-startDate',
        );
        return records
            .map((r) => TreatmentPlanDto.fromRecord(r).toEntity())
            .toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<List<TreatmentPlan>> fetchActiveByPatient(
    String patientId,
  ) async {
    return TaskEither.tryCatch(
      () async {
        final filter = PBFilter()
            .equals('patient', patientId)
            .equals('status', 'active')
            .notDeleted()
            .build();
        final records = await _planCollection.getFullList(
          filter: filter,
          expand: _defaultExpand,
          sort: '-startDate',
        );
        return records
            .map((r) => TreatmentPlanDto.fromRecord(r).toEntity())
            .toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<TreatmentPlan> fetchOne(String id) async {
    return TaskEither.tryCatch(
      () async {
        final record = await _planCollection.getOne(id, expand: _defaultExpand);
        return TreatmentPlanDto.fromRecord(record).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<TreatmentPlan> create(TreatmentPlan plan) async {
    return TaskEither.tryCatch(
      () async {
        final created = await _planCollection.create(
          body: TreatmentPlanDto.toCreateJson(plan),
          expand: _defaultExpand,
        );
        return TreatmentPlanDto.fromRecord(created).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<TreatmentPlan> update(TreatmentPlan plan) async {
    return TaskEither.tryCatch(
      () async {
        final updated = await _planCollection.update(
          plan.id,
          body: TreatmentPlanDto.toCreateJson(plan),
          expand: _defaultExpand,
        );
        return TreatmentPlanDto.fromRecord(updated).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<TreatmentPlan> updateStatus(
    String id,
    TreatmentPlanStatus status,
  ) async {
    return TaskEither.tryCatch(
      () async {
        final updated = await _planCollection.update(
          id,
          body: TreatmentPlanDto.toUpdateStatusJson(status),
          expand: _defaultExpand,
        );
        return TreatmentPlanDto.fromRecord(updated).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<void> delete(String id) async {
    return TaskEither.tryCatch(
      () async {
        await _planCollection.update(id, body: {'isDeleted': true});
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<TreatmentPlan> createPlanWithItems(
    TreatmentPlan plan,
    List<DateTime> scheduledDates,
  ) async {
    return TaskEither.tryCatch(
      () async {
        // 1. Create the plan first
        final createdPlan = await _planCollection.create(
          body: TreatmentPlanDto.toCreateJson(plan),
          expand: 'patient,treatment',
        );
        final planEntity = TreatmentPlanDto.fromRecord(createdPlan).toEntity();

        // 2. Create all items
        final items = <TreatmentPlanItem>[];
        for (var i = 0; i < scheduledDates.length; i++) {
          final item = TreatmentPlanItem(
            id: '',
            planId: planEntity.id,
            sequence: i + 1,
            expectedDate: scheduledDates[i],
            status: TreatmentPlanItemStatus.scheduled,
          );
          final createdItem = await _itemCollection.create(
            body: TreatmentPlanItemDto.toCreateJson(item),
          );
          items.add(TreatmentPlanItemDto.fromRecord(createdItem).toEntity());
        }

        // 3. Return plan with items
        return planEntity.copyWith(items: items);
      },
      Failure.handle,
    ).run();
  }
}
