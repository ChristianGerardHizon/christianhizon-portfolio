import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pb_filter.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/product_category.dart';
import '../dto/product_category_dto.dart';

part 'product_category_repository.g.dart';

/// Repository interface for product category operations.
abstract class ProductCategoryRepository {
  /// Fetches all product categories.
  FutureEither<List<ProductCategory>> fetchAll({String? filter, String? sort});

  /// Fetches categories by parent ID (for hierarchy).
  FutureEither<List<ProductCategory>> fetchByParent(String? parentId);

  /// Fetches a single category by ID.
  FutureEither<ProductCategory> fetchOne(String id);

  /// Creates a new category.
  FutureEither<ProductCategory> create(ProductCategory category);

  /// Updates an existing category.
  FutureEither<ProductCategory> update(ProductCategory category);

  /// Soft deletes a category by ID.
  FutureEither<void> delete(String id);

  /// Invalidates the category list cache.
  void invalidateCache();
}

/// Provides the ProductCategoryRepository instance.
@Riverpod(keepAlive: true)
ProductCategoryRepository productCategoryRepository(Ref ref) {
  return ProductCategoryRepositoryImpl(ref.watch(pocketbaseProvider));
}

/// Implementation of [ProductCategoryRepository] using PocketBase.
class ProductCategoryRepositoryImpl implements ProductCategoryRepository {
  final PocketBase _pb;

  ProductCategoryRepositoryImpl(this._pb);

  RecordService get _collection =>
      _pb.collection(PocketBaseCollections.productCategories);
  String get _expand => 'parent';

  // Cache for category list
  List<ProductCategory>? _cachedCategories;
  DateTime? _cacheTimestamp;

  // Cache TTL (10 minutes - categories change less frequently)
  static const _cacheTtl = Duration(minutes: 10);

  /// Checks if the cache is valid.
  bool _isCacheValid() {
    if (_cachedCategories == null || _cacheTimestamp == null) return false;
    return DateTime.now().difference(_cacheTimestamp!) < _cacheTtl;
  }

  /// Invalidates the cache.
  @override
  void invalidateCache() {
    _cachedCategories = null;
    _cacheTimestamp = null;
  }

  ProductCategory _toEntity(RecordModel record) {
    final dto = ProductCategoryDto.fromRecord(record);
    return dto.toEntity();
  }

  @override
  FutureEither<List<ProductCategory>> fetchAll({
    String? filter,
    String? sort,
  }) async {
    // Return cached data if valid and no filter
    if (_isCacheValid() && filter == null) {
      return Right(_cachedCategories!);
    }

    return TaskEither.tryCatch(
      () async {
        final baseFilter = PBFilters.active.build();
        final filterString =
            filter != null ? '$baseFilter && $filter' : baseFilter;

        final records = await _collection.getFullList(
          expand: _expand,
          filter: filterString,
          sort: sort ?? 'name',
        );

        final categories = records.map(_toEntity).toList();

        // Update cache only if no filter
        if (filter == null) {
          _cachedCategories = categories;
          _cacheTimestamp = DateTime.now();
        }

        return categories;
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<List<ProductCategory>> fetchByParent(String? parentId) async {
    return TaskEither.tryCatch(
      () async {
        final filter = PBFilter().notDeleted();

        if (parentId == null || parentId.isEmpty) {
          // Fetch root categories (no parent)
          filter.equals('parent', '');
        } else {
          filter.relation('parent', parentId);
        }

        final records = await _collection.getFullList(
          expand: _expand,
          filter: filter.build(),
          sort: 'name',
        );

        return records.map(_toEntity).toList();
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<ProductCategory> fetchOne(String id) async {
    return TaskEither.tryCatch(
      () async {
        if (id.isEmpty) {
          throw const DataFailure(
            'Category ID cannot be empty',
            null,
            'invalid_category_id',
          );
        }

        final record = await _collection.getOne(id, expand: _expand);
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<ProductCategory> create(ProductCategory category) async {
    return TaskEither.tryCatch(
      () async {
        final body = <String, dynamic>{
          'name': category.name,
          'parent': category.parentId,
          'isDeleted': false,
        };

        final record = await _collection.create(body: body);
        invalidateCache();
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<ProductCategory> update(ProductCategory category) async {
    return TaskEither.tryCatch(
      () async {
        if (category.id.isEmpty) {
          throw const DataFailure(
            'Category ID cannot be empty',
            null,
            'invalid_category_id',
          );
        }

        final body = <String, dynamic>{
          'name': category.name,
          'parent': category.parentId,
        };

        final record = await _collection.update(category.id, body: body);
        invalidateCache();
        return _toEntity(record);
      },
      Failure.handle,
    ).run();
  }

  @override
  FutureEither<void> delete(String id) async {
    return TaskEither.tryCatch(
      () async {
        if (id.isEmpty) {
          throw const DataFailure(
            'Category ID cannot be empty',
            null,
            'invalid_category_id',
          );
        }

        // Soft delete
        await _collection.update(id, body: {'isDeleted': true});
        invalidateCache();
      },
      Failure.handle,
    ).run();
  }
}
