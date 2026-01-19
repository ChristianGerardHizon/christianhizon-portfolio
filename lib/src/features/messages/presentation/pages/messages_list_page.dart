import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/messages.routes.dart';
import '../controllers/messages_controller.dart';
import '../widgets/message_list_panel.dart';

/// Messages list page for mobile view.
///
/// Shows the message list panel and navigates to detail on tap.
class MessagesListPage extends ConsumerWidget {
  const MessagesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(messagesControllerProvider);

    return messagesAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('Error: ${error.toString()}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.read(messagesControllerProvider.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (messages) => MessageListPanel(
        messages: messages,
        selectedId: null,
        onMessageTap: (message) {
          MessageDetailRoute(id: message.id).push(context);
        },
        onRefresh: () =>
            ref.read(messagesControllerProvider.notifier).refresh(),
        onCancel: (message) => _confirmCancel(context, ref, message),
        onRetry: (message) => _confirmRetry(context, ref, message),
        onDelete: (message) => _confirmDelete(context, ref, message),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'Message cancelled' : 'Failed to cancel message',
            ),
          ),
        );
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'Message queued for retry' : 'Failed to retry message',
            ),
          ),
        );
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'Message deleted' : 'Failed to delete message',
            ),
          ),
        );
      }
    }
  }
}
