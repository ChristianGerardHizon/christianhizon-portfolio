// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scaffold_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scaffoldController)
final scaffoldControllerProvider = ScaffoldControllerProvider._();

final class ScaffoldControllerProvider extends $FunctionalProvider<
    GlobalKey<ScaffoldState>,
    GlobalKey<ScaffoldState>,
    GlobalKey<ScaffoldState>> with $Provider<GlobalKey<ScaffoldState>> {
  ScaffoldControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'scaffoldControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$scaffoldControllerHash();

  @$internal
  @override
  $ProviderElement<GlobalKey<ScaffoldState>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GlobalKey<ScaffoldState> create(Ref ref) {
    return scaffoldController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GlobalKey<ScaffoldState> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GlobalKey<ScaffoldState>>(value),
    );
  }
}

String _$scaffoldControllerHash() =>
    r'7043a65bfb3ef7b3a073da9fbfcce54ffb9c9fdf';
