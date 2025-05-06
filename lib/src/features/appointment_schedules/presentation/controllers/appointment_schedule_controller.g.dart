// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_schedule_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appointmentScheduleControllerHash() =>
    r'c96f55199bd40cf070395d32727b810952ab751d';

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

abstract class _$AppointmentScheduleController
    extends BuildlessAutoDisposeAsyncNotifier<AppointmentSchedule> {
  late final String id;

  FutureOr<AppointmentSchedule> build(
    String id,
  );
}

/// See also [AppointmentScheduleController].
@ProviderFor(AppointmentScheduleController)
const appointmentScheduleControllerProvider =
    AppointmentScheduleControllerFamily();

/// See also [AppointmentScheduleController].
class AppointmentScheduleControllerFamily
    extends Family<AsyncValue<AppointmentSchedule>> {
  /// See also [AppointmentScheduleController].
  const AppointmentScheduleControllerFamily();

  /// See also [AppointmentScheduleController].
  AppointmentScheduleControllerProvider call(
    String id,
  ) {
    return AppointmentScheduleControllerProvider(
      id,
    );
  }

  @override
  AppointmentScheduleControllerProvider getProviderOverride(
    covariant AppointmentScheduleControllerProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'appointmentScheduleControllerProvider';
}

/// See also [AppointmentScheduleController].
class AppointmentScheduleControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AppointmentScheduleController,
        AppointmentSchedule> {
  /// See also [AppointmentScheduleController].
  AppointmentScheduleControllerProvider(
    String id,
  ) : this._internal(
          () => AppointmentScheduleController()..id = id,
          from: appointmentScheduleControllerProvider,
          name: r'appointmentScheduleControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$appointmentScheduleControllerHash,
          dependencies: AppointmentScheduleControllerFamily._dependencies,
          allTransitiveDependencies:
              AppointmentScheduleControllerFamily._allTransitiveDependencies,
          id: id,
        );

  AppointmentScheduleControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<AppointmentSchedule> runNotifierBuild(
    covariant AppointmentScheduleController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(AppointmentScheduleController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AppointmentScheduleControllerProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AppointmentScheduleController,
      AppointmentSchedule> createElement() {
    return _AppointmentScheduleControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AppointmentScheduleControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AppointmentScheduleControllerRef
    on AutoDisposeAsyncNotifierProviderRef<AppointmentSchedule> {
  /// The parameter `id` of this provider.
  String get id;
}

class _AppointmentScheduleControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        AppointmentScheduleController,
        AppointmentSchedule> with AppointmentScheduleControllerRef {
  _AppointmentScheduleControllerProviderElement(super.provider);

  @override
  String get id => (origin as AppointmentScheduleControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
