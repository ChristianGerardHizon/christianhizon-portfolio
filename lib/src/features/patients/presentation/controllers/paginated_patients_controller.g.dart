// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_patients_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing paginated patients list.

@ProviderFor(PaginatedPatientsController)
final paginatedPatientsControllerProvider =
    PaginatedPatientsControllerProvider._();

/// Controller for managing paginated patients list.
final class PaginatedPatientsControllerProvider extends $AsyncNotifierProvider<
    PaginatedPatientsController, PaginatedState<Patient>> {
  /// Controller for managing paginated patients list.
  PaginatedPatientsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'paginatedPatientsControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$paginatedPatientsControllerHash();

  @$internal
  @override
  PaginatedPatientsController create() => PaginatedPatientsController();
}

String _$paginatedPatientsControllerHash() =>
    r'ba4fb7f9e0df09fbf1f591038b83134eb2535848';

/// Controller for managing paginated patients list.

abstract class _$PaginatedPatientsController
    extends $AsyncNotifier<PaginatedState<Patient>> {
  FutureOr<PaginatedState<Patient>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<PaginatedState<Patient>>, PaginatedState<Patient>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PaginatedState<Patient>>,
            PaginatedState<Patient>>,
        AsyncValue<PaginatedState<Patient>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
