import 'package:flutter/material.dart';
import 'package:gym_system/src/features/system_versions/presentation/controllers/status_system_version_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class SystemVersionWidget extends HookConsumerWidget {
  const SystemVersionWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(statusSystemVersionControllerProvider);
    final theme = Theme.of(context);
    return state.maybeWhen(
      orElse: () => const SizedBox(),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (data) {
        final hasNewVersion = data.hasUpdate;

        if (hasNewVersion) {
          return InkWell(
            onTap: () => launchUrl(Uri.parse(data.mobileUrl)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'New Version Available',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.blueAccent,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          );
        }

        return SizedBox();
      },
    );
  }
}
