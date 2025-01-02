import 'package:flutter/widgets.dart';
import 'package:gym_system/src/core/controllers/package_info_controller.dart';
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
            packageInfo.version,
            textAlign: TextAlign.left,
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
