import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/widgets/collapsing_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FailureMessage extends HookWidget {
  final dynamic error;
  final StackTrace? stack;
  const FailureMessage(this.error, this.stack, {super.key});

  static Widget? asyncValue(AsyncValue<dynamic> value) {
    if (!value.hasError) return null;
    return FailureMessage(value.error, value.stackTrace);
  }

  static Widget asyncValueWidget(AsyncValue<dynamic> value) {
    return FailureMessage(value.error, value.stackTrace);
  }

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
            if (errorData.stackTrace is StackTrace)
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
