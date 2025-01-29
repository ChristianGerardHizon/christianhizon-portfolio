import 'package:gym_system/src/features/staff/data/staff_repository.dart';
import 'package:gym_system/src/features/staff/domain/staff.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'staff_controller.g.dart';

@riverpod
class StaffController extends _$StaffController {
  @override
  Future<Staff> build(String id) async {
    final repo = ref.read(staffRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
