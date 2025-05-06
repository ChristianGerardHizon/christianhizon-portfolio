// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_schedule_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appointmentScheduleFormControllerHash() =>
    r'a54d11ce52860622325da3a02000f276294df4f3';

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

abstract class _$AppointmentScheduleFormController
    extends BuildlessAutoDisposeAsyncNotifier<AppointmentScheduleState> {
  late final String? id;

  FutureOr<AppointmentScheduleState> build(
    String? id,
  );
}

/// See also [AppointmentScheduleFormController].
@ProviderFor(AppointmentScheduleFormController)
const appointmentScheduleFormControllerProvider =
    AppointmentScheduleFormControllerFamily();

/// See also [AppointmentScheduleFormController].
class AppointmentScheduleFormControllerFamily
    extends Family<AsyncValue<AppointmentScheduleState>> {
  /// See also [AppointmentScheduleFormController].
  const AppointmentScheduleFormControllerFamily();

  /// See also [AppointmentScheduleFormController].
  AppointmentScheduleFormControllerProvider call(
    String? id,
  ) {
    return AppointmentScheduleFormControllerProvider(
      id,
    );
  }

  @override
  AppointmentScheduleFormControllerProvider getProviderOverride(
    covariant AppointmentScheduleFormControllerProvider provider,
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
  String? get name => r'appointmentScheduleFormControllerProvider';
}

/// See also [AppointmentScheduleFormController].
class AppointmentScheduleFormControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        AppointmentScheduleFormController, AppointmentScheduleState> {
  /// See also [AppointmentScheduleFormController].
  AppointmentScheduleFormControllerProvider(
    String? id,
  ) : this._internal(
          () => AppointmentScheduleFormController()..id = id,
          from: appointmentScheduleFormControllerProvider,
          name: r'appointmentScheduleFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$appointmentScheduleFormControllerHash,
          dependencies: AppointmentScheduleFormControllerFamily._dependencies,
          allTransitiveDependencies: AppointmentScheduleFormControllerFamily
              ._allTransitiveDependencies,
          id: id,
        );

  AppointmentScheduleFormControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String? id;

  @override
  FutureOr<AppointmentScheduleState> runNotifierBuild(
    covariant AppointmentScheduleFormController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(AppointmentScheduleFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AppointmentScheduleFormControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<AppointmentScheduleFormController,
      AppointmentScheduleState> createElement() {
    return _AppointmentScheduleFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AppointmentScheduleFormControllerProvider && other.id == id;
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
mixin AppointmentScheduleFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<AppointmentScheduleState> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _AppointmentScheduleFormControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        AppointmentScheduleFormController,
        AppointmentScheduleState> with AppointmentScheduleFormControllerRef {
  _AppointmentScheduleFormControllerProviderElement(super.provider);

  @override
  String? get id => (origin as AppointmentScheduleFormControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
