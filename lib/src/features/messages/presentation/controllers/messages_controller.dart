import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/message_repository.dart';
import '../../domain/message.dart';

part 'messages_controller.g.dart';

/// Controller for managing the main messages list.
///
/// Provides a global, cached list of all messages with CRUD operations.
@Riverpod(keepAlive: true)
class MessagesController extends _$MessagesController {
  @override
  Future<List<Message>> build() async {
    final result = await ref.read(messageRepositoryProvider).fetchAll();
    return result.fold(
      (failure) => throw failure,
      (messages) => messages,
    );
  }

  /// Refreshes the messages list from the server.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(messageRepositoryProvider).fetchAll();
      return result.fold(
        (failure) => throw failure,
        (messages) => messages,
      );
    });
  }

  /// Creates a new message and adds it to the list.
  Future<bool> createMessage(Message message) async {
    final result = await ref.read(messageRepositoryProvider).create(message);
    return result.fold(
      (failure) => false,
      (created) {
        state.whenData((messages) {
          // Add to beginning of list (most recent first)
          state = AsyncValue.data([created, ...messages]);
        });
        return true;
      },
    );
  }

  /// Creates a new message and returns it.
  ///
  /// Returns the created message on success, or null on failure.
  Future<Message?> createMessageAndReturn(Message message) async {
    final result = await ref.read(messageRepositoryProvider).create(message);
    return result.fold(
      (failure) => null,
      (created) {
        state.whenData((messages) {
          state = AsyncValue.data([created, ...messages]);
        });
        return created;
      },
    );
  }

  /// Updates an existing message.
  Future<bool> updateMessage(Message message) async {
    final result = await ref.read(messageRepositoryProvider).update(message);
    return result.fold(
      (failure) => false,
      (updated) {
        state.whenData((messages) {
          final index = messages.indexWhere((m) => m.id == updated.id);
          if (index != -1) {
            final newList = [...messages];
            newList[index] = updated;
            state = AsyncValue.data(newList);
          }
        });
        return true;
      },
    );
  }

  /// Updates a message's status.
  Future<bool> updateStatus(String id, MessageStatus status) async {
    final result = await ref.read(messageRepositoryProvider).updateStatus(id, status);
    return result.fold(
      (failure) => false,
      (updated) {
        state.whenData((messages) {
          final index = messages.indexWhere((m) => m.id == updated.id);
          if (index != -1) {
            final newList = [...messages];
            newList[index] = updated;
            state = AsyncValue.data(newList);
          }
        });
        return true;
      },
    );
  }

  /// Cancels a pending message.
  Future<bool> cancelMessage(String id) async {
    return updateStatus(id, MessageStatus.cancelled);
  }

  /// Deletes a message (soft delete).
  Future<bool> deleteMessage(String id) async {
    final result = await ref.read(messageRepositoryProvider).delete(id);
    return result.fold(
      (failure) => false,
      (_) {
        state.whenData((messages) {
          state = AsyncValue.data(
            messages.where((m) => m.id != id).toList(),
          );
        });
        return true;
      },
    );
  }
}

/// Provider for fetching a single message by ID.
@riverpod
Future<Message?> message(Ref ref, String id) async {
  final result = await ref.read(messageRepositoryProvider).fetchOne(id);
  return result.fold(
    (failure) => null,
    (message) => message,
  );
}

/// Provider for fetching messages by patient.
@riverpod
Future<List<Message>> messagesByPatient(Ref ref, String patientId) async {
  final result = await ref.read(messageRepositoryProvider).fetchByPatient(patientId);
  return result.fold(
    (failure) => [],
    (messages) => messages,
  );
}

/// Provider for fetching messages by appointment.
@riverpod
Future<List<Message>> messagesByAppointment(Ref ref, String appointmentId) async {
  final result = await ref.read(messageRepositoryProvider).fetchByAppointment(appointmentId);
  return result.fold(
    (failure) => [],
    (messages) => messages,
  );
}

/// Provider for fetching pending messages.
@riverpod
Future<List<Message>> pendingMessages(Ref ref) async {
  final result = await ref.read(messageRepositoryProvider).fetchPending();
  return result.fold(
    (failure) => [],
    (messages) => messages,
  );
}
