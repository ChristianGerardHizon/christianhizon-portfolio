import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/tech_stack_item.dart';

part 'tech_stack_repository.g.dart';

@Riverpod(keepAlive: true)
TechStackRepository techStackRepository(Ref ref) {
  return TechStackRepository(pb: ref.watch(pocketbaseProvider));
}

class TechStackRepository {
  final PocketBase pb;

  TechStackRepository({required this.pb});

  RecordService get _collection =>
      pb.collection(PocketBaseCollections.techStack);

  TechStackItem _fromRecord(RecordModel record) {
    final data = record.toJson();
    return TechStackItem(
      id: record.id,
      name: data['name']?.toString() ?? '',
      category: data['category']?.toString() ?? '',
      description: data['description']?.toString() ?? '',
      iconName: data['iconName']?.toString() ?? '',
      proficiencyLevel: (data['proficiencyLevel'] as num?)?.toInt() ?? 0,
      yearsOfExperience: (data['yearsOfExperience'] as num?)?.toInt() ?? 0,
      url: data['url']?.toString() ?? '',
      sortOrder: (data['sortOrder'] as num?)?.toInt() ?? 0,
      collectionId: record.collectionId,
    );
  }

  /// Get all tech stack items, sorted by category then sortOrder.
  FutureEither<List<TechStackItem>> getTechStack() async {
    return TaskEither.tryCatch(
      () async {
        final result = await _collection.getFullList(
          sort: 'category,sortOrder',
        );
        return result.map(_fromRecord).toList();
      },
      Failure.handle,
    ).run();
  }
}
