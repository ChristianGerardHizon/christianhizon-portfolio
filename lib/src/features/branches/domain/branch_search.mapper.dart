// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'branch_search.dart';

class BranchSearchMapper extends ClassMapperBase<BranchSearch> {
  BranchSearchMapper._();

  static BranchSearchMapper? _instance;
  static BranchSearchMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BranchSearchMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BranchSearch';

  static String? _$id(BranchSearch v) => v.id;
  static const Field<BranchSearch, String> _f$id = Field('id', _$id, opt: true);
  static String? _$name(BranchSearch v) => v.name;
  static const Field<BranchSearch, String> _f$name =
      Field('name', _$name, opt: true);

  @override
  final MappableFields<BranchSearch> fields = const {
    #id: _f$id,
    #name: _f$name,
  };

  static BranchSearch _instantiate(DecodingData data) {
    return BranchSearch(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static BranchSearch fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BranchSearch>(map);
  }

  static BranchSearch fromJson(String json) {
    return ensureInitialized().decodeJson<BranchSearch>(json);
  }
}

mixin BranchSearchMappable {
  String toJson() {
    return BranchSearchMapper.ensureInitialized()
        .encodeJson<BranchSearch>(this as BranchSearch);
  }

  Map<String, dynamic> toMap() {
    return BranchSearchMapper.ensureInitialized()
        .encodeMap<BranchSearch>(this as BranchSearch);
  }

  BranchSearchCopyWith<BranchSearch, BranchSearch, BranchSearch> get copyWith =>
      _BranchSearchCopyWithImpl<BranchSearch, BranchSearch>(
          this as BranchSearch, $identity, $identity);
  @override
  String toString() {
    return BranchSearchMapper.ensureInitialized()
        .stringifyValue(this as BranchSearch);
  }

  @override
  bool operator ==(Object other) {
    return BranchSearchMapper.ensureInitialized()
        .equalsValue(this as BranchSearch, other);
  }

  @override
  int get hashCode {
    return BranchSearchMapper.ensureInitialized()
        .hashValue(this as BranchSearch);
  }
}

extension BranchSearchValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BranchSearch, $Out> {
  BranchSearchCopyWith<$R, BranchSearch, $Out> get $asBranchSearch =>
      $base.as((v, t, t2) => _BranchSearchCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BranchSearchCopyWith<$R, $In extends BranchSearch, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name});
  BranchSearchCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BranchSearchCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BranchSearch, $Out>
    implements BranchSearchCopyWith<$R, BranchSearch, $Out> {
  _BranchSearchCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BranchSearch> $mapper =
      BranchSearchMapper.ensureInitialized();
  @override
  $R call({Object? id = $none, Object? name = $none}) =>
      $apply(FieldCopyWithData(
          {if (id != $none) #id: id, if (name != $none) #name: name}));
  @override
  BranchSearch $make(CopyWithData data) => BranchSearch(
      id: data.get(#id, or: $value.id), name: data.get(#name, or: $value.name));

  @override
  BranchSearchCopyWith<$R2, BranchSearch, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BranchSearchCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
