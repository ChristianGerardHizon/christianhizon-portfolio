import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:sannjosevet/src/core/packages/flutter_secure_storage.dart';

part 'pocketbase.g.dart';

@riverpod
class PbDebugController extends _$PbDebugController {
  final _key = 'pbDebug';
  @override
  Future<bool> build() async {
    return get();
  }

  Future<void> toggle() async {
    await save(!(state.valueOrNull ?? false));
    ref.invalidateSelf();
  }

  Future<void> save(bool value) async {
    final storage = ref.read(flutterSecureStorageProvider);
    await storage.deleteAll();
    return await storage.write(key: _key, value: value.toString());
  }

  Future<bool> get() async {
    final storage = ref.read(flutterSecureStorageProvider);
    final pbDebug = await storage.read(key: _key);
    final result = bool.tryParse(pbDebug ?? 'false') ?? false;
    return result;
  }
}

@Riverpod(keepAlive: true)
PocketBase pocketbase(Ref ref) {
  // return PocketBase('https://hizonelaundry.sannjosevet.xyz/');
  if (ref.watch(pbDebugControllerProvider).valueOrNull ?? false) {
    return PocketBase('https://dev.sannjosevet.xyz');
  } else {
    return PocketBase('https://www.sannjosevet.xyz');
  }
}
