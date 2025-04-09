import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class KpiCard extends HookConsumerWidget {
  final Icon icon;
  final String title;

  final String value;

  KpiCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      child: Column(
        children: [
          ListTile(
            leading: icon,
            title: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(),
          Padding(
            padding: theme.listTileTheme.contentPadding ?? EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: theme.textTheme.labelMedium,
                  ),
                ),
                Text(
                  'last period',
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
