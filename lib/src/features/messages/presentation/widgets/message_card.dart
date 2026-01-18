import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/message.dart';

/// Card widget displaying a message with status and actions.
class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.message,
    this.onTap,
    this.onCancel,
    this.onDelete,
  });

  final Message message;
  final VoidCallback? onTap;
  final VoidCallback? onCancel;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with phone and status
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      message.phone,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  _MessageStatusChip(status: message.status),
                  if ((onCancel != null && message.canCancel) || onDelete != null)
                    _buildPopupMenu(context),
                ],
              ),

              const SizedBox(height: 12),

              // Message content
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.message_outlined,
                    size: 16,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      message.content,
                      style: theme.textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Scheduled send time
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Scheduled: ${_formatDateTime(message.sendDateTime)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),

              // Patient info (if linked)
              if (message.patientDisplayName != null) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.pets,
                      size: 16,
                      color: theme.colorScheme.outline,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      message.patientDisplayName!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],

              // Sent time (if sent)
              if (message.sentAt != null) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Sent: ${_formatDateTime(message.sentAt!)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],

              // Error message (if failed)
              if (message.isFailed && message.errorMessage != null) ...[
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 16,
                      color: theme.colorScheme.error,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        message.errorMessage!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, yyyy h:mm a').format(dateTime);
  }

  Widget _buildPopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        if (onCancel != null && message.canCancel)
          const PopupMenuItem(
            value: 'cancel',
            child: ListTile(
              leading: Icon(Icons.cancel, color: Colors.orange),
              title: Text('Cancel'),
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
          ),
        if (onDelete != null) ...[
          if (onCancel != null && message.canCancel) const PopupMenuDivider(),
          const PopupMenuItem(
            value: 'delete',
            child: ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text('Delete', style: TextStyle(color: Colors.red)),
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
          ),
        ],
      ],
      onSelected: (value) {
        if (value == 'cancel') {
          onCancel?.call();
        } else if (value == 'delete') {
          onDelete?.call();
        }
      },
    );
  }
}

/// Chip displaying message status.
class _MessageStatusChip extends StatelessWidget {
  const _MessageStatusChip({required this.status});

  final MessageStatus status;

  @override
  Widget build(BuildContext context) {
    final (color, label, icon) = _getStatusInfo(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  (Color, String, IconData) _getStatusInfo(BuildContext context) {
    final theme = Theme.of(context);

    switch (status) {
      case MessageStatus.pending:
        return (theme.colorScheme.primary, 'Pending', Icons.schedule);
      case MessageStatus.sent:
        return (Colors.green, 'Sent', Icons.check_circle);
      case MessageStatus.failed:
        return (theme.colorScheme.error, 'Failed', Icons.error);
      case MessageStatus.cancelled:
        return (theme.colorScheme.outline, 'Cancelled', Icons.cancel);
    }
  }
}
