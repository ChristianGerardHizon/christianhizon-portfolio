// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_templates_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing treatment templates.

@ProviderFor(TreatmentTemplatesController)
final treatmentTemplatesControllerProvider =
    TreatmentTemplatesControllerProvider._();

/// Controller for managing treatment templates.
final class TreatmentTemplatesControllerProvider extends $AsyncNotifierProvider<
    TreatmentTemplatesController, List<TreatmentTemplate>> {
  /// Controller for managing treatment templates.
  TreatmentTemplatesControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'treatmentTemplatesControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$treatmentTemplatesControllerHash();

  @$internal
  @override
  TreatmentTemplatesController create() => TreatmentTemplatesController();
}

String _$treatmentTemplatesControllerHash() =>
    r'fdc07bb373d1b912651f98ad6e2fc1b462c8835d';

/// Controller for managing treatment templates.

abstract class _$TreatmentTemplatesController
    extends $AsyncNotifier<List<TreatmentTemplate>> {
  FutureOr<List<TreatmentTemplate>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<List<TreatmentTemplate>>, List<TreatmentTemplate>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<TreatmentTemplate>>,
            List<TreatmentTemplate>>,
        AsyncValue<List<TreatmentTemplate>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

/// Provider for a single treatment template by ID.

@ProviderFor(treatmentTemplate)
final treatmentTemplateProvider = TreatmentTemplateFamily._();

/// Provider for a single treatment template by ID.

final class TreatmentTemplateProvider extends $FunctionalProvider<
        AsyncValue<TreatmentTemplate?>,
        TreatmentTemplate?,
        FutureOr<TreatmentTemplate?>>
    with
        $FutureModifier<TreatmentTemplate?>,
        $FutureProvider<TreatmentTemplate?> {
  /// Provider for a single treatment template by ID.
  TreatmentTemplateProvider._(
      {required TreatmentTemplateFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'treatmentTemplateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$treatmentTemplateHash();

  @override
  String toString() {
    return r'treatmentTemplateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TreatmentTemplate?> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<TreatmentTemplate?> create(Ref ref) {
    final argument = this.argument as String;
    return treatmentTemplate(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TreatmentTemplateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$treatmentTemplateHash() => r'ceab84a1819f814d29afac2a513c9dcfe5161978';

/// Provider for a single treatment template by ID.

final class TreatmentTemplateFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TreatmentTemplate?>, String> {
  TreatmentTemplateFamily._()
      : super(
          retry: null,
          name: r'treatmentTemplateProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for a single treatment template by ID.

  TreatmentTemplateProvider call(
    String id,
  ) =>
      TreatmentTemplateProvider._(argument: id, from: this);

  @override
  String toString() => r'treatmentTemplateProvider';
}

/// Provider for templates filtered by treatment ID.

@ProviderFor(templatesByTreatment)
final templatesByTreatmentProvider = TemplatesByTreatmentFamily._();

/// Provider for templates filtered by treatment ID.

final class TemplatesByTreatmentProvider extends $FunctionalProvider<
        AsyncValue<List<TreatmentTemplate>>,
        List<TreatmentTemplate>,
        FutureOr<List<TreatmentTemplate>>>
    with
        $FutureModifier<List<TreatmentTemplate>>,
        $FutureProvider<List<TreatmentTemplate>> {
  /// Provider for templates filtered by treatment ID.
  TemplatesByTreatmentProvider._(
      {required TemplatesByTreatmentFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'templatesByTreatmentProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$templatesByTreatmentHash();

  @override
  String toString() {
    return r'templatesByTreatmentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<TreatmentTemplate>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<TreatmentTemplate>> create(Ref ref) {
    final argument = this.argument as String;
    return templatesByTreatment(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TemplatesByTreatmentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$templatesByTreatmentHash() =>
    r'1bebdb8dccf2de2e79d0fd4f91a50df9a76dcbba';

/// Provider for templates filtered by treatment ID.

final class TemplatesByTreatmentFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<TreatmentTemplate>>, String> {
  TemplatesByTreatmentFamily._()
      : super(
          retry: null,
          name: r'templatesByTreatmentProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for templates filtered by treatment ID.

  TemplatesByTreatmentProvider call(
    String treatmentId,
  ) =>
      TemplatesByTreatmentProvider._(argument: treatmentId, from: this);

  @override
  String toString() => r'templatesByTreatmentProvider';
}
