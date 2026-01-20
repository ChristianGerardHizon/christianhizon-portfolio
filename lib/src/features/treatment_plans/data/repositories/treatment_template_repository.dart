import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pb_filter.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/treatment_template.dart';
import '../dto/treatment_template_dto.dart';

part 'treatment_template_repository.g.dart';

/// Repository interface for treatment templates.
abstract class TreatmentTemplateRepository {
  /// Fetches all treatment templates.
  FutureEither<List<TreatmentTemplate>> fetchAll();

  /// Fetches a single template by ID.
  FutureEither<TreatmentTemplate> fetchOne(String id);

  /// Fetches templates by treatment ID.
  FutureEither<List<TreatmentTemplate>> fetchByTreatment(String treatmentId);

  /// Creates a new template.
  FutureEither<TreatmentTemplate> create(TreatmentTemplate template);

  /// Updates an existing template.
  FutureEither<TreatmentTemplate> update(TreatmentTemplate template);

  /// Deletes a template (soft delete).
  FutureEither<void> delete(String id);
}

/// Provider for the treatment template repository.
@Riverpod(keepAlive: true)
TreatmentTemplateRepository treatmentTemplateRepository(Ref ref) {
  return TreatmentTemplateRepositoryImpl(ref.watch(pocketbaseProvider));
}

/// Implementation of the treatment template repository.
class TreatmentTemplateRepositoryImpl implements TreatmentTemplateRepository {
  final PocketBase _pb;

  TreatmentTemplateRepositoryImpl(this._pb);

  RecordService get _collection =>
      _pb.collection(PocketBaseCollections.treatmentTemplates);

  @override
  FutureEither<List<TreatmentTemplate>> fetchAll() async {
    return TaskEither.tryCatch(
      () async {
        final records = await _collection.getFullList(
          filter: PBFilters.active.build(),
          expand: 'treatment',
          sort: 'name',
        );
        return records
            .map((r) => TreatmentTemplateDto.fromRecord(r).toEntity())
            .toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<TreatmentTemplate> fetchOne(String id) async {
    return TaskEither.tryCatch(
      () async {
        final record = await _collection.getOne(id, expand: 'treatment');
        return TreatmentTemplateDto.fromRecord(record).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<List<TreatmentTemplate>> fetchByTreatment(
    String treatmentId,
  ) async {
    return TaskEither.tryCatch(
      () async {
        final filter = PBFilters.forTreatment(treatmentId).build();
        final records = await _collection.getFullList(
          filter: filter,
          expand: 'treatment',
          sort: 'name',
        );
        return records
            .map((r) => TreatmentTemplateDto.fromRecord(r).toEntity())
            .toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<TreatmentTemplate> create(TreatmentTemplate template) async {
    return TaskEither.tryCatch(
      () async {
        final created = await _collection.create(
          body: TreatmentTemplateDto.toCreateJson(template),
          expand: 'treatment',
        );
        return TreatmentTemplateDto.fromRecord(created).toEntity();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<TreatmentTemplate> update(TreatmentTemplate template) async {
    return TaskEither.tryCatch(
      () async {
        final updated = await _collection.update(
          template.id,
          body: TreatmentTemplateDto.toCreateJson(template),
          expand: 'treatment',
        );
        return TreatmentTemplateDto.fromRecord(updated).toEntity();
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
