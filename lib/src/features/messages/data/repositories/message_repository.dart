import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pb_expand.dart';
import '../../../../core/packages/pocketbase/pb_filter.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/message.dart';
import '../dto/message_dto.dart';

part 'message_repository.g.dart';

/// Repository interface for message operations.
abstract class MessageRepository {
  /// Fetches all messages.
  FutureEither<List<Message>> fetchAll({String? filter, String? sort});

  /// Fetches messages with pagination.
  FutureEitherPaginated<Message> fetchPaginated({
    int page = 1,
    int perPage = Pagination.defaultPageSize,
    String? filter,
    String? sort,
  });

  /// Fetches a single message by ID.
  FutureEither<Message> fetchOne(String id);

  /// Fetches messages for a specific patient.
  FutureEither<List<Message>> fetchByPatient(String patientId);

  /// Fetches messages for a specific appointment.
  FutureEither<List<Message>> fetchByAppointment(String appointmentId);

  /// Fetches pending messages (waiting to be sent).
  FutureEither<List<Message>> fetchPending();

  /// Creates a new message.
  FutureEither<Message> create(Message message);

  /// Updates an existing message.
  FutureEither<Message> update(Message message);

  /// Updates message status.
  FutureEither<Message> updateStatus(String id, MessageStatus status);

  /// Cancels a pending message.
  FutureEither<Message> cancel(String id);

  /// Retries a failed or cancelled message.
  /// Resets status to pending and updates send time to now.
  FutureEither<Message> retry(String id);

  /// Soft deletes a message (sets isDeleted = true).
  FutureEither<void> delete(String id);
}

/// Provides the MessageRepository instance.
@Riverpod(keepAlive: true)
MessageRepository messageRepository(Ref ref) {
  return MessageRepositoryImpl(ref.watch(pocketbaseProvider));
}

/// Implementation of [MessageRepository] using PocketBase.
class MessageRepositoryImpl implements MessageRepository {
  final PocketBase _pb;

  MessageRepositoryImpl(this._pb);

  RecordService get _collection =>
      _pb.collection(PocketBaseCollections.messages);

  String get _expand => PBExpand.message.toString();

  Message _toEntity(RecordModel record) {
    return MessageDto.fromRecord(record).toEntity();
  }

  @override
  FutureEither<List<Message>> fetchAll({String? filter, String? sort}) async {
    return TaskEither.tryCatch(
      () async {
        final baseFilter = PBFilters.active.build();
        final filterString =
            filter != null ? '$baseFilter && $filter' : baseFilter;

        final records = await _collection.getFullList(
          expand: _expand,
          filter: filterString,
          sort: sort ?? '-sendDateTime',
        );

        return records.map(_toEntity).toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEitherPaginated<Message> fetchPaginated({
    int page = 1,
    int perPage = Pagination.defaultPageSize,
    String? filter,
    String? sort,
  }) async {
    return TaskEither.tryCatch(
      () async {
        final baseFilter = PBFilters.active.build();
        final filterString =
            filter != null ? '$baseFilter && $filter' : baseFilter;

        final result = await _collection.getList(
          page: page,
          perPage: perPage,
          expand: _expand,
          filter: filterString,
          sort: sort ?? '-sendDateTime',
        );

        return PaginatedResult<Message>(
          items: result.items.map(_toEntity).toList(),
          page: result.page,
          totalItems: result.totalItems,
          totalPages: result.totalPages,
        );
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<Message> fetchOne(String id) async {
    return TaskEither.tryCatch(
      () async {
        if (id.isEmpty) {
          throw const DataFailure(
            'Message ID cannot be empty',
            null,
            'invalid_message_id',
          );
        }

        final record = await _collection.getOne(id, expand: _expand);
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<List<Message>> fetchByPatient(String patientId) async {
    return TaskEither.tryCatch(
      () async {
        final filter =
            PBFilter().relation('patient', patientId).notDeleted().build();

        final records = await _collection.getFullList(
          expand: _expand,
          filter: filter,
          sort: '-sendDateTime',
        );

        return records.map(_toEntity).toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<List<Message>> fetchByAppointment(String appointmentId) async {
    return TaskEither.tryCatch(
      () async {
        final filter = PBFilter()
            .relation('appointment', appointmentId)
            .notDeleted()
            .build();

        final records = await _collection.getFullList(
          expand: _expand,
          filter: filter,
          sort: '-sendDateTime',
        );

        return records.map(_toEntity).toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<List<Message>> fetchPending() async {
    return TaskEither.tryCatch(
      () async {
        final filter =
            PBFilter().equals('status', 'pending').notDeleted().build();

        final records = await _collection.getFullList(
          expand: _expand,
          filter: filter,
          sort: 'sendDateTime',
        );

        return records.map(_toEntity).toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<Message> create(Message message) async {
    return TaskEither.tryCatch(
      () async {
        final body = MessageDto.toCreateJson(message);
        final record = await _collection.create(body: body, expand: _expand);
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<Message> update(Message message) async {
    return TaskEither.tryCatch(
      () async {
        final body = MessageDto.toCreateJson(message);
        final record =
            await _collection.update(message.id, body: body, expand: _expand);
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<Message> updateStatus(String id, MessageStatus status) async {
    return TaskEither.tryCatch(
      () async {
        final body = MessageDto.toStatusJson(status);
        final record =
            await _collection.update(id, body: body, expand: _expand);
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<Message> cancel(String id) async {
    return updateStatus(id, MessageStatus.cancelled);
  }

  @override
  FutureEither<Message> retry(String id) async {
    return TaskEither.tryCatch(
      () async {
        final body = MessageDto.toRetryJson(DateTime.now());
        final record =
            await _collection.update(id, body: body, expand: _expand);
        return _toEntity(record);
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
