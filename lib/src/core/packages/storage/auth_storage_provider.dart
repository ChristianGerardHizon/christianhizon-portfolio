import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/auth/data/auth_dto.dart';
import 'secure_storage_provider.dart';

part 'auth_storage_provider.g.dart';

/// Storage key for persisting auth state.
const _authStorageKey = 'AUTH_STATE';

/// Provides auth storage operations for saving/loading authentication data.
@Riverpod(keepAlive: true)
AuthStorageService authStorage(Ref ref) {
  return AuthStorageService(ref.watch(secureStorageProvider));
}

/// Service for managing auth data in secure storage.
class AuthStorageService {
  final FlutterSecureStorage _storage;

  AuthStorageService(this._storage);

  /// Saves auth data to secure storage.
  Future<void> save(AuthDto authDto) async {
    final json = authDto.toJson();
    await _storage.write(key: _authStorageKey, value: json);
  }

  /// Loads auth data from secure storage.
  ///
  /// Returns null if no auth data is stored.
  Future<AuthDto?> get() async {
    final json = await _storage.read(key: _authStorageKey);
    if (json == null) return null;
    return AuthDtoMapper.fromJson(json);
  }

  /// Clears auth data from secure storage.
  Future<void> clear() async {
    await _storage.delete(key: _authStorageKey);
  }
}
