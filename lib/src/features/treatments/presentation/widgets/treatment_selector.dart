import 'package:flutter/material.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/center_progress_indicator.dart';
import 'package:gym_system/src/features/treatments/domain/treatment.dart';
import 'package:gym_system/src/features/treatments/presentation/controllers/treatment/treatments_controller.dart';
import 'package:gym_system/src/features/treatments/presentation/sheets/treatment_create_sheet.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TreatmentSelector extends HookConsumerWidget {
  const TreatmentSelector({super.key, this.onPress, this.selected});

  final Treatment? selected;
  final Function(Treatment?)? onPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(treatmentsControllerProvider);

    addType() async {
      final result = await TreatmentCreateSheet.show(context);
      if (result != null) {
        ref.invalidate(treatmentsControllerProvider);
      }
    }

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
                ref.invalidate(treatmentsControllerProvider);
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
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: ChoiceChip(
                      label: Text('Details'),
                      selected: selected == null,
                      onSelected: (value) {
                        if (value) {
                          onPress?.call(null);
                        }
                      },
                    ),
                  ),

                  ///
                  /// Another Types
                  ///
                  ...data.items.map(
                    (e) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: ChoiceChip(
                          label: Text(e.name),
                          selected: selected?.id == e.id,
                          onSelected: (value) {
                            if (value) {
                              onPress?.call(e);
                            }
                          },
                        ),
                      );
                    },
                  ).toList(),

                  ///
                  /// Add Type Button
                  ///
                  ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: TextButton.icon(
                        onPressed: addType,
                        icon: Icon(MIcons.plus),
                        label: Text('Add Type'),
                      ),
                    ),
                  ]
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
