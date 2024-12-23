// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth_user.dart';

class AuthUserTypeMapper extends EnumMapper<AuthUserType> {
  AuthUserTypeMapper._();

  static AuthUserTypeMapper? _instance;
  static AuthUserTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthUserTypeMapper._());
    }
    return _instance!;
  }

  static AuthUserType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AuthUserType decode(dynamic value) {
    switch (value) {
      case 'admins':
        return AuthUserType.admins;
      case 'users':
        return AuthUserType.users;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AuthUserType self) {
    switch (self) {
      case AuthUserType.admins:
        return 'admins';
      case AuthUserType.users:
        return 'users';
    }
  }
}

extension AuthUserTypeMapperExtension on AuthUserType {
  String toValue() {
    AuthUserTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AuthUserType>(this) as String;
  }
}

class AuthUserMapper extends ClassMapperBase<AuthUser> {
  AuthUserMapper._();

  static AuthUserMapper? _instance;
  static AuthUserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthUserMapper._());
      AuthUserTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthUser';

  static String _$id(AuthUser v) => v.id;
  static const Field<AuthUser, String> _f$id = Field('id', _$id);
  static AuthUserType _$type(AuthUser v) => v.type;
  static const Field<AuthUser, AuthUserType> _f$type = Field('type', _$type);
  static String _$collectionId(AuthUser v) => v.collectionId;
  static const Field<AuthUser, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(AuthUser v) => v.collectionName;
  static const Field<AuthUser, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static String _$token(AuthUser v) => v.token;
  static const Field<AuthUser, String> _f$token = Field('token', _$token);

  @override
  final MappableFields<AuthUser> fields = const {
    #id: _f$id,
    #type: _f$type,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #token: _f$token,
  };

  static AuthUser _instantiate(DecodingData data) {
    return AuthUser(
        id: data.dec(_f$id),
        type: data.dec(_f$type),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        token: data.dec(_f$token));
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
      _AuthUserCopyWithImpl(this as AuthUser, $identity, $identity);
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
      $base.as((v, t, t2) => _AuthUserCopyWithImpl(v, t, t2));
}

abstract class AuthUserCopyWith<$R, $In extends AuthUser, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      AuthUserType? type,
      String? collectionId,
      String? collectionName,
      String? token});
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
  $R call(
          {String? id,
          AuthUserType? type,
          String? collectionId,
          String? collectionName,
          String? token}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (type != null) #type: type,
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName,
        if (token != null) #token: token
      }));
  @override
  AuthUser $make(CopyWithData data) => AuthUser(
      id: data.get(#id, or: $value.id),
      type: data.get(#type, or: $value.type),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      token: data.get(#token, or: $value.token));

  @override
  AuthUserCopyWith<$R2, AuthUser, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthUserCopyWithImpl($value, $cast, t);
}
