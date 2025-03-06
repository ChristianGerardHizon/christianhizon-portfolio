// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientHistoryControllerHash() =>
    r'2feae385694d87d5fb128218a5f5715cf230be03';

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

abstract class _$PatientHistoryController
    extends BuildlessAutoDisposeAsyncNotifier<PageResults<History>> {
  late final String patientId;
  late final String historyTypeId;

  FutureOr<PageResults<History>> build({
    required String patientId,
    required String historyTypeId,
  });
}

/// See also [PatientHistoryController].
@ProviderFor(PatientHistoryController)
const patientHistoryControllerProvider = PatientHistoryControllerFamily();

/// See also [PatientHistoryController].
class PatientHistoryControllerFamily
    extends Family<AsyncValue<PageResults<History>>> {
  /// See also [PatientHistoryController].
  const PatientHistoryControllerFamily();

  /// See also [PatientHistoryController].
  PatientHistoryControllerProvider call({
    required String patientId,
    required String historyTypeId,
  }) {
    return PatientHistoryControllerProvider(
      patientId: patientId,
      historyTypeId: historyTypeId,
    );
  }

  @override
  PatientHistoryControllerProvider getProviderOverride(
    covariant PatientHistoryControllerProvider provider,
  ) {
    return call(
      patientId: provider.patientId,
      historyTypeId: provider.historyTypeId,
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
  String? get name => r'patientHistoryControllerProvider';
}

/// See also [PatientHistoryController].
class PatientHistoryControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientHistoryController,
        PageResults<History>> {
  /// See also [PatientHistoryController].
  PatientHistoryControllerProvider({
    required String patientId,
    required String historyTypeId,
  }) : this._internal(
          () => PatientHistoryController()
            ..patientId = patientId
            ..historyTypeId = historyTypeId,
          from: patientHistoryControllerProvider,
          name: r'patientHistoryControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientHistoryControllerHash,
          dependencies: PatientHistoryControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientHistoryControllerFamily._allTransitiveDependencies,
          patientId: patientId,
          historyTypeId: historyTypeId,
        );

  PatientHistoryControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.patientId,
    required this.historyTypeId,
  }) : super.internal();

  final String patientId;
  final String historyTypeId;

  @override
  FutureOr<PageResults<History>> runNotifierBuild(
    covariant PatientHistoryController notifier,
  ) {
    return notifier.build(
      patientId: patientId,
      historyTypeId: historyTypeId,
    );
  }

  @override
  Override overrideWith(PatientHistoryController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientHistoryControllerProvider._internal(
        () => create()
          ..patientId = patientId
          ..historyTypeId = historyTypeId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        patientId: patientId,
        historyTypeId: historyTypeId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PatientHistoryController,
      PageResults<History>> createElement() {
    return _PatientHistoryControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientHistoryControllerProvider &&
        other.patientId == patientId &&
        other.historyTypeId == historyTypeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, patientId.hashCode);
    hash = _SystemHash.combine(hash, historyTypeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientHistoryControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PageResults<History>> {
  /// The parameter `patientId` of this provider.
  String get patientId;

  /// The parameter `historyTypeId` of this provider.
  String get historyTypeId;
}

class _PatientHistoryControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientHistoryController,
        PageResults<History>> with PatientHistoryControllerRef {
  _PatientHistoryControllerProviderElement(super.provider);

  @override
  String get patientId =>
      (origin as PatientHistoryControllerProvider).patientId;
  @override
  String get historyTypeId =>
      (origin as PatientHistoryControllerProvider).historyTypeId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
