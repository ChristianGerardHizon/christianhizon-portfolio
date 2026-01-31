// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_templates_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing message template list state.
///
/// Provides methods for fetching and CRUD operations on message templates.

@ProviderFor(MessageTemplatesController)
final messageTemplatesControllerProvider =
    MessageTemplatesControllerProvider._();

/// Controller for managing message template list state.
///
/// Provides methods for fetching and CRUD operations on message templates.
final class MessageTemplatesControllerProvider extends $AsyncNotifierProvider<
    MessageTemplatesController, List<MessageTemplate>> {
  /// Controller for managing message template list state.
  ///
  /// Provides methods for fetching and CRUD operations on message templates.
  MessageTemplatesControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'messageTemplatesControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$messageTemplatesControllerHash();

  @$internal
  @override
  MessageTemplatesController create() => MessageTemplatesController();
}

String _$messageTemplatesControllerHash() =>
    r'b297ac915175fe0144bcb19ce2f833078a2a28a4';

/// Controller for managing message template list state.
///
/// Provides methods for fetching and CRUD operations on message templates.

abstract class _$MessageTemplatesController
    extends $AsyncNotifier<List<MessageTemplate>> {
  FutureOr<List<MessageTemplate>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<List<MessageTemplate>>, List<MessageTemplate>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<MessageTemplate>>, List<MessageTemplate>>,
        AsyncValue<List<MessageTemplate>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
