// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'page_results.dart';

class PageResultsMapper extends ClassMapperBase<PageResults> {
  PageResultsMapper._();

  static PageResultsMapper? _instance;
  static PageResultsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PageResultsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PageResults';
  @override
  Function get typeFactory => <T>(f) => f<PageResults<T>>();

  static int _$page(PageResults v) => v.page;
  static const Field<PageResults, int> _f$page = Field('page', _$page);
  static int _$perPage(PageResults v) => v.perPage;
  static const Field<PageResults, int> _f$perPage = Field('perPage', _$perPage);
  static int _$totalItems(PageResults v) => v.totalItems;
  static const Field<PageResults, int> _f$totalItems =
      Field('totalItems', _$totalItems);
  static int _$totalPages(PageResults v) => v.totalPages;
  static const Field<PageResults, int> _f$totalPages =
      Field('totalPages', _$totalPages);
  static List<dynamic> _$items(PageResults v) => v.items;
  static dynamic _arg$items<T>(f) => f<List<T>>();
  static const Field<PageResults, List<dynamic>> _f$items =
      Field('items', _$items, arg: _arg$items);

  @override
  final MappableFields<PageResults> fields = const {
    #page: _f$page,
    #perPage: _f$perPage,
    #totalItems: _f$totalItems,
    #totalPages: _f$totalPages,
    #items: _f$items,
  };

  static PageResults<T> _instantiate<T>(DecodingData data) {
    return PageResults(
        page: data.dec(_f$page),
        perPage: data.dec(_f$perPage),
        totalItems: data.dec(_f$totalItems),
        totalPages: data.dec(_f$totalPages),
        items: data.dec(_f$items));
  }

  @override
  final Function instantiate = _instantiate;

  static PageResults<T> fromMap<T>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PageResults<T>>(map);
  }

  static PageResults<T> fromJson<T>(String json) {
    return ensureInitialized().decodeJson<PageResults<T>>(json);
  }
}

mixin PageResultsMappable<T> {
  String toJson() {
    return PageResultsMapper.ensureInitialized()
        .encodeJson<PageResults<T>>(this as PageResults<T>);
  }

  Map<String, dynamic> toMap() {
    return PageResultsMapper.ensureInitialized()
        .encodeMap<PageResults<T>>(this as PageResults<T>);
  }

  PageResultsCopyWith<PageResults<T>, PageResults<T>, PageResults<T>, T>
      get copyWith => _PageResultsCopyWithImpl(
          this as PageResults<T>, $identity, $identity);
  @override
  String toString() {
    return PageResultsMapper.ensureInitialized()
        .stringifyValue(this as PageResults<T>);
  }

  @override
  bool operator ==(Object other) {
    return PageResultsMapper.ensureInitialized()
        .equalsValue(this as PageResults<T>, other);
  }

  @override
  int get hashCode {
    return PageResultsMapper.ensureInitialized()
        .hashValue(this as PageResults<T>);
  }
}

extension PageResultsValueCopy<$R, $Out, T>
    on ObjectCopyWith<$R, PageResults<T>, $Out> {
  PageResultsCopyWith<$R, PageResults<T>, $Out, T> get $asPageResults =>
      $base.as((v, t, t2) => _PageResultsCopyWithImpl(v, t, t2));
}

abstract class PageResultsCopyWith<$R, $In extends PageResults<T>, $Out, T>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, T, ObjectCopyWith<$R, T, T>> get items;
  $R call(
      {int? page,
      int? perPage,
      int? totalItems,
      int? totalPages,
      List<T>? items});
  PageResultsCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PageResultsCopyWithImpl<$R, $Out, T>
    extends ClassCopyWithBase<$R, PageResults<T>, $Out>
    implements PageResultsCopyWith<$R, PageResults<T>, $Out, T> {
  _PageResultsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PageResults> $mapper =
      PageResultsMapper.ensureInitialized();
  @override
  ListCopyWith<$R, T, ObjectCopyWith<$R, T, T>> get items => ListCopyWith(
      $value.items,
      (v, t) => ObjectCopyWith(v, $identity, t),
      (v) => call(items: v));
  @override
  $R call(
          {int? page,
          int? perPage,
          int? totalItems,
          int? totalPages,
          List<T>? items}) =>
      $apply(FieldCopyWithData({
        if (page != null) #page: page,
        if (perPage != null) #perPage: perPage,
        if (totalItems != null) #totalItems: totalItems,
        if (totalPages != null) #totalPages: totalPages,
        if (items != null) #items: items
      }));
  @override
  PageResults<T> $make(CopyWithData data) => PageResults(
      page: data.get(#page, or: $value.page),
      perPage: data.get(#perPage, or: $value.perPage),
      totalItems: data.get(#totalItems, or: $value.totalItems),
      totalPages: data.get(#totalPages, or: $value.totalPages),
      items: data.get(#items, or: $value.items));

  @override
  PageResultsCopyWith<$R2, PageResults<T>, $Out2, T> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PageResultsCopyWithImpl($value, $cast, t);
}
