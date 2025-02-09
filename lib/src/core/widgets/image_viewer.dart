import 'package:flutter/material.dart';
import 'package:gym_system/src/core/widgets/center_progress_indicator.dart';
import 'package:gym_system/src/features/settings/presentation/controllers/settings_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImageViewer extends ConsumerWidget {
  const ImageViewer({
    super.key,
    required this.builder,
    this.placeholder,
    required this.feature,
    required this.file,
    required this.id,
    this.loader,
    this.error,
  });

  final String feature;
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
        final url = '${setting.domain}/api/files/$feature/$id/$file';
        return builder(url);
      },
      error: (error, stack) => Center(
        child: Text(error.toString()),
      ),
      loading: () =>
          loader?.call() ?? CenteredProgressIndicator(),
    );
  }
}
