import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/routing/routes/messages.routes.dart';
import '../../../../core/utils/breakpoints.dart';
import '../../domain/message.dart';
import '../controllers/messages_controller.dart';

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
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(messageProvider(message.id));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Refreshing...'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showMoreOptions(context, ref),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status badge
            _buildStatusChip(context),
            const SizedBox(height: 24),

            // Phone
            _DetailRow(
              icon: Icons.phone,
              label: 'Phone',
              value: message.phone,
            ),
            const SizedBox(height: 16),

            // Content
            _DetailRow(
              icon: Icons.message,
              label: 'Message',
              value: message.content,
            ),
            const SizedBox(height: 16),

            // Scheduled time
            _DetailRow(
              icon: Icons.schedule,
              label: 'Scheduled',
              value: _formatDateTime(message.sendDateTime),
            ),

            // Patient
            if (message.patientDisplayName != null) ...[
              const SizedBox(height: 16),
              _DetailRow(
                icon: Icons.pets,
                label: 'Patient',
                value: message.patientDisplayName!,
              ),
            ],

            // Sent time
            if (message.sentAt != null) ...[
              const SizedBox(height: 16),
              _DetailRow(
                icon: Icons.check_circle,
                label: 'Sent',
                value: _formatDateTime(message.sentAt!),
                valueColor: Colors.green,
              ),
            ],

            // Error message
            if (message.isFailed && message.errorMessage != null) ...[
              const SizedBox(height: 16),
              _DetailRow(
                icon: Icons.error,
                label: 'Error',
                value: message.errorMessage!,
                valueColor: theme.colorScheme.error,
              ),
            ],

            // Notes
            if (message.notes != null && message.notes!.isNotEmpty) ...[
              const SizedBox(height: 16),
              _DetailRow(
                icon: Icons.notes,
                label: 'Notes',
                value: message.notes!,
              ),
            ],

            const SizedBox(height: 32),

            // Quick actions
            if (message.canCancel) ...[
              const Divider(),
              const SizedBox(height: 16),
              Text(
                'Actions',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _confirmCancel(context, ref),
                    icon: const Icon(Icons.cancel, color: Colors.orange),
                    label: const Text('Cancel Message'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    final (color, label, icon) = switch (message.status) {
      MessageStatus.pending => (
          Theme.of(context).colorScheme.primary,
          'Pending',
          Icons.schedule
        ),
      MessageStatus.sent => (Colors.green, 'Sent', Icons.check_circle),
      MessageStatus.failed => (
          Theme.of(context).colorScheme.error,
          'Failed',
          Icons.error
        ),
      MessageStatus.cancelled => (
          Theme.of(context).colorScheme.outline,
          'Cancelled',
          Icons.cancel
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, yyyy h:mm a').format(dateTime);
  }

  void _showMoreOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (message.canCancel)
              ListTile(
                leading: const Icon(Icons.cancel, color: Colors.orange),
                title: const Text('Cancel Message'),
                onTap: () {
                  Navigator.pop(context);
                  _confirmCancel(context, ref);
                },
              ),
            ListTile(
              leading:
                  Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
              title: Text(t.common.delete,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.error)),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Message cancelled'
                          : 'Failed to cancel message',
                    ),
                  ),
                );
                if (success) {
                  ref.invalidate(messageProvider(message.id));
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Message deleted')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to delete message')),
                  );
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
