import 'package:gym_system/src/core/models/page_results.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:http/http.dart';

///
/// use for collections
///
abstract class PBCollectionRepository<T> {
  TaskResult<T> get(String id);
  TaskResult<PageResults<T>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
    String? sort,
  });
  TaskResult<List<T>> listAll({
    int batch = 500,
    String? filter,
  });
  TaskResult<void> delete(String id);
  TaskResult<void> softDeleteMulti(List<String> ids);
  TaskResult<T> update(
    T product,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  });

  TaskResult<T> create(
    Map<String, dynamic> payload, {
    List<MultipartFile> files = const [],
  });
}

///
/// use for view collections
///
abstract class PBViewRepository<T> {
  TaskResult<T> get(String id);
  TaskResult<PageResults<T>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
    String? sort,
  });
  TaskResult<List<T>> listAll({
    int batch = 500,
    String? filter,
  });
}

abstract class PBAuthRepository<T> {
  TaskResult<PageResults<T>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
    String? sort,
  });
  TaskResult<T> get(String id);
  TaskResult<void> delete(String id);
  TaskResult<T> update(
    T data,
    Map<String, dynamic> params, {
    List<MultipartFile> files = const [],
  });
  TaskResult<T> create(
    Map<String, dynamic> params, {
    List<MultipartFile> files = const [],
  });
  TaskResult<void> softDeleteMulti(List<String> ids);
  TaskResult<void> requestVerification(String email);
  TaskResult<void> confirmVerification(String token);
}
