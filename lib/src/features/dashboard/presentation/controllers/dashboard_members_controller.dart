import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/packages/pocketbase/pb_filter.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../../members/domain/member.dart';
import '../../../members/presentation/controllers/members_controller.dart';
import '../../../memberships/data/dto/member_membership_dto.dart';
import '../../../memberships/domain/member_membership.dart';
import '../../../settings/presentation/controllers/current_branch_controller.dart';

part 'dashboard_members_controller.g.dart';

/// A member combined with their latest active membership (if any).
class DashboardMember {
  const DashboardMember({
    required this.member,
    this.activeMembership,
  });

  final Member member;
  final MemberMembership? activeMembership;

  /// Days until membership expires, or null if no active membership.
  int? get daysUntilExpiry => activeMembership?.daysRemaining;
}

/// All members with their latest active membership attached.
///
/// Sorted with near-expiration members first, then active, then no membership.
@riverpod
Future<List<DashboardMember>> dashboardMembers(Ref ref) async {
  final branchId = ref.watch(currentBranchIdProvider);
  final pb = ref.read(pocketbaseProvider);

  // 1. Get all members from the existing keepAlive provider
  final membersAsync = ref.watch(membersControllerProvider);
  final members = membersAsync.value ?? [];

  // 2. Fetch all active memberMemberships
  final filter = PBFilter()
      .equals('status', 'active')
      .greaterOrEqual('endDate', DateTime.now());
  if (branchId != null) {
    filter.relation('branch', branchId);
  }

  final result = await pb
      .collection(PocketBaseCollections.memberMemberships)
      .getFullList(
        filter: filter.buildOrEmpty(),
        sort: '-endDate',
        expand: 'member,membership',
      );

  final allMemberships = result
      .map((RecordModel r) => MemberMembershipDto.fromRecord(r).toEntity())
      .toList();

  // 3. Group by memberId, pick latest endDate per member
  final latestByMember = <String, MemberMembership>{};
  for (final mm in allMemberships) {
    final existing = latestByMember[mm.memberId];
    if (existing == null || mm.endDate.isAfter(existing.endDate)) {
      latestByMember[mm.memberId] = mm;
    }
  }

  // 4. Combine: attach membership to each member
  final dashboardMembers = members.map((member) {
    return DashboardMember(
      member: member,
      activeMembership: latestByMember[member.id],
    );
  }).toList();

  // 5. Sort: expiring soon first, then active, then no membership last
  dashboardMembers.sort((a, b) {
    final aDays = a.daysUntilExpiry;
    final bDays = b.daysUntilExpiry;

    // Members with no membership go last
    if (aDays == null && bDays == null) return 0;
    if (aDays == null) return 1;
    if (bDays == null) return -1;

    // Sort by days remaining ascending (most urgent first)
    return aDays.compareTo(bDays);
  });

  return dashboardMembers;
}
