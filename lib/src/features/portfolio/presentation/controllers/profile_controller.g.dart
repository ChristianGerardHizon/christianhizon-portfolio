// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing the portfolio profile.

@ProviderFor(ProfileController)
final profileControllerProvider = ProfileControllerProvider._();

/// Controller for managing the portfolio profile.
final class ProfileControllerProvider
    extends $AsyncNotifierProvider<ProfileController, Profile?> {
  /// Controller for managing the portfolio profile.
  ProfileControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'profileControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$profileControllerHash();

  @$internal
  @override
  ProfileController create() => ProfileController();
}

String _$profileControllerHash() => r'27decfdbc2d892891f3d4ccde63db008ffdef9da';

/// Controller for managing the portfolio profile.

abstract class _$ProfileController extends $AsyncNotifier<Profile?> {
  FutureOr<Profile?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Profile?>, Profile?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<Profile?>, Profile?>,
        AsyncValue<Profile?>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
