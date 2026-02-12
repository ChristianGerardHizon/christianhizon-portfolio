import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../memberships/data/dto/member_membership_dto.dart';
import '../../../memberships/domain/member_membership.dart';
import '../../../settings/presentation/controllers/current_branch_controller.dart';

part 'expiring_memberships_controller.g.dart';

/// Memberships expiring within the next 7 days.
///
/// Queries memberMemberships where status = 'active'
/// and endDate is between now and now + 7 days.
@riverpod
Future<List<MemberMembership>> expiringMemberships(Ref ref) async {
  final branchId = ref.watch(currentBranchIdProvider);
  final pb = ref.read(pocketbaseProvider);
  final now = DateTime.now();
  final sevenDaysLater = now.add(const Duration(days: 7));

  final nowUtc = now.toUtcIso8601();
  final laterUtc = sevenDaysLater.toUtcIso8601();

  String filter =
      'status = "active" && endDate >= "$nowUtc" && endDate <= "$laterUtc"';
  if (branchId != null) {
    filter += ' && branch = "$branchId"';
  }

  final result = await pb
      .collection(PocketBaseCollections.memberMemberships)
      .getList(
        page: 1,
        perPage: 10,
        filter: filter,
        sort: 'endDate',
        expand: 'member,membership',
      );

  return result.items
      .map((RecordModel r) => MemberMembershipDto.fromRecord(r).toEntity())
      .toList();
}
