// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_schedules_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appointmentSchedulesControllerHash() =>
    r'd128b68533625c885a9fcb8eedcf39bce99d230d';

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

abstract class _$AppointmentSchedulesController
    extends BuildlessAutoDisposeAsyncNotifier<List<AppointmentSchedule>> {
  late final String patientId;
  late final String? patientRecordId;

  FutureOr<List<AppointmentSchedule>> build({
    required String patientId,
    String? patientRecordId,
  });
}

/// See also [AppointmentSchedulesController].
@ProviderFor(AppointmentSchedulesController)
const appointmentSchedulesControllerProvider =
    AppointmentSchedulesControllerFamily();

/// See also [AppointmentSchedulesController].
class AppointmentSchedulesControllerFamily
    extends Family<AsyncValue<List<AppointmentSchedule>>> {
  /// See also [AppointmentSchedulesController].
  const AppointmentSchedulesControllerFamily();

  /// See also [AppointmentSchedulesController].
  AppointmentSchedulesControllerProvider call({
    required String patientId,
    String? patientRecordId,
  }) {
    return AppointmentSchedulesControllerProvider(
      patientId: patientId,
      patientRecordId: patientRecordId,
    );
  }

  @override
  AppointmentSchedulesControllerProvider getProviderOverride(
    covariant AppointmentSchedulesControllerProvider provider,
  ) {
    return call(
      patientId: provider.patientId,
      patientRecordId: provider.patientRecordId,
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
  String? get name => r'appointmentSchedulesControllerProvider';
}

/// See also [AppointmentSchedulesController].
class AppointmentSchedulesControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AppointmentSchedulesController,
        List<AppointmentSchedule>> {
  /// See also [AppointmentSchedulesController].
  AppointmentSchedulesControllerProvider({
    required String patientId,
    String? patientRecordId,
  }) : this._internal(
          () => AppointmentSchedulesController()
            ..patientId = patientId
            ..patientRecordId = patientRecordId,
          from: appointmentSchedulesControllerProvider,
          name: r'appointmentSchedulesControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$appointmentSchedulesControllerHash,
          dependencies: AppointmentSchedulesControllerFamily._dependencies,
          allTransitiveDependencies:
              AppointmentSchedulesControllerFamily._allTransitiveDependencies,
          patientId: patientId,
          patientRecordId: patientRecordId,
        );

  AppointmentSchedulesControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.patientId,
    required this.patientRecordId,
  }) : super.internal();

  final String patientId;
  final String? patientRecordId;

  @override
  FutureOr<List<AppointmentSchedule>> runNotifierBuild(
    covariant AppointmentSchedulesController notifier,
  ) {
    return notifier.build(
      patientId: patientId,
      patientRecordId: patientRecordId,
    );
  }

  @override
  Override overrideWith(AppointmentSchedulesController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AppointmentSchedulesControllerProvider._internal(
        () => create()
          ..patientId = patientId
          ..patientRecordId = patientRecordId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        patientId: patientId,
        patientRecordId: patientRecordId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AppointmentSchedulesController,
      List<AppointmentSchedule>> createElement() {
    return _AppointmentSchedulesControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AppointmentSchedulesControllerProvider &&
        other.patientId == patientId &&
        other.patientRecordId == patientRecordId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, patientId.hashCode);
    hash = _SystemHash.combine(hash, patientRecordId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AppointmentSchedulesControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<AppointmentSchedule>> {
  /// The parameter `patientId` of this provider.
  String get patientId;

  /// The parameter `patientRecordId` of this provider.
  String? get patientRecordId;
}

class _AppointmentSchedulesControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        AppointmentSchedulesController,
        List<AppointmentSchedule>> with AppointmentSchedulesControllerRef {
  _AppointmentSchedulesControllerProviderElement(super.provider);

  @override
  String get patientId =>
      (origin as AppointmentSchedulesControllerProvider).patientId;
  @override
  String? get patientRecordId =>
      (origin as AppointmentSchedulesControllerProvider).patientRecordId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
