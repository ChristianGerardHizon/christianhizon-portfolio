// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xfile_widget.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$xFileControllerHash() => r'b8087967b06aeabce7f844a94c05dcda47d71ab5';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$XFileController
    extends BuildlessAutoDisposeAsyncNotifier<Uint8List> {
  late final XFile file;

  FutureOr<Uint8List> build(
    XFile file,
  );
}

/// See also [XFileController].
@ProviderFor(XFileController)
const xFileControllerProvider = XFileControllerFamily();

/// See also [XFileController].
class XFileControllerFamily extends Family<AsyncValue<Uint8List>> {
  /// See also [XFileController].
  const XFileControllerFamily();

  /// See also [XFileController].
  XFileControllerProvider call(
    XFile file,
  ) {
    return XFileControllerProvider(
      file,
    );
  }

  @override
  XFileControllerProvider getProviderOverride(
    covariant XFileControllerProvider provider,
  ) {
    return call(
      provider.file,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'xFileControllerProvider';
}

/// See also [XFileController].
class XFileControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<XFileController, Uint8List> {
  /// See also [XFileController].
  XFileControllerProvider(
    XFile file,
  ) : this._internal(
          () => XFileController()..file = file,
          from: xFileControllerProvider,
          name: r'xFileControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$xFileControllerHash,
          dependencies: XFileControllerFamily._dependencies,
          allTransitiveDependencies:
              XFileControllerFamily._allTransitiveDependencies,
          file: file,
        );

  XFileControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.file,
  }) : super.internal();

  final XFile file;

  @override
  FutureOr<Uint8List> runNotifierBuild(
    covariant XFileController notifier,
  ) {
    return notifier.build(
      file,
    );
  }

  @override
  Override overrideWith(XFileController Function() create) {
    return ProviderOverride(
      origin: this,
      override: XFileControllerProvider._internal(
        () => create()..file = file,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        file: file,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<XFileController, Uint8List>
      createElement() {
    return _XFileControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is XFileControllerProvider && other.file == file;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, file.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin XFileControllerRef on AutoDisposeAsyncNotifierProviderRef<Uint8List> {
  /// The parameter `file` of this provider.
  XFile get file;
}

class _XFileControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<XFileController, Uint8List>
    with XFileControllerRef {
  _XFileControllerProviderElement(super.provider);

  @override
  XFile get file => (origin as XFileControllerProvider).file;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
