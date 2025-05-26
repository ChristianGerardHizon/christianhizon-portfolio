import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/controllers/package_info_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppVersion extends HookConsumerWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(packageInfoControllerProvider);

    return state.when(
      data: (packageInfo) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Version ${packageInfo.version}+${packageInfo.buildNumber}',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: .5),
                ),
          ),
        );
      },
      error: (error, stack) {
        return Text('Failed to load app version');
      },
      loading: () => SizedBox(),
    );
  }
}
