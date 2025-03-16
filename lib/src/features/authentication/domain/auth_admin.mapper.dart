// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth_admin.dart';

class AuthAdminMapper extends ClassMapperBase<AuthAdmin> {
  AuthAdminMapper._();

  static AuthAdminMapper? _instance;
  static AuthAdminMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthAdminMapper._());
      AuthDataMapper.ensureInitialized();
      AdminMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthAdmin';

  static String _$id(AuthAdmin v) => v.id;
  static const Field<AuthAdmin, String> _f$id = Field('id', _$id);
  static String _$token(AuthAdmin v) => v.token;
  static const Field<AuthAdmin, String> _f$token = Field('token', _$token);
  static Admin _$record(AuthAdmin v) => v.record;
  static const Field<AuthAdmin, Admin> _f$record = Field('record', _$record);
  static String _$collectionId(AuthAdmin v) => v.collectionId;
  static const Field<AuthAdmin, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(AuthAdmin v) => v.collectionName;
  static const Field<AuthAdmin, String> _f$collectionName =
      Field('collectionName', _$collectionName);

  @override
  final MappableFields<AuthAdmin> fields = const {
    #id: _f$id,
    #token: _f$token,
    #record: _f$record,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
  };

  static AuthAdmin _instantiate(DecodingData data) {
    return AuthAdmin(
        id: data.dec(_f$id),
        token: data.dec(_f$token),
        record: data.dec(_f$record),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthAdmin fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthAdmin>(map);
  }

  static AuthAdmin fromJson(String json) {
    return ensureInitialized().decodeJson<AuthAdmin>(json);
  }
}

mixin AuthAdminMappable {
  String toJson() {
    return AuthAdminMapper.ensureInitialized()
        .encodeJson<AuthAdmin>(this as AuthAdmin);
  }

  Map<String, dynamic> toMap() {
    return AuthAdminMapper.ensureInitialized()
        .encodeMap<AuthAdmin>(this as AuthAdmin);
  }

  AuthAdminCopyWith<AuthAdmin, AuthAdmin, AuthAdmin> get copyWith =>
      _AuthAdminCopyWithImpl<AuthAdmin, AuthAdmin>(
          this as AuthAdmin, $identity, $identity);
  @override
  String toString() {
    return AuthAdminMapper.ensureInitialized()
        .stringifyValue(this as AuthAdmin);
  }

  @override
  bool operator ==(Object other) {
    return AuthAdminMapper.ensureInitialized()
        .equalsValue(this as AuthAdmin, other);
  }

  @override
  int get hashCode {
    return AuthAdminMapper.ensureInitialized().hashValue(this as AuthAdmin);
  }
}

extension AuthAdminValueCopy<$R, $Out> on ObjectCopyWith<$R, AuthAdmin, $Out> {
  AuthAdminCopyWith<$R, AuthAdmin, $Out> get $asAuthAdmin =>
      $base.as((v, t, t2) => _AuthAdminCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthAdminCopyWith<$R, $In extends AuthAdmin, $Out>
    implements AuthDataCopyWith<$R, $In, $Out> {
  AdminCopyWith<$R, Admin, Admin> get record;
  @override
  $R call(
      {String? id,
      String? token,
      Admin? record,
      String? collectionId,
      String? collectionName});
  AuthAdminCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AuthAdminCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthAdmin, $Out>
    implements AuthAdminCopyWith<$R, AuthAdmin, $Out> {
  _AuthAdminCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthAdmin> $mapper =
      AuthAdminMapper.ensureInitialized();
  @override
  AdminCopyWith<$R, Admin, Admin> get record =>
      $value.record.copyWith.$chain((v) => call(record: v));
  @override
  $R call(
          {String? id,
          String? token,
          Admin? record,
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
  AuthAdmin $make(CopyWithData data) => AuthAdmin(
      id: data.get(#id, or: $value.id),
      token: data.get(#token, or: $value.token),
      record: data.get(#record, or: $value.record),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName));

  @override
  AuthAdminCopyWith<$R2, AuthAdmin, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthAdminCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
