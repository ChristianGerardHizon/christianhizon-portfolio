import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/profile_repository.dart';
import '../../domain/profile.dart';

part 'profile_controller.g.dart';

/// Controller for managing the portfolio profile.
@riverpod
class ProfileController extends _$ProfileController {
  @override
  Future<Profile?> build() async {
    final repo = ref.watch(profileRepositoryProvider);
    final result = await repo.getProfile();
    return result.fold(
      (failure) => null,
      (profile) => profile,
    );
  }

  /// Save profile data (create or update).
  Future<bool> save({
    String? id,
    required Map<String, dynamic> data,
  }) async {
    final repo = ref.read(profileRepositoryProvider);
    final result = await repo.saveProfile(id: id, data: data);
    return result.fold(
      (failure) => false,
      (profile) {
        state = AsyncData(profile);
        return true;
      },
    );
  }

  /// Refresh profile data from server.
  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
