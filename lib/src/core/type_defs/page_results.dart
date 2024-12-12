import 'package:dart_mappable/dart_mappable.dart';

part 'page_results.mapper.dart';

/* 
   Sample Page data

  {
    "page": 1,
    "perPage": 30,
    "totalItems": 1,
    "totalPages": 1,
    "items" : []
  }

 */

@MappableClass()
class PageResults<T> with PageResultsMappable {
  final int page;
  final int perPage;
  final int totalItems;
  final int totalPages;
  final List<T> items;

  PageResults({
    required this.page,
    required this.perPage,
    required this.totalItems,
    required this.totalPages,
    required this.items,
  });

  factory PageResults.empty() {
    return PageResults(
      page: 0,
      perPage: 0,
      totalItems: 0,
      totalPages: 0,
      items: [],
    );
  }

  static const fromMap = PageResultsMapper.fromMap;
  static const fromJson = PageResultsMapper.fromJson;
}
