import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/currency_format.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../../settings/presentation/controllers/current_branch_controller.dart';
import '../../data/repositories/member_membership_repository.dart';
import '../../domain/membership.dart';
import '../controllers/memberships_controller.dart';

/// Shows a bottom sheet for purchasing a membership for a member.
///
/// Returns `true` if the membership was purchased successfully.
Future<bool?> showPurchaseMembershipSheet(
  BuildContext context, {
  required String memberId,
  required String memberName,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _PurchaseMembershipSheet(
      memberId: memberId,
      memberName: memberName,
    ),
  );
}

class _PurchaseMembershipSheet extends HookConsumerWidget {
  const _PurchaseMembershipSheet({
    required this.memberId,
    required this.memberName,
  });

  final String memberId;
  final String memberName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final membershipsAsync = ref.watch(membershipsControllerProvider);
    final selectedMembership = useState<Membership?>(null);
    final isPurchasing = useState(false);

    Future<void> handlePurchase() async {
      final plan = selectedMembership.value;
      if (plan == null) return;

      isPurchasing.value = true;

      final branchId = ref.read(currentBranchIdProvider) ?? '';
      final startDate = DateTime.now();
      final endDate = startDate.add(Duration(days: plan.durationDays));

      final repo = ref.read(memberMembershipRepositoryProvider);
      final result = await repo.create(
        memberId: memberId,
        membershipId: plan.id,
        startDate: startDate,
        endDate: endDate,
        branchId: branchId,
      );

      isPurchasing.value = false;

      result.fold(
        (failure) {
          if (context.mounted) {
            showErrorSnackBar(
              context,
              message: 'Failed to purchase membership',
              useRootMessenger: false,
            );
          }
        },
        (_) {
          if (context.mounted) {
            showSuccessSnackBar(
              context,
              message: 'Membership purchased for $memberName',
              useRootMessenger: false,
            );
            Navigator.of(context).pop(true);
          }
        },
      );
    }

    return ScaffoldMessenger(
      child: Builder(
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Purchase Membership',
                                style: theme.textTheme.titleLarge,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'For $memberName',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),

                  // Plan list
                  Expanded(
                    child: membershipsAsync.when(
                      data: (memberships) {
                        final activePlans =
                            memberships.where((m) => m.isActive).toList();

                        if (activePlans.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.card_membership_outlined,
                                  size: 48,
                                  color: theme.colorScheme.onSurfaceVariant
                                      .withValues(alpha: 0.5),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'No active membership plans available',
                                  style:
                                      theme.textTheme.bodyMedium?.copyWith(
                                    color:
                                        theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          controller: scrollController,
                          padding: const EdgeInsets.all(8),
                          itemCount: activePlans.length,
                          itemBuilder: (context, index) {
                            final plan = activePlans[index];
                            final isSelected =
                                selectedMembership.value?.id == plan.id;

                            return Card(
                              elevation: isSelected ? 2 : 0,
                              color: isSelected
                                  ? theme.colorScheme.primaryContainer
                                  : null,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: isSelected
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.surfaceContainerHighest,
                                  child: Icon(
                                    Icons.card_membership,
                                    color: isSelected
                                        ? theme.colorScheme.onPrimary
                                        : theme
                                            .colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                title: Text(plan.name),
                                subtitle: Text(
                                  '${plan.durationDisplay} - ${plan.price.toCurrency()}',
                                ),
                                trailing: isSelected
                                    ? Icon(
                                        Icons.check_circle,
                                        color: theme.colorScheme.primary,
                                      )
                                    : null,
                                onTap: () =>
                                    selectedMembership.value = plan,
                              ),
                            );
                          },
                        );
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (_, __) => Center(
                        child: Text(
                          'Error loading plans',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Purchase button
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: selectedMembership.value != null &&
                                !isPurchasing.value
                            ? handlePurchase
                            : null,
                        icon: isPurchasing.value
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.shopping_cart),
                        label: Text(
                          selectedMembership.value != null
                              ? 'Purchase ${selectedMembership.value!.name} - ${selectedMembership.value!.price.toCurrency()}'
                              : 'Select a plan',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
