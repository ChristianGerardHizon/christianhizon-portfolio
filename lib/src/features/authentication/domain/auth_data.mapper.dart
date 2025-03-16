// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth_data.dart';

class AuthDataTypeMapper extends EnumMapper<AuthDataType> {
  AuthDataTypeMapper._();

  static AuthDataTypeMapper? _instance;
  static AuthDataTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthDataTypeMapper._());
    }
    return _instance!;
  }

  static AuthDataType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AuthDataType decode(dynamic value) {
    switch (value) {
      case r'admins':
        return AuthDataType.admins;
      case r'users':
        return AuthDataType.users;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AuthDataType self) {
    switch (self) {
      case AuthDataType.admins:
        return r'admins';
      case AuthDataType.users:
        return r'users';
    }
  }
}

extension AuthDataTypeMapperExtension on AuthDataType {
  String toValue() {
    AuthDataTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AuthDataType>(this) as String;
  }
}

class AuthDataMapper extends ClassMapperBase<AuthData> {
  AuthDataMapper._();

  static AuthDataMapper? _instance;
  static AuthDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AuthData';

  static String _$id(AuthData v) => v.id;
  static const Field<AuthData, String> _f$id = Field('id', _$id);
  static String _$collectionId(AuthData v) => v.collectionId;
  static const Field<AuthData, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(AuthData v) => v.collectionName;
  static const Field<AuthData, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static String _$token(AuthData v) => v.token;
  static const Field<AuthData, String> _f$token = Field('token', _$token);

  @override
  final MappableFields<AuthData> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #token: _f$token,
  };

  static AuthData _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('AuthData');
  }

  @override
  final Function instantiate = _instantiate;

  static AuthData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthData>(map);
  }

  static AuthData fromJson(String json) {
    return ensureInitialized().decodeJson<AuthData>(json);
  }
}

mixin AuthDataMappable {
  String toJson();
  Map<String, dynamic> toMap();
  AuthDataCopyWith<AuthData, AuthData, AuthData> get copyWith;
}

abstract class AuthDataCopyWith<$R, $In extends AuthData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      String? token});
  AuthDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}
