import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/user_repository.dart';
import '../../domain/user.dart';

part 'user_provider.g.dart';

/// Provider for a single user by ID.
@riverpod
Future<User?> user(Ref ref, String id) async {
  final repository = ref.read(userRepositoryProvider);
  final result = await repository.fetchOne(id);

  return result.fold(
    (failure) => null,
    (user) => user,
  );
}
