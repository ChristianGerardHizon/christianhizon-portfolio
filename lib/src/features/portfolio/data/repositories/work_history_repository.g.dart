// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_history_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(workHistoryRepository)
final workHistoryRepositoryProvider = WorkHistoryRepositoryProvider._();

final class WorkHistoryRepositoryProvider extends $FunctionalProvider<
    WorkHistoryRepository,
    WorkHistoryRepository,
    WorkHistoryRepository> with $Provider<WorkHistoryRepository> {
  WorkHistoryRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'workHistoryRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$workHistoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<WorkHistoryRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WorkHistoryRepository create(Ref ref) {
    return workHistoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkHistoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkHistoryRepository>(value),
    );
  }
}

String _$workHistoryRepositoryHash() =>
    r'0ff70e4c5f1cc02f6e7da5eeef1a80706dd87500';
