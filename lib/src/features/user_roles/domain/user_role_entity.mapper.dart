// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_role_entity.dart';

class UserRoleEntityMapper extends ClassMapperBase<UserRoleEntity> {
  UserRoleEntityMapper._();

  static UserRoleEntityMapper? _instance;
  static UserRoleEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserRoleEntityMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserRoleEntity';

  static String _$id(UserRoleEntity v) => v.id;
  static const Field<UserRoleEntity, String> _f$id = Field('id', _$id);
  static String _$userId(UserRoleEntity v) => v.userId;
  static const Field<UserRoleEntity, String> _f$userId = Field(
    'userId',
    _$userId,
  );
  static bool _$isAdmin(UserRoleEntity v) => v.isAdmin;
  static const Field<UserRoleEntity, bool> _f$isAdmin = Field(
    'isAdmin',
    _$isAdmin,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<UserRoleEntity> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #isAdmin: _f$isAdmin,
  };

  static UserRoleEntity _instantiate(DecodingData data) {
    return UserRoleEntity(
      id: data.dec(_f$id),
      userId: data.dec(_f$userId),
      isAdmin: data.dec(_f$isAdmin),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UserRoleEntity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserRoleEntity>(map);
  }

  static UserRoleEntity fromJson(String json) {
    return ensureInitialized().decodeJson<UserRoleEntity>(json);
  }
}

mixin UserRoleEntityMappable {
  String toJson() {
    return UserRoleEntityMapper.ensureInitialized().encodeJson<UserRoleEntity>(
      this as UserRoleEntity,
    );
  }

  Map<String, dynamic> toMap() {
    return UserRoleEntityMapper.ensureInitialized().encodeMap<UserRoleEntity>(
      this as UserRoleEntity,
    );
  }

  UserRoleEntityCopyWith<UserRoleEntity, UserRoleEntity, UserRoleEntity>
  get copyWith => _UserRoleEntityCopyWithImpl<UserRoleEntity, UserRoleEntity>(
    this as UserRoleEntity,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return UserRoleEntityMapper.ensureInitialized().stringifyValue(
      this as UserRoleEntity,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserRoleEntityMapper.ensureInitialized().equalsValue(
      this as UserRoleEntity,
      other,
    );
  }

  @override
  int get hashCode {
    return UserRoleEntityMapper.ensureInitialized().hashValue(
      this as UserRoleEntity,
    );
  }
}

extension UserRoleEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserRoleEntity, $Out> {
  UserRoleEntityCopyWith<$R, UserRoleEntity, $Out> get $asUserRoleEntity =>
      $base.as((v, t, t2) => _UserRoleEntityCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserRoleEntityCopyWith<$R, $In extends UserRoleEntity, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? userId, bool? isAdmin});
  UserRoleEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UserRoleEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserRoleEntity, $Out>
    implements UserRoleEntityCopyWith<$R, UserRoleEntity, $Out> {
  _UserRoleEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserRoleEntity> $mapper =
      UserRoleEntityMapper.ensureInitialized();
  @override
  $R call({String? id, String? userId, bool? isAdmin}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (userId != null) #userId: userId,
      if (isAdmin != null) #isAdmin: isAdmin,
    }),
  );
  @override
  UserRoleEntity $make(CopyWithData data) => UserRoleEntity(
    id: data.get(#id, or: $value.id),
    userId: data.get(#userId, or: $value.userId),
    isAdmin: data.get(#isAdmin, or: $value.isAdmin),
  );

  @override
  UserRoleEntityCopyWith<$R2, UserRoleEntity, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserRoleEntityCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

