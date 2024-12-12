

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'pocketbase.g.dart';

@Riverpod(keepAlive: true)
PocketBase pocketbase(Ref ref) {
  return PocketBase('http://localhost:8090');
}