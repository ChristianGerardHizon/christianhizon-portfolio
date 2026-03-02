// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tech_stack_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(techStackRepository)
final techStackRepositoryProvider = TechStackRepositoryProvider._();

final class TechStackRepositoryProvider extends $FunctionalProvider<
    TechStackRepository,
    TechStackRepository,
    TechStackRepository> with $Provider<TechStackRepository> {
  TechStackRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'techStackRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$techStackRepositoryHash();

  @$internal
  @override
  $ProviderElement<TechStackRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TechStackRepository create(Ref ref) {
    return techStackRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TechStackRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TechStackRepository>(value),
    );
  }
}

String _$techStackRepositoryHash() =>
    r'c3a95d75aca419eba24680298697bb697d67f8f2';
