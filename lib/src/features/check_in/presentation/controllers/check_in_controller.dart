import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../settings/presentation/controllers/current_branch_controller.dart';
import '../../data/repositories/check_in_repository.dart';
import '../../domain/check_in.dart';

part 'check_in_controller.g.dart';

/// Controller for performing check-ins and managing today's check-in list.
@Riverpod(keepAlive: true)
class CheckInController extends _$CheckInController {
  CheckInRepository get _repository => ref.read(checkInRepositoryProvider);

  @override
  Future<List<CheckIn>> build() async {
    final branchId = ref.watch(currentBranchIdProvider);
    if (branchId == null) return [];

    final result = await _repository.fetchTodaysCheckIns(branchId);

    return result.fold(
      (failure) => throw failure,
      (checkIns) => checkIns,
    );
  }

  /// Refreshes today's check-in list.
  Future<void> refresh() async {
    _repository.invalidateCache();
    state = const AsyncLoading();

    final branchId = ref.read(currentBranchIdProvider);
    if (branchId == null) {
      state = const AsyncData([]);
      return;
    }

    final result = await _repository.fetchTodaysCheckIns(branchId);

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (checkIns) => AsyncData(checkIns),
    );
  }

  /// Records a manual check-in for a member.
  Future<CheckIn?> manualCheckIn({
    required String memberId,
    String? memberMembershipId,
    String? checkedInBy,
    String? notes,
  }) async {
    final branchId = ref.read(currentBranchIdProvider);
    if (branchId == null) return null;

    final result = await _repository.checkIn(
      memberId: memberId,
      branchId: branchId,
      method: CheckInMethod.manual,
      checkedInBy: checkedInBy,
      memberMembershipId: memberMembershipId,
      notes: notes,
    );

    return result.fold(
      (failure) => null,
      (checkIn) {
        refresh();
        return checkIn;
      },
    );
  }
}
