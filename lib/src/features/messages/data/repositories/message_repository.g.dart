// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the MessageRepository instance.

@ProviderFor(messageRepository)
final messageRepositoryProvider = MessageRepositoryProvider._();

/// Provides the MessageRepository instance.

final class MessageRepositoryProvider extends $FunctionalProvider<
    MessageRepository,
    MessageRepository,
    MessageRepository> with $Provider<MessageRepository> {
  /// Provides the MessageRepository instance.
  MessageRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'messageRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$messageRepositoryHash();

  @$internal
  @override
  $ProviderElement<MessageRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MessageRepository create(Ref ref) {
    return messageRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MessageRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MessageRepository>(value),
    );
  }
}

String _$messageRepositoryHash() => r'a63d05628bdf1223baf480c6ce1643974254c6d5';
