// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_role_dto.dart';

class UserRoleDtoMapper extends ClassMapperBase<UserRoleDto> {
  UserRoleDtoMapper._();

  static UserRoleDtoMapper? _instance;
  static UserRoleDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserRoleDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserRoleDto';

  static String _$id(UserRoleDto v) => v.id;
  static const Field<UserRoleDto, String> _f$id = Field('id', _$id);
  static String _$user(UserRoleDto v) => v.user;
  static const Field<UserRoleDto, String> _f$user = Field('user', _$user);
  static String _$collectionId(UserRoleDto v) => v.collectionId;
  static const Field<UserRoleDto, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(UserRoleDto v) => v.collectionName;
  static const Field<UserRoleDto, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static bool _$isAdmin(UserRoleDto v) => v.isAdmin;
  static const Field<UserRoleDto, bool> _f$isAdmin = Field(
    'isAdmin',
    _$isAdmin,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<UserRoleDto> fields = const {
    #id: _f$id,
    #user: _f$user,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #isAdmin: _f$isAdmin,
  };

  static UserRoleDto _instantiate(DecodingData data) {
    return UserRoleDto(
      id: data.dec(_f$id),
      user: data.dec(_f$user),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      isAdmin: data.dec(_f$isAdmin),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UserRoleDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserRoleDto>(map);
  }

  static UserRoleDto fromJson(String json) {
    return ensureInitialized().decodeJson<UserRoleDto>(json);
  }
}

mixin UserRoleDtoMappable {
  String toJson() {
    return UserRoleDtoMapper.ensureInitialized().encodeJson<UserRoleDto>(
      this as UserRoleDto,
    );
  }

  Map<String, dynamic> toMap() {
    return UserRoleDtoMapper.ensureInitialized().encodeMap<UserRoleDto>(
      this as UserRoleDto,
    );
  }

  UserRoleDtoCopyWith<UserRoleDto, UserRoleDto, UserRoleDto> get copyWith =>
      _UserRoleDtoCopyWithImpl<UserRoleDto, UserRoleDto>(
        this as UserRoleDto,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserRoleDtoMapper.ensureInitialized().stringifyValue(
      this as UserRoleDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserRoleDtoMapper.ensureInitialized().equalsValue(
      this as UserRoleDto,
      other,
    );
  }

  @override
  int get hashCode {
    return UserRoleDtoMapper.ensureInitialized().hashValue(this as UserRoleDto);
  }
}

extension UserRoleDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserRoleDto, $Out> {
  UserRoleDtoCopyWith<$R, UserRoleDto, $Out> get $asUserRoleDto =>
      $base.as((v, t, t2) => _UserRoleDtoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserRoleDtoCopyWith<$R, $In extends UserRoleDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? user,
    String? collectionId,
    String? collectionName,
    bool? isAdmin,
  });
  UserRoleDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserRoleDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserRoleDto, $Out>
    implements UserRoleDtoCopyWith<$R, UserRoleDto, $Out> {
  _UserRoleDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserRoleDto> $mapper =
      UserRoleDtoMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? user,
    String? collectionId,
    String? collectionName,
    bool? isAdmin,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (user != null) #user: user,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (isAdmin != null) #isAdmin: isAdmin,
    }),
  );
  @override
  UserRoleDto $make(CopyWithData data) => UserRoleDto(
    id: data.get(#id, or: $value.id),
    user: data.get(#user, or: $value.user),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    isAdmin: data.get(#isAdmin, or: $value.isAdmin),
  );

  @override
  UserRoleDtoCopyWith<$R2, UserRoleDto, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserRoleDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

