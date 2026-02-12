import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/breakpoints.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../controllers/membership_provider.dart';
import '../controllers/memberships_controller.dart';
import '../widgets/membership_form_dialog.dart';

/// Membership plan detail page.
class MembershipDetailPage extends HookConsumerWidget {
  const MembershipDetailPage({
    super.key,
    required this.membershipId,
  });

  final String membershipId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membershipAsync = ref.watch(membershipProvider(membershipId));
    final isTablet = Breakpoints.isTabletOrLarger(context);

    return membershipAsync.when(
      data: (membership) {
        if (membership == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Membership Not Found'),
              automaticallyImplyLeading: !isTablet,
            ),
            body: const Center(
              child: Text('The requested membership plan could not be found.'),
            ),
          );
        }

        final theme = Theme.of(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(membership.name),
            automaticallyImplyLeading: !isTablet,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  ref.invalidate(membershipProvider(membershipId));
                  showInfoSnackBar(
                    context,
                    message: 'Refreshing...',
                    duration: const Duration(seconds: 1),
                  );
                },
                tooltip: 'Refresh',
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _showEditSheet(context, ref),
              ),
              PopupMenuButton<String>(
                onSelected: (value) =>
                    _handleMenuAction(context, ref, value, membership.id),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete, color: Colors.red),
                      title: Text('Delete'),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Membership plan info card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Plan Details',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      _InfoRow(label: 'Name', value: membership.name),
                      if (membership.description != null &&
                          membership.description!.isNotEmpty)
                        _InfoRow(
                          label: 'Description',
                          value: membership.description!,
                        ),
                      _InfoRow(
                        label: 'Duration',
                        value: membership.durationDisplay,
                      ),
                      _InfoRow(
                        label: 'Price',
                        value: membership.price.toCurrency(),
                      ),
                      _InfoRow(
                        label: 'Status',
                        value: membership.isActive ? 'Active' : 'Inactive',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(automaticallyImplyLeading: !isTablet),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(automaticallyImplyLeading: !isTablet),
        body: Center(child: Text('Error: $error')),
      ),
    );
  }

  void _showEditSheet(BuildContext context, WidgetRef ref) async {
    final membership = ref.read(membershipProvider(membershipId)).value;
    if (membership == null) return;

    final result = await showMembershipFormDialog(
      context,
      membership: membership,
    );

    if (result == true) {
      ref.invalidate(membershipProvider(membershipId));
      ref.read(membershipsControllerProvider.notifier).refresh();
    }
  }

  void _handleMenuAction(
    BuildContext context,
    WidgetRef ref,
    String action,
    String id,
  ) async {
    if (action == 'delete') {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Membership'),
          content: const Text(
            'Are you sure you want to delete this membership plan?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
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
            .read(membershipsControllerProvider.notifier)
            .deleteMembership(id);
        if (success && context.mounted) {
          showSuccessSnackBar(context, message: 'Membership plan deleted');
          context.pop();
        } else if (context.mounted) {
          showErrorSnackBar(
            context,
            message: 'Failed to delete membership plan',
          );
        }
      }
    }
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
