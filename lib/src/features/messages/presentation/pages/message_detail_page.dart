import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../../../core/routing/routes/messages.routes.dart';
import '../../../../core/utils/breakpoints.dart';
import '../../domain/message.dart';
import '../controllers/messages_controller.dart';
import '../widgets/sheets/edit_message_sheet.dart';

/// Message detail page showing full message information.
///
/// Displays message details with actions in AppBar:
/// - Refresh, Edit, More options (cancel/delete)
class MessageDetailPage extends ConsumerWidget {
  const MessageDetailPage({
    super.key,
    required this.messageId,
  });

  final String messageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageAsync = ref.watch(messageProvider(messageId));
    final isTablet = Breakpoints.isTabletOrLarger(context);
    final t = Translations.of(context);

    return messageAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(
          leading: isTablet
              ? null
              : IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => const MessagesRoute().go(context),
                ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('Error loading message: ${error.toString()}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(messageProvider(messageId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (message) {
        if (message == null) {
          return Scaffold(
            appBar: AppBar(
              leading: isTablet
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => const MessagesRoute().go(context),
                    ),
            ),
            body: const Center(
              child: Text('Message not found'),
            ),
          );
        }

        return _MessageDetailContent(
          message: message,
          isTablet: isTablet,
          t: t,
        );
      },
    );
  }
}

class _MessageDetailContent extends ConsumerWidget {
  const _MessageDetailContent({
    required this.message,
    required this.isTablet,
    required this.t,
  });

  final Message message;
  final bool isTablet;
  final Translations t;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !isTablet,
        leading: isTablet
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => const MessagesRoute().go(context),
              ),
        title: Text('Message to ${message.phone}'),
        actions: [
          if (message.canCancel)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _showEditSheet(context, ref),
              tooltip: 'Edit',
            ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showMoreOptions(context, ref),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(messageProvider(message.id));
          await ref.read(messageProvider(message.id).future);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Card
              _buildStatusCard(context),
              const SizedBox(height: 16),

              // Message Content Card
              _buildMessageCard(context, theme),
              const SizedBox(height: 16),

              // Schedule & Delivery Card
              _buildScheduleCard(context, theme),

              // Error Card (if failed)
              if (message.isFailed && message.errorMessage != null) ...[
                const SizedBox(height: 16),
                _buildErrorCard(context, ref, theme),
              ],

              // Notes Card (if present)
              if (message.notes != null && message.notes!.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildNotesCard(context, theme),
              ],

              // Quick Actions Card
              if (message.canCancel || message.canRetry) ...[
                const SizedBox(height: 16),
                _buildActionsCard(context, ref, theme),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    final theme = Theme.of(context);
    final (color, label, icon) = switch (message.status) {
      MessageStatus.pending => (
          theme.colorScheme.primary,
          'Pending',
          Icons.schedule
        ),
      MessageStatus.sent => (Colors.green, 'Sent', Icons.check_circle),
      MessageStatus.failed => (theme.colorScheme.error, 'Failed', Icons.error),
      MessageStatus.cancelled => (
          theme.colorScheme.outline,
          'Cancelled',
          Icons.cancel
        ),
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageCard(BuildContext context, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.message,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Message Details',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Recipient
            _DetailRow(
              icon: Icons.phone,
              label: 'Recipient',
              value: message.phone,
            ),
            const SizedBox(height: 12),

            // Patient (if linked)
            if (message.patientDisplayName != null) ...[
              _DetailRow(
                icon: Icons.pets,
                label: 'Patient',
                value: message.patientDisplayName!,
              ),
              const SizedBox(height: 12),
            ],

            // Message content
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Content',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.content,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleCard(BuildContext context, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Schedule & Delivery',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Scheduled time
            _DetailRow(
              icon: Icons.event,
              label: 'Scheduled For',
              value: _formatDateTime(message.sendDateTime),
            ),

            // Sent time (if sent)
            if (message.sentAt != null) ...[
              const SizedBox(height: 12),
              _DetailRow(
                icon: Icons.check_circle,
                label: 'Sent At',
                value: _formatDateTime(message.sentAt!),
                valueColor: Colors.green,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard(BuildContext context, WidgetRef ref, ThemeData theme) {
    return Card(
      color: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.error,
                  size: 20,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(width: 8),
                Text(
                  'Error Details',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.error,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              message.errorMessage!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            if (message.canRetry) ...[
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => _confirmRetry(context, ref),
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Retry Message'),
                style: FilledButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNotesCard(BuildContext context, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.notes,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Notes',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              message.notes!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsCard(
      BuildContext context, WidgetRef ref, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.touch_app,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Quick Actions',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: () => _showEditSheet(context, ref),
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Edit Message'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _confirmCancel(context, ref),
                  icon:
                      const Icon(Icons.cancel, size: 18, color: Colors.orange),
                  label: const Text('Cancel Message'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.orange,
                    side: const BorderSide(color: Colors.orange),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, yyyy h:mm a').format(dateTime);
  }

  void _showEditSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => EditMessageSheet(
        message: message,
        onSave: (updatedMessage) async {
          final success = await ref
              .read(messagesControllerProvider.notifier)
              .updateMessage(updatedMessage);

          if (success) {
            ref.invalidate(messageProvider(message.id));
            return updatedMessage;
          }
          return null;
        },
      ),
    );
  }

  void _showMoreOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (message.canCancel) ...[
              ListTile(
                leading: Icon(Icons.edit,
                    color: Theme.of(context).colorScheme.primary),
                title: const Text('Edit Message'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _showEditSheet(context, ref);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel, color: Colors.orange),
                title: const Text('Cancel Message'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _confirmCancel(context, ref);
                },
              ),
            ],
            if (message.canRetry)
              ListTile(
                leading: Icon(Icons.refresh,
                    color: Theme.of(context).colorScheme.primary),
                title: const Text('Retry Message'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _confirmRetry(context, ref);
                },
              ),
            ListTile(
              leading: Icon(Icons.delete,
                  color: Theme.of(context).colorScheme.error),
              title: Text(t.common.delete,
                  style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(context, ref);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmCancel(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Message'),
        content: const Text(
          'Are you sure you want to cancel this message? It will not be sent.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No, Keep It'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await ref
                  .read(messagesControllerProvider.notifier)
                  .cancelMessage(message.id);

              if (context.mounted) {
                if (success) {
                  showSuccessSnackBar(context, message: 'Message cancelled');
                  ref.invalidate(messageProvider(message.id));
                } else {
                  showErrorSnackBar(context, message: 'Failed to cancel message');
                }
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  void _confirmRetry(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Retry Message'),
        content: const Text(
          'Are you sure you want to retry sending this message? It will be queued for sending again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await ref
                  .read(messagesControllerProvider.notifier)
                  .retryMessage(message.id);

              if (context.mounted) {
                if (success) {
                  showSuccessSnackBar(context, message: 'Message queued for retry');
                  ref.invalidate(messageProvider(message.id));
                } else {
                  showErrorSnackBar(context, message: 'Failed to retry message');
                }
              }
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.common.delete),
        content: const Text(
          'Are you sure you want to delete this message? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.common.cancel),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await ref
                  .read(messagesControllerProvider.notifier)
                  .deleteMessage(message.id);

              if (context.mounted) {
                if (success) {
                  const MessagesRoute().go(context);
                  showSuccessSnackBar(context, message: 'Message deleted');
                } else {
                  showErrorSnackBar(context, message: 'Failed to delete message');
                }
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(t.common.delete),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: theme.colorScheme.outline,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: valueColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
