import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'pocketbase.g.dart';

@riverpod
class PbDebugController extends _$PbDebugController {
  @override
  bool build() {
    return kDebugMode;
  }

  void toggle() {
    state = !state;
  }
}

@Riverpod(keepAlive: true)
PocketBase pocketbase(Ref ref) {
  // return PocketBase('https://hizonelaundry.sannjosevet.xyz/');

  if (ref.watch(pbDebugControllerProvider)) {
    return PocketBase('https://dev.sannjosevet.xyz');
    //   // return PocketBase('http://127.0.0.1:8090');
  } else {
    return PocketBase('https://www.sannjosevet.xyz');
  }
}
