// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_template_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the MessageTemplateRepository instance.

@ProviderFor(messageTemplateRepository)
final messageTemplateRepositoryProvider = MessageTemplateRepositoryProvider._();

/// Provides the MessageTemplateRepository instance.

final class MessageTemplateRepositoryProvider extends $FunctionalProvider<
    MessageTemplateRepository,
    MessageTemplateRepository,
    MessageTemplateRepository> with $Provider<MessageTemplateRepository> {
  /// Provides the MessageTemplateRepository instance.
  MessageTemplateRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'messageTemplateRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$messageTemplateRepositoryHash();

  @$internal
  @override
  $ProviderElement<MessageTemplateRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MessageTemplateRepository create(Ref ref) {
    return messageTemplateRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MessageTemplateRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MessageTemplateRepository>(value),
    );
  }
}

String _$messageTemplateRepositoryHash() =>
    r'eb39ec20db6ad52f7a274555b416ea4f046559d0';
