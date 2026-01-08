// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_info_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PackageInfoController)
final packageInfoControllerProvider = PackageInfoControllerProvider._();

final class PackageInfoControllerProvider
    extends $AsyncNotifierProvider<PackageInfoController, PackageInfo> {
  PackageInfoControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'packageInfoControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$packageInfoControllerHash();

  @$internal
  @override
  PackageInfoController create() => PackageInfoController();
}

String _$packageInfoControllerHash() =>
    r'dccead9de940f756ea41360e4578f5095d36ea45';

abstract class _$PackageInfoController extends $AsyncNotifier<PackageInfo> {
  FutureOr<PackageInfo> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PackageInfo>, PackageInfo>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PackageInfo>, PackageInfo>,
        AsyncValue<PackageInfo>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
