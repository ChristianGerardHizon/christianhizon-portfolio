import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/flutter_secure_storage.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/settings/domain/settings.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'setting_repository.g.dart';

@Riverpod(keepAlive: true)
SettingRepository settingRepository(Ref ref) {
  return SettingRepository(
    storage: ref.read(flutterSecureStorageProvider),
  );
}

const String _settingsKey = 'settings';

class SettingRepository {
  final FlutterSecureStorage _storage;

  SettingRepository({
    required FlutterSecureStorage storage,
  }) : _storage = storage;

  TaskResult<Settings> set({required Settings settings}) {
    return TaskResult.tryCatch(() async {
      _storage.write(key: _settingsKey, value: jsonEncode(settings.toJson()));
      return settings;
    }, Failure.tryCatchData);
  }

  TaskResult<Settings> get() {
    return TaskResult.tryCatch(() async {
      final result = await _storage.read(key: _settingsKey);

      if (result == null) {
        return const Settings();
      }

      return Settings.fromJson(result);
    }, Failure.tryCatchData);
  }

  TaskResult<Settings> update({String? domain}) {
    return TaskResult.Do(($) async {
      final settings = await $(get());
      final updated = settings.copyWith();
      return await $(set(settings: updated));
    });
  }
}
