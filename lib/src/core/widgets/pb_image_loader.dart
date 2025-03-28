import 'package:flutter/material.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/widgets/center_progress_indicator.dart';
import 'package:gym_system/src/features/settings/presentation/controllers/settings_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PbImageLoader extends ConsumerWidget {
  const PbImageLoader({
    super.key,
    required this.builder,
    this.placeholder,
    required this.collection,
    required this.file,
    required this.id,
    this.loader,
    this.error,
  });

  final String collection;
  final String id;
  final String file;
  final Widget? placeholder;
  final Widget Function(String url) builder;
  final Widget Function()? loader;
  final Widget Function()? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsControllerProvider);

    return state.when(
      data: (setting) {
        final pb = ref.read(pocketbaseProvider);

        final url = '${pb.baseURL}/api/files/$collection/$id/$file';
        return builder(url);
      },
      error: (error, stack) => Center(
        child: Text(error.toString()),
      ),
      loading: () => loader?.call() ?? CenteredProgressIndicator(),
    );
  }
}
