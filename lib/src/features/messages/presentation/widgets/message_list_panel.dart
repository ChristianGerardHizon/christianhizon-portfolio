import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/message.dart';
import '../controllers/messages_controller.dart';
import 'message_card.dart';
import 'sheets/create_message_sheet.dart';

/// Message list panel with filter header.
///
/// Used in both mobile list page and tablet two-pane layout.
class MessageListPanel extends HookConsumerWidget {
  const MessageListPanel({
    super.key,
    required this.messages,
    required this.selectedId,
    required this.onMessageTap,
    required this.onRefresh,
    required this.onCancel,
    required this.onRetry,
    required this.onDelete,
  });

  final List<Message> messages;
  final String? selectedId;
  final ValueChanged<Message> onMessageTap;
  final Future<void> Function() onRefresh;
  final Future<void> Function(Message message) onCancel;
  final Future<void> Function(Message message) onRetry;
  final Future<void> Function(Message message) onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selectedFilter = useState<MessageStatus?>(null);

    // Apply filter
    final filteredMessages = selectedFilter.value == null
        ? messages
        : messages.where((m) => m.status == selectedFilter.value).toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateMessageSheet(context, ref),
        tooltip: 'New Message',
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            color: theme.colorScheme.surfaceContainerHighest,
            child: Row(
              children: [
                Text('Messages', style: theme.textTheme.titleLarge),
                const Spacer(),
                Text(
                  '${messages.length} total',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),

          // Filter bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(
                    label: 'All',
                    selected: selectedFilter.value == null,
                    onSelected: () => selectedFilter.value = null,
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Pending',
                    selected: selectedFilter.value == MessageStatus.pending,
                    onSelected: () =>
                        selectedFilter.value = MessageStatus.pending,
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Sent',
                    selected: selectedFilter.value == MessageStatus.sent,
                    onSelected: () => selectedFilter.value = MessageStatus.sent,
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Failed',
                    selected: selectedFilter.value == MessageStatus.failed,
                    onSelected: () =>
                        selectedFilter.value = MessageStatus.failed,
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Cancelled',
                    selected: selectedFilter.value == MessageStatus.cancelled,
                    onSelected: () =>
                        selectedFilter.value = MessageStatus.cancelled,
                  ),
                ],
              ),
            ),
          ),

          // Message list
          Expanded(
            child: filteredMessages.isEmpty
                ? Center(
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
                  )
                : RefreshIndicator(
                    onRefresh: onRefresh,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredMessages.length,
                      itemBuilder: (context, index) {
                        final message = filteredMessages[index];
                        final isSelected = message.id == selectedId;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: MessageCard(
                            message: message,
                            isSelected: isSelected,
                            onTap: () => onMessageTap(message),
                            onCancel: message.canCancel
                                ? () => onCancel(message)
                                : null,
                            onRetry: message.canRetry
                                ? () => onRetry(message)
                                : null,
                            onDelete: () => onDelete(message),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
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
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      showCheckmark: false,
    );
  }
}
