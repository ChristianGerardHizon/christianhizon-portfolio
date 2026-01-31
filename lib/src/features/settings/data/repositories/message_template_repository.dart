import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pb_filter.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/message_template.dart';
import '../dto/message_template_dto.dart';

part 'message_template_repository.g.dart';

/// Repository interface for message template operations.
abstract class MessageTemplateRepository {
  /// Fetches all message templates.
  FutureEither<List<MessageTemplate>> fetchAll({String? filter});

  /// Fetches a single message template by ID.
  FutureEither<MessageTemplate> fetchOne(String id);

  /// Creates a new message template.
  FutureEither<MessageTemplate> create(MessageTemplate template);

  /// Updates an existing message template.
  FutureEither<MessageTemplate> update(MessageTemplate template);

  /// Soft deletes a message template by ID.
  FutureEither<void> delete(String id);
}

/// Provides the MessageTemplateRepository instance.
@Riverpod(keepAlive: true)
MessageTemplateRepository messageTemplateRepository(Ref ref) {
  return MessageTemplateRepositoryImpl(ref.watch(pocketbaseProvider));
}

/// Implementation of [MessageTemplateRepository] using PocketBase.
class MessageTemplateRepositoryImpl implements MessageTemplateRepository {
  final PocketBase _pb;

  MessageTemplateRepositoryImpl(this._pb);

  RecordService get _collection =>
      _pb.collection(PocketBaseCollections.messageTemplates);

  MessageTemplate _toEntity(RecordModel record) {
    final dto = MessageTemplateDto.fromRecord(record);
    return dto.toEntity();
  }

  @override
  FutureEither<List<MessageTemplate>> fetchAll({String? filter}) async {
    return TaskEither.tryCatch(
      () async {
        final baseFilter = PBFilters.active.build();
        final filterString =
            filter != null ? '$baseFilter && $filter' : baseFilter;

        final records = await _collection.getFullList(
          filter: filterString,
          sort: 'category,name',
        );

        return records.map(_toEntity).toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<MessageTemplate> fetchOne(String id) async {
    return TaskEither.tryCatch(
      () async {
        if (id.isEmpty) {
          throw const DataFailure(
            'Message template ID cannot be empty',
            null,
            'invalid_template_id',
          );
        }

        final record = await _collection.getOne(id);
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<MessageTemplate> create(MessageTemplate template) async {
    return TaskEither.tryCatch(
      () async {
        final body = <String, dynamic>{
          'name': template.name,
          'content': template.content,
          'category': template.category,
          'branch': template.branch,
          'isDeleted': false,
        };

        final record = await _collection.create(body: body);
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<MessageTemplate> update(MessageTemplate template) async {
    return TaskEither.tryCatch(
      () async {
        if (template.id.isEmpty) {
          throw const DataFailure(
            'Message template ID cannot be empty',
            null,
            'invalid_template_id',
          );
        }

        final body = <String, dynamic>{
          'name': template.name,
          'content': template.content,
          'category': template.category,
        };

        final record = await _collection.update(
          template.id,
          body: body,
        );
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<void> delete(String id) async {
    return TaskEither.tryCatch(
      () async {
        if (id.isEmpty) {
          throw const DataFailure(
            'Message template ID cannot be empty',
            null,
            'invalid_template_id',
          );
        }

        // Soft delete
        await _collection.update(id, body: {'isDeleted': true});
      },
      Failure.handle,
    ).run();
  }
}
