import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/message.dart';

/// Card widget displaying a message with status and actions.
///
/// Follows the design pattern from TreatmentRecordCard with:
/// - Icon box on the left
/// - Main content in the middle
/// - Menu button on the right
/// - Status and metadata in a linked items section
class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.message,
    this.isSelected = false,
    this.onTap,
    this.onCancel,
    this.onDelete,
  });

  final Message message;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onCancel;
  final VoidCallback? onDelete;

  IconData _getStatusIcon() {
    switch (message.status) {
      case MessageStatus.pending:
        return Icons.schedule;
      case MessageStatus.sent:
        return Icons.check_circle;
      case MessageStatus.failed:
        return Icons.error;
      case MessageStatus.cancelled:
        return Icons.cancel;
    }
  }

  (Color, Color) _getStatusColors(ThemeData theme) {
    switch (message.status) {
      case MessageStatus.pending:
        return (theme.colorScheme.primaryContainer, theme.colorScheme.primary);
      case MessageStatus.sent:
        return (Colors.green.withValues(alpha: 0.15), Colors.green);
      case MessageStatus.failed:
        return (theme.colorScheme.errorContainer, theme.colorScheme.error);
      case MessageStatus.cancelled:
        return (theme.colorScheme.surfaceContainerHighest, theme.colorScheme.outline);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (containerColor, iconColor) = _getStatusColors(theme);

    return Card(
      clipBehavior: Clip.antiAlias,
      color: isSelected ? theme.colorScheme.primaryContainer : null,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main row with icon, content, and menu
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status icon box
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getStatusIcon(),
                      color: iconColor,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.phone,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message.content,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Menu
                  if ((onCancel != null && message.canCancel) || onDelete != null)
                    _buildPopupMenu(context),
                ],
              ),

              // Metadata section
              const SizedBox(height: 12),
              Divider(color: theme.colorScheme.outlineVariant, height: 1),
              const SizedBox(height: 12),

              // Status and metadata chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  // Status chip
                  _MetadataChip(
                    icon: _getStatusIcon(),
                    label: _getStatusLabel(),
                    color: containerColor,
                    textColor: iconColor,
                  ),

                  // Scheduled time chip
                  _MetadataChip(
                    icon: Icons.event,
                    label: _formatDateTime(message.sendDateTime),
                    color: theme.colorScheme.surfaceContainerHighest,
                    textColor: theme.colorScheme.onSurfaceVariant,
                  ),

                  // Patient chip (if linked)
                  if (message.patientDisplayName != null)
                    _MetadataChip(
                      icon: Icons.pets,
                      label: message.patientDisplayName!,
                      color: theme.colorScheme.secondaryContainer,
                      textColor: theme.colorScheme.onSecondaryContainer,
                    ),

                  // Sent time (if sent)
                  if (message.sentAt != null)
                    _MetadataChip(
                      icon: Icons.send,
                      label: 'Sent ${_formatDateTime(message.sentAt!)}',
                      color: Colors.green.withValues(alpha: 0.15),
                      textColor: Colors.green,
                    ),
                ],
              ),

              // Error message (if failed)
              if (message.isFailed && message.errorMessage != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
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
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _getStatusLabel() {
    switch (message.status) {
      case MessageStatus.pending:
        return 'Pending';
      case MessageStatus.sent:
        return 'Sent';
      case MessageStatus.failed:
        return 'Failed';
      case MessageStatus.cancelled:
        return 'Cancelled';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, h:mm a').format(dateTime);
  }

  Widget _buildPopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => [
        if (onCancel != null && message.canCancel)
          const PopupMenuItem(
            value: 'cancel',
            child: Row(
              children: [
                Icon(Icons.cancel, size: 20, color: Colors.orange),
                SizedBox(width: 8),
                Text('Cancel'),
              ],
            ),
          ),
        if (onDelete != null) ...[
          if (onCancel != null && message.canCancel) const PopupMenuDivider(),
          const PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, size: 20, color: Colors.red),
                SizedBox(width: 8),
                Text('Delete', style: TextStyle(color: Colors.red)),
              ],
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

/// A chip displaying metadata (status, time, patient, etc.).
class _MetadataChip extends StatelessWidget {
  const _MetadataChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
