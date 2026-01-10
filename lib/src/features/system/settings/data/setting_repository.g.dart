// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settingRepository)
final settingRepositoryProvider = SettingRepositoryProvider._();

final class SettingRepositoryProvider extends $FunctionalProvider<
    SettingRepository,
    SettingRepository,
    SettingRepository> with $Provider<SettingRepository> {
  SettingRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'settingRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$settingRepositoryHash();

  @$internal
  @override
  $ProviderElement<SettingRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SettingRepository create(Ref ref) {
    return settingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingRepository>(value),
    );
  }
}

String _$settingRepositoryHash() => r'98b6423626d4a5231d53911f6eef45f598d80ded';
