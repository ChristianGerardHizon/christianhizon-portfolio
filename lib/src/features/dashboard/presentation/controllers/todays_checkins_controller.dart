import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../../settings/presentation/controllers/current_branch_controller.dart';

part 'todays_checkins_controller.g.dart';

/// Count of check-ins today for the current branch.
@riverpod
Future<int> todaysCheckInsCount(Ref ref) async {
  final branchId = ref.watch(currentBranchIdProvider);
  final pb = ref.read(pocketbaseProvider);
  final now = DateTime.now();
  final startOfToday = DateTime(now.year, now.month, now.day);

  String filter = 'checkInTime >= "${startOfToday.toUtc().toIso8601String()}"';
  if (branchId != null) {
    filter += ' && branch = "$branchId"';
  }

  final result = await pb
      .collection(PocketBaseCollections.checkIns)
      .getList(
        page: 1,
        perPage: 1,
        filter: filter,
      );

  return result.totalItems;
}
