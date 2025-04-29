import 'package:flutter/material.dart';
import 'package:gym_system/src/core/widgets/failure_message.dart';
import 'package:gym_system/src/features/change_logs/presentation/controllers/change_log_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangeLogPage extends HookConsumerWidget {
  const ChangeLogPage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = changeLogControllerProvider(id);
    final state = ref.watch(provider);

    refresh() async {
      ref.invalidate(provider);
    }

    return state.when(
      skipError: false,
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      error: (error, stack) => Scaffold(
        appBar: AppBar(
          title: Text('Something Went Wrong'),
        ),
        body: FailureMessage(error, stack),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (changeLogState) {
        final changeLog = changeLogState.changeLog;
        return Scaffold(
          appBar: AppBar(
            title: Text('Change Log'),
          ),
          body: Center(
            child: Text(changeLog.toJson()),
          ),
        );
      },
    );
  }
}
