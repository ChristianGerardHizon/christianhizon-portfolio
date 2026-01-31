import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../../settings/presentation/controllers/current_branch_controller.dart';

part 'top_treatment_types_provider.g.dart';

/// Fetches the top 5 most-used treatment type IDs from [vw_top_treatment_types].
///
/// Results are branch-filtered and sorted by usage count descending.
/// Uses keepAlive so the data is fetched once and reused across dialog opens.
@Riverpod(keepAlive: true)
Future<List<String>> topTreatmentTypeIds(Ref ref) async {
  final branchId = ref.watch(currentBranchIdProvider);
  final pb = ref.read(pocketbaseProvider);

  final records = await pb
      .collection(PocketBaseCollections.vwTopTreatmentTypes)
      .getList(
        page: 1,
        perPage: 5,
        sort: '-usage_count',
        filter: branchId != null ? 'branch = "$branchId"' : null,
      );

  return records.items.map((r) => r.id).toList();
}
