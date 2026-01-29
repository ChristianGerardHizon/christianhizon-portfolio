// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing the main messages list.
///
/// Provides a global, cached list of all messages with CRUD operations.

@ProviderFor(MessagesController)
final messagesControllerProvider = MessagesControllerProvider._();

/// Controller for managing the main messages list.
///
/// Provides a global, cached list of all messages with CRUD operations.
final class MessagesControllerProvider
    extends $AsyncNotifierProvider<MessagesController, List<Message>> {
  /// Controller for managing the main messages list.
  ///
  /// Provides a global, cached list of all messages with CRUD operations.
  MessagesControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'messagesControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$messagesControllerHash();

  @$internal
  @override
  MessagesController create() => MessagesController();
}

String _$messagesControllerHash() =>
    r'992aa3292c173f15a9256b392f4cad6f907a05ec';

/// Controller for managing the main messages list.
///
/// Provides a global, cached list of all messages with CRUD operations.

abstract class _$MessagesController extends $AsyncNotifier<List<Message>> {
  FutureOr<List<Message>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Message>>, List<Message>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Message>>, List<Message>>,
        AsyncValue<List<Message>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

/// Provider for fetching a single message by ID.

@ProviderFor(message)
final messageProvider = MessageFamily._();

/// Provider for fetching a single message by ID.

final class MessageProvider extends $FunctionalProvider<AsyncValue<Message?>,
        Message?, FutureOr<Message?>>
    with $FutureModifier<Message?>, $FutureProvider<Message?> {
  /// Provider for fetching a single message by ID.
  MessageProvider._(
      {required MessageFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'messageProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$messageHash();

  @override
  String toString() {
    return r'messageProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Message?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Message?> create(Ref ref) {
    final argument = this.argument as String;
    return message(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MessageProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$messageHash() => r'b0c215fd3872d902346890e627f5e0d62c3124f5';

/// Provider for fetching a single message by ID.

final class MessageFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Message?>, String> {
  MessageFamily._()
      : super(
          retry: null,
          name: r'messageProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for fetching a single message by ID.

  MessageProvider call(
    String id,
  ) =>
      MessageProvider._(argument: id, from: this);

  @override
  String toString() => r'messageProvider';
}

/// Provider for fetching messages by patient.

@ProviderFor(messagesByPatient)
final messagesByPatientProvider = MessagesByPatientFamily._();

/// Provider for fetching messages by patient.

final class MessagesByPatientProvider extends $FunctionalProvider<
        AsyncValue<List<Message>>, List<Message>, FutureOr<List<Message>>>
    with $FutureModifier<List<Message>>, $FutureProvider<List<Message>> {
  /// Provider for fetching messages by patient.
  MessagesByPatientProvider._(
      {required MessagesByPatientFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'messagesByPatientProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$messagesByPatientHash();

  @override
  String toString() {
    return r'messagesByPatientProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Message>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Message>> create(Ref ref) {
    final argument = this.argument as String;
    return messagesByPatient(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MessagesByPatientProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$messagesByPatientHash() => r'80532005da0b4bcf072fda3a25c272f8ef3d5c11';

/// Provider for fetching messages by patient.

final class MessagesByPatientFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Message>>, String> {
  MessagesByPatientFamily._()
      : super(
          retry: null,
          name: r'messagesByPatientProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for fetching messages by patient.

  MessagesByPatientProvider call(
    String patientId,
  ) =>
      MessagesByPatientProvider._(argument: patientId, from: this);

  @override
  String toString() => r'messagesByPatientProvider';
}

/// Provider for fetching messages by appointment.

@ProviderFor(messagesByAppointment)
final messagesByAppointmentProvider = MessagesByAppointmentFamily._();

/// Provider for fetching messages by appointment.

final class MessagesByAppointmentProvider extends $FunctionalProvider<
        AsyncValue<List<Message>>, List<Message>, FutureOr<List<Message>>>
    with $FutureModifier<List<Message>>, $FutureProvider<List<Message>> {
  /// Provider for fetching messages by appointment.
  MessagesByAppointmentProvider._(
      {required MessagesByAppointmentFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'messagesByAppointmentProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$messagesByAppointmentHash();

  @override
  String toString() {
    return r'messagesByAppointmentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Message>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Message>> create(Ref ref) {
    final argument = this.argument as String;
    return messagesByAppointment(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MessagesByAppointmentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$messagesByAppointmentHash() =>
    r'8189414b94299535e7cdd7b822d64e4adfcc1775';

/// Provider for fetching messages by appointment.

final class MessagesByAppointmentFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Message>>, String> {
  MessagesByAppointmentFamily._()
      : super(
          retry: null,
          name: r'messagesByAppointmentProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for fetching messages by appointment.

  MessagesByAppointmentProvider call(
    String appointmentId,
  ) =>
      MessagesByAppointmentProvider._(argument: appointmentId, from: this);

  @override
  String toString() => r'messagesByAppointmentProvider';
}

/// Provider for fetching pending messages.

@ProviderFor(pendingMessages)
final pendingMessagesProvider = PendingMessagesProvider._();

/// Provider for fetching pending messages.

final class PendingMessagesProvider extends $FunctionalProvider<
        AsyncValue<List<Message>>, List<Message>, FutureOr<List<Message>>>
    with $FutureModifier<List<Message>>, $FutureProvider<List<Message>> {
  /// Provider for fetching pending messages.
  PendingMessagesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'pendingMessagesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$pendingMessagesHash();

  @$internal
  @override
  $FutureProviderElement<List<Message>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Message>> create(Ref ref) {
    return pendingMessages(ref);
  }
}

String _$pendingMessagesHash() => r'2235894e9667add095ffdd0175dfffa2b689d68c';
