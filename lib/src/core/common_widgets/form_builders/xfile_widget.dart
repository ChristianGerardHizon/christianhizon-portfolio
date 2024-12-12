import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'xfile_widget.g.dart';

@riverpod
class XFileController extends _$XFileController {
  @override
  FutureOr<Uint8List> build(XFile file) async {
    return file.readAsBytes();
  }
}

class XFileWidget extends HookConsumerWidget {
  const XFileWidget({super.key, required this.file});

  final XFile file;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(xFileControllerProvider(file));

    return state.when(
      data: (bytes) => Image.memory(
        bytes,
        width: double.maxFinite,
      ),
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => const Text('Error loading file'),
    );
  }
}
