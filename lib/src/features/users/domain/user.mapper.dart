// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user.dart';

class UserMapper extends ClassMapperBase<User> {
  UserMapper._();

  static UserMapper? _instance;
  static UserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserMapper._());
      PbRecordMapper.ensureInitialized();
      UserExpandMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'User';

  static String _$id(User v) => v.id;
  static const Field<User, String> _f$id = Field('id', _$id);
  static String _$collectionId(User v) => v.collectionId;
  static const Field<User, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(User v) => v.collectionName;
  static const Field<User, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static String? _$branch(User v) => v.branch;
  static const Field<User, String> _f$branch =
      Field('branch', _$branch, opt: true);
  static String _$name(User v) => v.name;
  static const Field<User, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static String _$email(User v) => v.email;
  static const Field<User, String> _f$email =
      Field('email', _$email, opt: true, def: '');
  static String? _$avatar(User v) => v.avatar;
  static const Field<User, String> _f$avatar =
      Field('avatar', _$avatar, opt: true);
  static bool _$verified(User v) => v.verified;
  static const Field<User, bool> _f$verified =
      Field('verified', _$verified, opt: true, def: false);
  static bool _$isDeleted(User v) => v.isDeleted;
  static const Field<User, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static DateTime? _$created(User v) => v.created;
  static const Field<User, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(User v) => v.updated;
  static const Field<User, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);
  static UserExpand _$expand(User v) => v.expand;
  static const Field<User, UserExpand> _f$expand = Field('expand', _$expand);

  @override
  final MappableFields<User> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #branch: _f$branch,
    #name: _f$name,
    #email: _f$email,
    #avatar: _f$avatar,
    #verified: _f$verified,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #expand: _f$expand,
  };

  static User _instantiate(DecodingData data) {
    return User(
        id: data.dec(_f$id),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        branch: data.dec(_f$branch),
        name: data.dec(_f$name),
        email: data.dec(_f$email),
        avatar: data.dec(_f$avatar),
        verified: data.dec(_f$verified),
        isDeleted: data.dec(_f$isDeleted),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated),
        expand: data.dec(_f$expand));
  }

  @override
  final Function instantiate = _instantiate;

  static User fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<User>(map);
  }

  static User fromJson(String json) {
    return ensureInitialized().decodeJson<User>(json);
  }
}

mixin UserMappable {
  String toJson() {
    return UserMapper.ensureInitialized().encodeJson<User>(this as User);
  }

  Map<String, dynamic> toMap() {
    return UserMapper.ensureInitialized().encodeMap<User>(this as User);
  }

  UserCopyWith<User, User, User> get copyWith =>
      _UserCopyWithImpl<User, User>(this as User, $identity, $identity);
  @override
  String toString() {
    return UserMapper.ensureInitialized().stringifyValue(this as User);
  }

  @override
  bool operator ==(Object other) {
    return UserMapper.ensureInitialized().equalsValue(this as User, other);
  }

  @override
  int get hashCode {
    return UserMapper.ensureInitialized().hashValue(this as User);
  }
}

extension UserValueCopy<$R, $Out> on ObjectCopyWith<$R, User, $Out> {
  UserCopyWith<$R, User, $Out> get $asUser =>
      $base.as((v, t, t2) => _UserCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserCopyWith<$R, $In extends User, $Out>
    implements PbRecordCopyWith<$R, $In, $Out> {
  UserExpandCopyWith<$R, UserExpand, UserExpand> get expand;
  @override
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      String? branch,
      String? name,
      String? email,
      String? avatar,
      bool? verified,
      bool? isDeleted,
      DateTime? created,
      DateTime? updated,
      UserExpand? expand});
  UserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, User, $Out>
    implements UserCopyWith<$R, User, $Out> {
  _UserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<User> $mapper = UserMapper.ensureInitialized();
  @override
  UserExpandCopyWith<$R, UserExpand, UserExpand> get expand =>
      $value.expand.copyWith.$chain((v) => call(expand: v));
  @override
  $R call(
          {String? id,
          String? collectionId,
          String? collectionName,
          Object? branch = $none,
          String? name,
          String? email,
          Object? avatar = $none,
          bool? verified,
          bool? isDeleted,
          Object? created = $none,
          Object? updated = $none,
          UserExpand? expand}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName,
        if (branch != $none) #branch: branch,
        if (name != null) #name: name,
        if (email != null) #email: email,
        if (avatar != $none) #avatar: avatar,
        if (verified != null) #verified: verified,
        if (isDeleted != null) #isDeleted: isDeleted,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated,
        if (expand != null) #expand: expand
      }));
  @override
  User $make(CopyWithData data) => User(
      id: data.get(#id, or: $value.id),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      branch: data.get(#branch, or: $value.branch),
      name: data.get(#name, or: $value.name),
      email: data.get(#email, or: $value.email),
      avatar: data.get(#avatar, or: $value.avatar),
      verified: data.get(#verified, or: $value.verified),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated),
      expand: data.get(#expand, or: $value.expand));

  @override
  UserCopyWith<$R2, User, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UserCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class UserExpandMapper extends ClassMapperBase<UserExpand> {
  UserExpandMapper._();

  static UserExpandMapper? _instance;
  static UserExpandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserExpandMapper._());
      BranchMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UserExpand';

  static Branch? _$branch(UserExpand v) => v.branch;
  static const Field<UserExpand, Branch> _f$branch =
      Field('branch', _$branch, opt: true);

  @override
  final MappableFields<UserExpand> fields = const {
    #branch: _f$branch,
  };

  static UserExpand _instantiate(DecodingData data) {
    return UserExpand(branch: data.dec(_f$branch));
  }

  @override
  final Function instantiate = _instantiate;

  static UserExpand fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserExpand>(map);
  }

  static UserExpand fromJson(String json) {
    return ensureInitialized().decodeJson<UserExpand>(json);
  }
}

mixin UserExpandMappable {
  String toJson() {
    return UserExpandMapper.ensureInitialized()
        .encodeJson<UserExpand>(this as UserExpand);
  }

  Map<String, dynamic> toMap() {
    return UserExpandMapper.ensureInitialized()
        .encodeMap<UserExpand>(this as UserExpand);
  }

  UserExpandCopyWith<UserExpand, UserExpand, UserExpand> get copyWith =>
      _UserExpandCopyWithImpl<UserExpand, UserExpand>(
          this as UserExpand, $identity, $identity);
  @override
  String toString() {
    return UserExpandMapper.ensureInitialized()
        .stringifyValue(this as UserExpand);
  }

  @override
  bool operator ==(Object other) {
    return UserExpandMapper.ensureInitialized()
        .equalsValue(this as UserExpand, other);
  }

  @override
  int get hashCode {
    return UserExpandMapper.ensureInitialized().hashValue(this as UserExpand);
  }
}

extension UserExpandValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserExpand, $Out> {
  UserExpandCopyWith<$R, UserExpand, $Out> get $asUserExpand =>
      $base.as((v, t, t2) => _UserExpandCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserExpandCopyWith<$R, $In extends UserExpand, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  BranchCopyWith<$R, Branch, Branch>? get branch;
  $R call({Branch? branch});
  UserExpandCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserExpandCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserExpand, $Out>
    implements UserExpandCopyWith<$R, UserExpand, $Out> {
  _UserExpandCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserExpand> $mapper =
      UserExpandMapper.ensureInitialized();
  @override
  BranchCopyWith<$R, Branch, Branch>? get branch =>
      $value.branch?.copyWith.$chain((v) => call(branch: v));
  @override
  $R call({Object? branch = $none}) =>
      $apply(FieldCopyWithData({if (branch != $none) #branch: branch}));
  @override
  UserExpand $make(CopyWithData data) =>
      UserExpand(branch: data.get(#branch, or: $value.branch));

  @override
  UserExpandCopyWith<$R2, UserExpand, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserExpandCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
