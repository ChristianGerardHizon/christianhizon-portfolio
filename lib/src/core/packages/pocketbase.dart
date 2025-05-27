import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'pocketbase.g.dart';

@Riverpod(keepAlive: true)
PocketBase pocketbase(Ref ref) {
  // return PocketBase('https://www.sannjosevet.xyz');
  return PocketBase('https://dev.sannjosevet.xyz');
  // return PocketBase('http://127.0.0.1:8090');
}
