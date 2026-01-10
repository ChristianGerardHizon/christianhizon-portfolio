import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key, this.onPress, this.message});

  final Function? onPress;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          MIcons.packageVariant,
          size: 80,
          color: Theme.of(context).disabledColor,
        ),
        const SizedBox(height: 12),
        Text(message ?? 'app.list.emptyTitle',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).disabledColor,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(height: 8),
        Text('app.list.emptySubtitle',
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).disabledColor,
            )),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => onPress?.call(),
          child: const Text('app.list.reload'),
        )
      ],
    );
  }
}
