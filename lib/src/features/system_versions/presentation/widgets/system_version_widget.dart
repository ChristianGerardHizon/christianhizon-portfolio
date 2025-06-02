import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/utils/codemagic_utils.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/modals/dropdown_confirm_modal.dart';
import 'package:sannjosevet/src/features/system_versions/domain/system_artifact.dart';
import 'package:sannjosevet/src/features/system_versions/presentation/controllers/status_system_version_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class SystemVersionWidget extends HookConsumerWidget {
  const SystemVersionWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(statusSystemVersionControllerProvider);
    final theme = Theme.of(context);

    showUrl(List<SystemArtifact> artifacts) async {
      final result = await DropdownConfirmModal.showTaskResult<String>(
        context,
        title: 'Select Artifact',
        options: artifacts
            .map((e) => DropdownConfirmOption(label: e.display, value: e.url))
            .toList(),
        confirm: 'Download',
        cancel: 'Cancel',
      )
          .flatMap((url) =>
              CodeMagicUtils.generateArtifact(url, const Duration(days: 365)))
          .flatMap(_openUrl)
          .run();

      result.match(
        AppSnackBar.rootFailure,
        (r) => AppSnackBar.root(message: 'Opening artifact'),
      );
    }

    return state.maybeWhen(
      orElse: () => const SizedBox(),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (data) {
        final hasNewVersion = data.hasUpdate;

        if (hasNewVersion) {
          return InkWell(
            onTap: () => showUrl(data.artifacts),
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

TaskResult _openUrl(String url) {
  return TaskResult.tryCatch(() => launchUrl(Uri.parse(url)), Failure.handle);
}
