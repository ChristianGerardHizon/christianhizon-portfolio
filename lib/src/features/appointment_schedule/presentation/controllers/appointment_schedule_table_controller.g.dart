// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_schedule_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appointmentScheduleTableControllerHash() =>
    r'b4ddf6e06d8f1328c5d0dc9dd59aef0bbc7aa53e';

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

abstract class _$AppointmentScheduleTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<AppointmentSchedule>> {
  late final String tableKey;
  late final String? patientId;

  FutureOr<List<AppointmentSchedule>> build(
    String tableKey, {
    String? patientId,
  });
}

/// See also [AppointmentScheduleTableController].
@ProviderFor(AppointmentScheduleTableController)
const appointmentScheduleTableControllerProvider =
    AppointmentScheduleTableControllerFamily();

/// See also [AppointmentScheduleTableController].
class AppointmentScheduleTableControllerFamily
    extends Family<AsyncValue<List<AppointmentSchedule>>> {
  /// See also [AppointmentScheduleTableController].
  const AppointmentScheduleTableControllerFamily();

  /// See also [AppointmentScheduleTableController].
  AppointmentScheduleTableControllerProvider call(
    String tableKey, {
    String? patientId,
  }) {
    return AppointmentScheduleTableControllerProvider(
      tableKey,
      patientId: patientId,
    );
  }

  @override
  AppointmentScheduleTableControllerProvider getProviderOverride(
    covariant AppointmentScheduleTableControllerProvider provider,
  ) {
    return call(
      provider.tableKey,
      patientId: provider.patientId,
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
  String? get name => r'appointmentScheduleTableControllerProvider';
}

/// See also [AppointmentScheduleTableController].
class AppointmentScheduleTableControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        AppointmentScheduleTableController, List<AppointmentSchedule>> {
  /// See also [AppointmentScheduleTableController].
  AppointmentScheduleTableControllerProvider(
    String tableKey, {
    String? patientId,
  }) : this._internal(
          () => AppointmentScheduleTableController()
            ..tableKey = tableKey
            ..patientId = patientId,
          from: appointmentScheduleTableControllerProvider,
          name: r'appointmentScheduleTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$appointmentScheduleTableControllerHash,
          dependencies: AppointmentScheduleTableControllerFamily._dependencies,
          allTransitiveDependencies: AppointmentScheduleTableControllerFamily
              ._allTransitiveDependencies,
          tableKey: tableKey,
          patientId: patientId,
        );

  AppointmentScheduleTableControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tableKey,
    required this.patientId,
  }) : super.internal();

  final String tableKey;
  final String? patientId;

  @override
  FutureOr<List<AppointmentSchedule>> runNotifierBuild(
    covariant AppointmentScheduleTableController notifier,
  ) {
    return notifier.build(
      tableKey,
      patientId: patientId,
    );
  }

  @override
  Override overrideWith(AppointmentScheduleTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AppointmentScheduleTableControllerProvider._internal(
        () => create()
          ..tableKey = tableKey
          ..patientId = patientId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tableKey: tableKey,
        patientId: patientId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AppointmentScheduleTableController,
      List<AppointmentSchedule>> createElement() {
    return _AppointmentScheduleTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AppointmentScheduleTableControllerProvider &&
        other.tableKey == tableKey &&
        other.patientId == patientId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tableKey.hashCode);
    hash = _SystemHash.combine(hash, patientId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AppointmentScheduleTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<AppointmentSchedule>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;

  /// The parameter `patientId` of this provider.
  String? get patientId;
}

class _AppointmentScheduleTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        AppointmentScheduleTableController,
        List<AppointmentSchedule>> with AppointmentScheduleTableControllerRef {
  _AppointmentScheduleTableControllerProviderElement(super.provider);

  @override
  String get tableKey =>
      (origin as AppointmentScheduleTableControllerProvider).tableKey;
  @override
  String? get patientId =>
      (origin as AppointmentScheduleTableControllerProvider).patientId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
