import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/routing/routes/members.routes.dart';
import '../controllers/dashboard_members_controller.dart';

/// Section displaying all members with membership expiration tags.
///
/// Shows member name, membership plan, and an expiration chip:
/// - Red: expires today/tomorrow
/// - Orange: expires within 7 days
/// - Green: active membership (>7 days)
/// - Grey: no active membership
class DashboardMembersSection extends ConsumerWidget {
  const DashboardMembersSection({super.key});

  static const _maxVisible = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membersAsync = ref.watch(dashboardMembersProvider);

    return membersAsync.when(
      data: (members) {
        if (members.isEmpty) return const SizedBox.shrink();

        final visible = members.take(_maxVisible).toList();
        final hasMore = members.length > _maxVisible;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    Icons.people,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Members',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${members.length}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => const MembersRoute().go(context),
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Member list
              ...visible.map(
                (dm) => _DashboardMemberTile(dashboardMember: dm),
              ),
              if (hasMore)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Center(
                    child: TextButton(
                      onPressed: () => const MembersRoute().go(context),
                      child: Text(
                        '+ ${members.length - _maxVisible} more members',
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _DashboardMemberTile extends StatelessWidget {
  const _DashboardMemberTile({required this.dashboardMember});

  final DashboardMember dashboardMember;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final member = dashboardMember.member;
    final membership = dashboardMember.activeMembership;
    final days = dashboardMember.daysUntilExpiry;

    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => MemberDetailRoute(id: member.id).go(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor:
                    theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
                child: Icon(
                  Icons.person,
                  size: 20,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      membership?.membershipName ?? 'No active membership',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _ExpirationChip(days: days, endDate: membership?.endDate),
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right,
                size: 18,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpirationChip extends StatelessWidget {
  const _ExpirationChip({required this.days, this.endDate});

  final int? days;
  final DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    final String label;
    final Color backgroundColor;
    final Color foregroundColor;

    if (days == null) {
      // No active membership
      label = 'No membership';
      backgroundColor = Colors.grey.shade200;
      foregroundColor = Colors.grey.shade700;
    } else if (days! <= 0) {
      label = 'Expires today';
      backgroundColor = Colors.red.shade100;
      foregroundColor = Colors.red.shade800;
    } else if (days == 1) {
      label = 'Expires tomorrow';
      backgroundColor = Colors.red.shade100;
      foregroundColor = Colors.red.shade800;
    } else if (days! <= 7) {
      label = 'Expires in $days days';
      backgroundColor = Colors.orange.shade100;
      foregroundColor = Colors.orange.shade800;
    } else {
      // > 7 days — show date
      final dateStr = DateFormat.MMMd().format(endDate!);
      label = 'Expires $dateStr';
      backgroundColor = Colors.green.shade100;
      foregroundColor = Colors.green.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
