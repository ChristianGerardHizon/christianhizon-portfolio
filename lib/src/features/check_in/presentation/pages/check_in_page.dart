import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/routing/routes/members.routes.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../../members/data/repositories/member_repository.dart';
import '../../../members/domain/member.dart';
import '../../../memberships/data/repositories/member_membership_repository.dart';
import '../../../memberships/domain/member_membership.dart';
import '../controllers/check_in_controller.dart';
import '../widgets/check_in_success_dialog.dart';
import '../widgets/recent_check_ins_list.dart';

/// Main check-in page.
///
/// Provides:
/// - Search bar for member lookup (by name or mobile)
/// - Member card showing name and active membership status
/// - Check-in button
/// - Today's recent check-ins list
class CheckInPage extends HookConsumerWidget {
  const CheckInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final searchController = useTextEditingController();
    final searchResults = useState<List<Member>>([]);
    final selectedMember = useState<Member?>(null);
    final activeMembership = useState<MemberMembership?>(null);
    final isSearching = useState(false);
    final isCheckingIn = useState(false);

    Future<void> searchMembers(String query) async {
      if (query.trim().isEmpty) {
        searchResults.value = [];
        return;
      }

      isSearching.value = true;
      final repo = ref.read(memberRepositoryProvider);
      final result = await repo.search(query);
      isSearching.value = false;

      result.fold(
        (failure) => searchResults.value = [],
        (members) => searchResults.value = members,
      );
    }

    Future<void> selectMember(Member member) async {
      selectedMember.value = member;
      searchResults.value = [];
      searchController.text = member.name;

      // Fetch active membership
      final mmRepo = ref.read(memberMembershipRepositoryProvider);
      final result = await mmRepo.fetchActive(member.id);
      result.fold(
        (_) => activeMembership.value = null,
        (memberships) {
          activeMembership.value =
              memberships.isNotEmpty ? memberships.first : null;
        },
      );
    }

    Future<void> handleCheckIn() async {
      final member = selectedMember.value;
      if (member == null) return;

      isCheckingIn.value = true;

      final checkIn = await ref
          .read(checkInControllerProvider.notifier)
          .manualCheckIn(
            memberId: member.id,
            memberMembershipId: activeMembership.value?.id,
          );

      isCheckingIn.value = false;

      if (checkIn != null && context.mounted) {
        // Reset search
        selectedMember.value = null;
        activeMembership.value = null;
        searchController.clear();

        await showCheckInSuccessDialog(
          context,
          memberName: member.name,
          hasActiveMembership: activeMembership.value != null,
        );
      } else if (context.mounted) {
        showErrorSnackBar(context, message: 'Failed to check in');
      }
    }

    void clearSelection() {
      selectedMember.value = null;
      activeMembership.value = null;
      searchController.clear();
      searchResults.value = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Check-In'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(checkInControllerProvider.notifier).refresh(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search + member card section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Search bar
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search member by name or mobile...',
                    border: const OutlineInputBorder(),
                    isDense: true,
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: clearSelection,
                          )
                        : null,
                  ),
                  onChanged: (query) {
                    if (selectedMember.value != null) {
                      selectedMember.value = null;
                      activeMembership.value = null;
                    }
                    searchMembers(query);
                  },
                ),

                // Search results dropdown
                if (searchResults.value.isNotEmpty &&
                    selectedMember.value == null)
                  Card(
                    margin: const EdgeInsets.only(top: 4),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchResults.value.length,
                        itemBuilder: (context, index) {
                          final member = searchResults.value[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  theme.colorScheme.primaryContainer,
                              child: Icon(
                                Icons.person,
                                color:
                                    theme.colorScheme.onPrimaryContainer,
                                size: 20,
                              ),
                            ),
                            title: Text(member.name),
                            subtitle: member.mobileNumber != null &&
                                    member.mobileNumber!.isNotEmpty
                                ? Text(member.mobileNumber!)
                                : null,
                            dense: true,
                            onTap: () => selectMember(member),
                          );
                        },
                      ),
                    ),
                  ),

                if (isSearching.value)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ),

                // Selected member card
                if (selectedMember.value != null) ...[
                  const SizedBox(height: 16),
                  _SelectedMemberCard(
                    member: selectedMember.value!,
                    activeMembership: activeMembership.value,
                    onViewProfile: () => MemberDetailRoute(
                      id: selectedMember.value!.id,
                    ).go(context),
                  ),
                  const SizedBox(height: 16),

                  // Check-in button
                  SizedBox(
                    height: 56,
                    child: FilledButton.icon(
                      onPressed:
                          isCheckingIn.value ? null : handleCheckIn,
                      icon: isCheckingIn.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.how_to_reg, size: 24),
                      label: Text(
                        isCheckingIn.value
                            ? 'Checking in...'
                            : 'Check In',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          const Divider(height: 1),

          // Recent check-ins header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  Icons.history,
                  size: 20,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  "Today's Check-ins",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Recent check-ins list
          const Expanded(
            child: RecentCheckInsList(),
          ),
        ],
      ),
    );
  }
}

/// Card showing selected member info and membership status.
class _SelectedMemberCard extends StatelessWidget {
  const _SelectedMemberCard({
    required this.member,
    this.activeMembership,
    this.onViewProfile,
  });

  final Member member;
  final MemberMembership? activeMembership;
  final VoidCallback? onViewProfile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasActiveMembership = activeMembership != null;
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Icon(
                    Icons.person,
                    color: theme.colorScheme.onPrimaryContainer,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (member.mobileNumber != null &&
                          member.mobileNumber!.isNotEmpty)
                        Text(
                          member.mobileNumber!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.open_in_new, size: 20),
                  onPressed: onViewProfile,
                  tooltip: 'View profile',
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Membership status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: hasActiveMembership
                    ? Colors.green.withValues(alpha: 0.1)
                    : Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    hasActiveMembership
                        ? Icons.verified
                        : Icons.warning_amber_rounded,
                    color: hasActiveMembership ? Colors.green : Colors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasActiveMembership
                              ? activeMembership!.membershipName ??
                                  'Active Membership'
                              : 'No Active Membership',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: hasActiveMembership
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                        if (hasActiveMembership)
                          Text(
                            'Expires ${dateFormat.format(activeMembership!.endDate)} (${activeMembership!.daysRemaining} days left)',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                      ],
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
}
