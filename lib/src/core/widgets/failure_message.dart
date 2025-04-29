import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/widgets/collapsing_card.dart';

class FailureMessage extends HookWidget {
  final dynamic error;
  final StackTrace stack;
  const FailureMessage(this.error, this.stack, {super.key});

  @override
  Widget build(BuildContext context) {
    final errorData = error;

    if (errorData is Failure) {
      return SingleChildScrollView(
        child: Column(
          children: [
            CollapsingCard(
              canCollapse: false,
              header: Text(
                'Failure Message',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(errorData.message.toString()),
              ),
            ),
            CollapsingCard(
              expanded: false,
              header: Text(
                'Stack Trace',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(errorData.stackTrace.toString()),
              ),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Text(error.toString()),
    );
  }
}
