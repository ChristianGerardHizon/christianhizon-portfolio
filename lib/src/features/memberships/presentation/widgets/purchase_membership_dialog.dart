import 'package:flutter/material.dart';

import '../../../../core/widgets/dialog/dialog_constraints.dart';
import '../../../../core/widgets/dialog_close_handler.dart';
import 'membership_purchase_content.dart';

/// Shows a dialog for purchasing a membership for a member.
///
/// Returns `true` if the membership was purchased successfully.
Future<bool?> showPurchaseMembershipDialog(
  BuildContext context, {
  required String memberId,
  required String memberName,
}) {
  return showConstrainedDialog<bool>(
    context: context,
    builder: (context) => PurchaseMembershipDialog(
      memberId: memberId,
      memberName: memberName,
    ),
  );
}

class PurchaseMembershipDialog extends StatelessWidget {
  const PurchaseMembershipDialog({
    super.key,
    required this.memberId,
    required this.memberName,
  });

  final String memberId;
  final String memberName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScaffoldMessenger(
      child: Builder(
        builder: (context) => DialogCloseHandler(
          child: ConstrainedDialogContent(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
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

                // Plan list, add-ons, and purchase button
                Expanded(
                  child: MembershipPurchaseContent(
                    memberId: memberId,
                    memberName: memberName,
                    onPurchased: () => Navigator.of(context).pop(true),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
