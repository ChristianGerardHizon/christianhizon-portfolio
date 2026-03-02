import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/tech_stack_repository.dart';
import '../../domain/tech_stack_item.dart';

part 'tech_stack_controller.g.dart';

/// Controller for fetching tech stack items.
@riverpod
class TechStackController extends _$TechStackController {
  @override
  Future<List<TechStackItem>> build() async {
    final repo = ref.watch(techStackRepositoryProvider);
    final result = await repo.getTechStack();
    return result.fold(
      (failure) => [],
      (items) => items,
    );
  }
}
