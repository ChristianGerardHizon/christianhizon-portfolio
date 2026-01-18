import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../storage/secure_storage_provider.dart';

part 'pocketbase_provider.g.dart';

/// Environment URLs for PocketBase
abstract class PocketBaseUrls {
  static const String dev = 'http://127.0.0.1:8090';
  static const String prod = 'https://staging.sannjoseanimalclinic.com';
}

/// Controller for toggling between dev and production PocketBase instances.
///
/// Stores the preference in secure storage and provides methods to toggle.
@Riverpod(keepAlive: true)
class PbDebugController extends _$PbDebugController {
  static const _key = 'pb_debug_mode';

  FlutterSecureStorage get _storage => ref.read(secureStorageProvider);

  @override
  Future<bool> build() async {
    final value = await _storage.read(key: _key);
    return value == 'true';
  }

  /// Toggle between dev and production mode.
  Future<void> toggle() async {
    final current = state.value ?? false;
    await _storage.write(key: _key, value: (!current).toString());
    ref.invalidateSelf();
  }

  /// Get the current debug mode value.
  Future<bool> get() async {
    final value = await _storage.read(key: _key);
    return value == 'true';
  }
}

/// Provides a singleton PocketBase instance.
///
/// The instance switches between dev and production URLs based on
/// the [PbDebugController] state.
@Riverpod(keepAlive: true)
PocketBase pocketbase(Ref ref) {
  return PocketBase(PocketBaseUrls.prod);
}
