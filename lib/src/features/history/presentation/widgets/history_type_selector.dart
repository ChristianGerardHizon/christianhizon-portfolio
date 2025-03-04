import 'package:flutter/material.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/center_progress_indicator.dart';
import 'package:gym_system/src/features/history/domain/history_type.dart';
import 'package:gym_system/src/features/history/presentation/controllers/history_type/history_types_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HistoryTypeSelector extends HookConsumerWidget {
  const HistoryTypeSelector({super.key, this.onPress});

  final Function(HistoryType?)? onPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(historyTypesControllerProvider);

    return state.when(
      error: (error, stackTrace) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                error.toString(),
                maxLines: 1,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
            IconButton(
              onPressed: () {
                ref.invalidate(historyTypesControllerProvider);
              },
              icon: Icon(MIcons.refresh),
            ),
          ],
        ),
      ),
      loading: () => CenteredProgressIndicator(),
      data: (data) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SizedBox(
              height: 30,
              child: ListView(
                padding: EdgeInsets.only(left: 8, right: 8),
                scrollDirection: Axis.horizontal,
                children: [
                  ///
                  /// Main
                  ///
                  TextButton.icon(
                    icon: Icon(MIcons.speedometer),
                    onPressed: () => onPress?.call(null),
                    label: Text('Main'),
                  ),

                  ///
                  /// Another Types
                  ///
                  ...data.items.map(
                    (e) {
                      return TextButton.icon(
                        icon: Icon(MIcons.fromString(e.icon ?? '')),
                        onPressed: () => onPress?.call(e),
                        label: Text(e.name),
                      );
                    },
                  ).toList()
                ],
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
