import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scaffold_controller.g.dart';

@riverpod
GlobalKey<ScaffoldState> scaffoldController(Ref ref) {
  return GlobalKey<ScaffoldState>();
}
