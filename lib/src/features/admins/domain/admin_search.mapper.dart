// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'admin_search.dart';

class AdminSearchMapper extends ClassMapperBase<AdminSearch> {
  AdminSearchMapper._();

  static AdminSearchMapper? _instance;
  static AdminSearchMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AdminSearchMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AdminSearch';

  static String? _$id(AdminSearch v) => v.id;
  static const Field<AdminSearch, String> _f$id = Field('id', _$id, opt: true);
  static String? _$name(AdminSearch v) => v.name;
  static const Field<AdminSearch, String> _f$name =
      Field('name', _$name, opt: true);

  @override
  final MappableFields<AdminSearch> fields = const {
    #id: _f$id,
    #name: _f$name,
  };

  static AdminSearch _instantiate(DecodingData data) {
    return AdminSearch(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static AdminSearch fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AdminSearch>(map);
  }

  static AdminSearch fromJson(String json) {
    return ensureInitialized().decodeJson<AdminSearch>(json);
  }
}

mixin AdminSearchMappable {
  String toJson() {
    return AdminSearchMapper.ensureInitialized()
        .encodeJson<AdminSearch>(this as AdminSearch);
  }

  Map<String, dynamic> toMap() {
    return AdminSearchMapper.ensureInitialized()
        .encodeMap<AdminSearch>(this as AdminSearch);
  }

  AdminSearchCopyWith<AdminSearch, AdminSearch, AdminSearch> get copyWith =>
      _AdminSearchCopyWithImpl<AdminSearch, AdminSearch>(
          this as AdminSearch, $identity, $identity);
  @override
  String toString() {
    return AdminSearchMapper.ensureInitialized()
        .stringifyValue(this as AdminSearch);
  }

  @override
  bool operator ==(Object other) {
    return AdminSearchMapper.ensureInitialized()
        .equalsValue(this as AdminSearch, other);
  }

  @override
  int get hashCode {
    return AdminSearchMapper.ensureInitialized().hashValue(this as AdminSearch);
  }
}

extension AdminSearchValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AdminSearch, $Out> {
  AdminSearchCopyWith<$R, AdminSearch, $Out> get $asAdminSearch =>
      $base.as((v, t, t2) => _AdminSearchCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AdminSearchCopyWith<$R, $In extends AdminSearch, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name});
  AdminSearchCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AdminSearchCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AdminSearch, $Out>
    implements AdminSearchCopyWith<$R, AdminSearch, $Out> {
  _AdminSearchCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AdminSearch> $mapper =
      AdminSearchMapper.ensureInitialized();
  @override
  $R call({Object? id = $none, Object? name = $none}) =>
      $apply(FieldCopyWithData(
          {if (id != $none) #id: id, if (name != $none) #name: name}));
  @override
  AdminSearch $make(CopyWithData data) => AdminSearch(
      id: data.get(#id, or: $value.id), name: data.get(#name, or: $value.name));

  @override
  AdminSearchCopyWith<$R2, AdminSearch, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AdminSearchCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
