import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/message.dart';
import '../controllers/messages_controller.dart';
import '../widgets/message_card.dart';
import '../widgets/sheets/create_message_sheet.dart';

/// Main messages list page.
///
/// Displays all scheduled SMS messages with filtering options.
class MessagesPage extends HookConsumerWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final messagesAsync = ref.watch(messagesControllerProvider);
    final selectedFilter = useState<MessageStatus?>(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          // Filter dropdown
          PopupMenuButton<MessageStatus?>(
            icon: Badge(
              isLabelVisible: selectedFilter.value != null,
              child: const Icon(Icons.filter_list),
            ),
            tooltip: 'Filter by status',
            onSelected: (status) {
              selectedFilter.value = status;
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: null,
                child: Text('All'),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: MessageStatus.pending,
                child: Text('Pending'),
              ),
              const PopupMenuItem(
                value: MessageStatus.sent,
                child: Text('Sent'),
              ),
              const PopupMenuItem(
                value: MessageStatus.failed,
                child: Text('Failed'),
              ),
              const PopupMenuItem(
                value: MessageStatus.cancelled,
                child: Text('Cancelled'),
              ),
            ],
          ),
        ],
      ),
      body: messagesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Failed to load messages',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () =>
                    ref.read(messagesControllerProvider.notifier).refresh(),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (messages) {
          // Apply filter
          final filteredMessages = selectedFilter.value == null
              ? messages
              : messages
                  .where((m) => m.status == selectedFilter.value)
                  .toList();

          if (filteredMessages.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.message_outlined,
                    size: 64,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    selectedFilter.value != null
                        ? 'No ${selectedFilter.value!.name} messages'
                        : 'No messages yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create a message to get started',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(messagesControllerProvider.notifier).refresh(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredMessages.length,
              itemBuilder: (context, index) {
                final message = filteredMessages[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: MessageCard(
                    message: message,
                    onTap: () => _showMessageDetail(context, message),
                    onCancel: message.canCancel
                        ? () => _confirmCancel(context, ref, message)
                        : null,
                    onDelete: () => _confirmDelete(context, ref, message),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateMessageSheet(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('New Message'),
      ),
    );
  }

  void _showCreateMessageSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => CreateMessageSheet(
        onSave: (message) async {
          final created = await ref
              .read(messagesControllerProvider.notifier)
              .createMessageAndReturn(message);
          return created;
        },
      ),
    );
  }

  void _showMessageDetail(BuildContext context, Message message) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => _MessageDetailSheet(message: message),
    );
  }

  void _confirmCancel(BuildContext context, WidgetRef ref, Message message) {
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

  void _confirmDelete(BuildContext context, WidgetRef ref, Message message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Message'),
        content: const Text(
          'Are you sure you want to delete this message? This action cannot be undone.',
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
                  .deleteMessage(message.id);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Message deleted'
                          : 'Failed to delete message',
                    ),
                  ),
                );
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// Bottom sheet showing full message details.
class _MessageDetailSheet extends StatelessWidget {
  const _MessageDetailSheet({required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Header
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Message Details',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                _buildStatusChip(context),
              ],
            ),
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
    final now = DateTime.now();
    final isToday = dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;

    final time =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

    if (isToday) {
      return 'Today at $time';
    }

    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year} at $time';
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
