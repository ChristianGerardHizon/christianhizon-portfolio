import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/messages.routes.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../controllers/messages_controller.dart';
import 'empty_detail_state.dart';
import 'message_list_panel.dart';

/// Two-pane tablet layout for messages.
///
/// Left pane: Message list with filters
/// Right pane: Message detail from router or empty state
class TabletMessagesLayout extends ConsumerWidget {
  const TabletMessagesLayout({
    super.key,
    required this.detailChild,
  });

  /// The detail panel content from the router.
  final Widget detailChild;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(messagesControllerProvider);
    final messagesController = ref.read(messagesControllerProvider.notifier);

    // Get selected message ID from current route
    final routerState = GoRouterState.of(context);
    final selectedMessageId = routerState.pathParameters['id'];

    return messagesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            Text('Error: ${error.toString()}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => messagesController.refresh(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (messages) => Row(
        children: [
          // List panel
          SizedBox(
            width: 320,
            child: MessageListPanel(
              messages: messages,
              selectedId: selectedMessageId,
              onMessageTap: (message) {
                // Navigate using the route - this updates the URL and detail panel
                MessageDetailRoute(id: message.id).go(context);
              },
              onRefresh: () => messagesController.refresh(),
              onCancel: (message) => _confirmCancel(context, ref, message),
              onRetry: (message) => _confirmRetry(context, ref, message),
              onDelete: (message) => _confirmDelete(context, ref, message),
            ),
          ),
          const VerticalDivider(width: 1),
          // Detail panel from router
          Expanded(
            child: selectedMessageId != null
                ? detailChild
                : const EmptyMessageDetailState(),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmCancel(
      BuildContext context, WidgetRef ref, dynamic message) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Message'),
        content: const Text(
          'Are you sure you want to cancel this message? It will not be sent.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No, Keep It'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final success = await ref
          .read(messagesControllerProvider.notifier)
          .cancelMessage(message.id);

      if (context.mounted) {
        if (success) {
          showSuccessSnackBar(context, message: 'Message cancelled');
        } else {
          showErrorSnackBar(context, message: 'Failed to cancel message');
        }
      }
    }
  }

  Future<void> _confirmRetry(
      BuildContext context, WidgetRef ref, dynamic message) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Retry Message'),
        content: const Text(
          'Are you sure you want to retry sending this message? It will be queued for sending again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Retry'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final success = await ref
          .read(messagesControllerProvider.notifier)
          .retryMessage(message.id);

      if (context.mounted) {
        if (success) {
          showSuccessSnackBar(context, message: 'Message queued for retry');
        } else {
          showErrorSnackBar(context, message: 'Failed to retry message');
        }
      }
    }
  }

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, dynamic message) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Message'),
        content: const Text(
          'Are you sure you want to delete this message? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final success = await ref
          .read(messagesControllerProvider.notifier)
          .deleteMessage(message.id);

      if (context.mounted) {
        if (success) {
          showSuccessSnackBar(context, message: 'Message deleted');
        } else {
          showErrorSnackBar(context, message: 'Failed to delete message');
        }
      }
    }
  }
}
