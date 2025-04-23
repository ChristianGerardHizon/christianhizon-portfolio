// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_search.dart';

class UserSearchMapper extends ClassMapperBase<UserSearch> {
  UserSearchMapper._();

  static UserSearchMapper? _instance;
  static UserSearchMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserSearchMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserSearch';

  static String? _$id(UserSearch v) => v.id;
  static const Field<UserSearch, String> _f$id = Field('id', _$id, opt: true);
  static String? _$name(UserSearch v) => v.name;
  static const Field<UserSearch, String> _f$name =
      Field('name', _$name, opt: true);

  @override
  final MappableFields<UserSearch> fields = const {
    #id: _f$id,
    #name: _f$name,
  };

  static UserSearch _instantiate(DecodingData data) {
    return UserSearch(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static UserSearch fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserSearch>(map);
  }

  static UserSearch fromJson(String json) {
    return ensureInitialized().decodeJson<UserSearch>(json);
  }
}

mixin UserSearchMappable {
  String toJson() {
    return UserSearchMapper.ensureInitialized()
        .encodeJson<UserSearch>(this as UserSearch);
  }

  Map<String, dynamic> toMap() {
    return UserSearchMapper.ensureInitialized()
        .encodeMap<UserSearch>(this as UserSearch);
  }

  UserSearchCopyWith<UserSearch, UserSearch, UserSearch> get copyWith =>
      _UserSearchCopyWithImpl<UserSearch, UserSearch>(
          this as UserSearch, $identity, $identity);
  @override
  String toString() {
    return UserSearchMapper.ensureInitialized()
        .stringifyValue(this as UserSearch);
  }

  @override
  bool operator ==(Object other) {
    return UserSearchMapper.ensureInitialized()
        .equalsValue(this as UserSearch, other);
  }

  @override
  int get hashCode {
    return UserSearchMapper.ensureInitialized().hashValue(this as UserSearch);
  }
}

extension UserSearchValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserSearch, $Out> {
  UserSearchCopyWith<$R, UserSearch, $Out> get $asUserSearch =>
      $base.as((v, t, t2) => _UserSearchCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserSearchCopyWith<$R, $In extends UserSearch, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name});
  UserSearchCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserSearchCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserSearch, $Out>
    implements UserSearchCopyWith<$R, UserSearch, $Out> {
  _UserSearchCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserSearch> $mapper =
      UserSearchMapper.ensureInitialized();
  @override
  $R call({Object? id = $none, Object? name = $none}) =>
      $apply(FieldCopyWithData(
          {if (id != $none) #id: id, if (name != $none) #name: name}));
  @override
  UserSearch $make(CopyWithData data) => UserSearch(
      id: data.get(#id, or: $value.id), name: data.get(#name, or: $value.name));

  @override
  UserSearchCopyWith<$R2, UserSearch, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserSearchCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
