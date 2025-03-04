import 'package:flutter/material.dart';
import 'package:gym_system/src/features/history/domain/history_type.dart';
import 'package:gym_system/src/features/history/presentation/sheets/history_create_sheet.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientHistoryView extends HookConsumerWidget {
  final HistoryType type;

  const PatientHistoryView({super.key, required this.type});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showCreateSheet() {
      HistoryCreateSheet.show(context, type: type);
    }

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
              onPressed: showCreateSheet,
              child: Text('Create New ${type.name}'))
        ],
      ),
    );
  }
}
