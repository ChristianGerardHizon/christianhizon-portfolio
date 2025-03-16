// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth_user.dart';

class AuthUserMapper extends ClassMapperBase<AuthUser> {
  AuthUserMapper._();

  static AuthUserMapper? _instance;
  static AuthUserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthUserMapper._());
      AuthDataMapper.ensureInitialized();
      UserMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthUser';

  static String _$id(AuthUser v) => v.id;
  static const Field<AuthUser, String> _f$id = Field('id', _$id);
  static String _$token(AuthUser v) => v.token;
  static const Field<AuthUser, String> _f$token = Field('token', _$token);
  static User _$record(AuthUser v) => v.record;
  static const Field<AuthUser, User> _f$record = Field('record', _$record);
  static String _$collectionId(AuthUser v) => v.collectionId;
  static const Field<AuthUser, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(AuthUser v) => v.collectionName;
  static const Field<AuthUser, String> _f$collectionName =
      Field('collectionName', _$collectionName);

  @override
  final MappableFields<AuthUser> fields = const {
    #id: _f$id,
    #token: _f$token,
    #record: _f$record,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
  };

  static AuthUser _instantiate(DecodingData data) {
    return AuthUser(
        id: data.dec(_f$id),
        token: data.dec(_f$token),
        record: data.dec(_f$record),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthUser fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthUser>(map);
  }

  static AuthUser fromJson(String json) {
    return ensureInitialized().decodeJson<AuthUser>(json);
  }
}

mixin AuthUserMappable {
  String toJson() {
    return AuthUserMapper.ensureInitialized()
        .encodeJson<AuthUser>(this as AuthUser);
  }

  Map<String, dynamic> toMap() {
    return AuthUserMapper.ensureInitialized()
        .encodeMap<AuthUser>(this as AuthUser);
  }

  AuthUserCopyWith<AuthUser, AuthUser, AuthUser> get copyWith =>
      _AuthUserCopyWithImpl<AuthUser, AuthUser>(
          this as AuthUser, $identity, $identity);
  @override
  String toString() {
    return AuthUserMapper.ensureInitialized().stringifyValue(this as AuthUser);
  }

  @override
  bool operator ==(Object other) {
    return AuthUserMapper.ensureInitialized()
        .equalsValue(this as AuthUser, other);
  }

  @override
  int get hashCode {
    return AuthUserMapper.ensureInitialized().hashValue(this as AuthUser);
  }
}

extension AuthUserValueCopy<$R, $Out> on ObjectCopyWith<$R, AuthUser, $Out> {
  AuthUserCopyWith<$R, AuthUser, $Out> get $asAuthUser =>
      $base.as((v, t, t2) => _AuthUserCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthUserCopyWith<$R, $In extends AuthUser, $Out>
    implements AuthDataCopyWith<$R, $In, $Out> {
  UserCopyWith<$R, User, User> get record;
  @override
  $R call(
      {String? id,
      String? token,
      User? record,
      String? collectionId,
      String? collectionName});
  AuthUserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AuthUserCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthUser, $Out>
    implements AuthUserCopyWith<$R, AuthUser, $Out> {
  _AuthUserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthUser> $mapper =
      AuthUserMapper.ensureInitialized();
  @override
  UserCopyWith<$R, User, User> get record =>
      $value.record.copyWith.$chain((v) => call(record: v));
  @override
  $R call(
          {String? id,
          String? token,
          User? record,
          String? collectionId,
          String? collectionName}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (token != null) #token: token,
        if (record != null) #record: record,
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName
      }));
  @override
  AuthUser $make(CopyWithData data) => AuthUser(
      id: data.get(#id, or: $value.id),
      token: data.get(#token, or: $value.token),
      record: data.get(#record, or: $value.record),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName));

  @override
  AuthUserCopyWith<$R2, AuthUser, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthUserCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
