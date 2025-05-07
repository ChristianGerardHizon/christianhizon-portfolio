// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_form_controller.dart';

class UserFormStateMapper extends ClassMapperBase<UserFormState> {
  UserFormStateMapper._();

  static UserFormStateMapper? _instance;
  static UserFormStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserFormStateMapper._());
      UserMapper.ensureInitialized();
      PBFileMapper.ensureInitialized();
      BranchMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'UserFormState';

  static User? _$user(UserFormState v) => v.user;
  static const Field<UserFormState, User> _f$user = Field('user', _$user);
  static List<PBFile>? _$images(UserFormState v) => v.images;
  static const Field<UserFormState, List<PBFile>> _f$images =
      Field('images', _$images, opt: true);
  static List<Branch> _$branches(UserFormState v) => v.branches;
  static const Field<UserFormState, List<Branch>> _f$branches =
      Field('branches', _$branches, opt: true, def: const []);

  @override
  final MappableFields<UserFormState> fields = const {
    #user: _f$user,
    #images: _f$images,
    #branches: _f$branches,
  };

  static UserFormState _instantiate(DecodingData data) {
    return UserFormState(
        user: data.dec(_f$user),
        images: data.dec(_f$images),
        branches: data.dec(_f$branches));
  }

  @override
  final Function instantiate = _instantiate;

  static UserFormState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserFormState>(map);
  }

  static UserFormState fromJson(String json) {
    return ensureInitialized().decodeJson<UserFormState>(json);
  }
}

mixin UserFormStateMappable {
  String toJson() {
    return UserFormStateMapper.ensureInitialized()
        .encodeJson<UserFormState>(this as UserFormState);
  }

  Map<String, dynamic> toMap() {
    return UserFormStateMapper.ensureInitialized()
        .encodeMap<UserFormState>(this as UserFormState);
  }

  UserFormStateCopyWith<UserFormState, UserFormState, UserFormState>
      get copyWith => _UserFormStateCopyWithImpl<UserFormState, UserFormState>(
          this as UserFormState, $identity, $identity);
  @override
  String toString() {
    return UserFormStateMapper.ensureInitialized()
        .stringifyValue(this as UserFormState);
  }

  @override
  bool operator ==(Object other) {
    return UserFormStateMapper.ensureInitialized()
        .equalsValue(this as UserFormState, other);
  }

  @override
  int get hashCode {
    return UserFormStateMapper.ensureInitialized()
        .hashValue(this as UserFormState);
  }
}

extension UserFormStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserFormState, $Out> {
  UserFormStateCopyWith<$R, UserFormState, $Out> get $asUserFormState =>
      $base.as((v, t, t2) => _UserFormStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserFormStateCopyWith<$R, $In extends UserFormState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  UserCopyWith<$R, User, User>? get user;
  ListCopyWith<$R, PBFile, ObjectCopyWith<$R, PBFile, PBFile>>? get images;
  ListCopyWith<$R, Branch, BranchCopyWith<$R, Branch, Branch>> get branches;
  $R call({User? user, List<PBFile>? images, List<Branch>? branches});
  UserFormStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserFormStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserFormState, $Out>
    implements UserFormStateCopyWith<$R, UserFormState, $Out> {
  _UserFormStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserFormState> $mapper =
      UserFormStateMapper.ensureInitialized();
  @override
  UserCopyWith<$R, User, User>? get user =>
      $value.user?.copyWith.$chain((v) => call(user: v));
  @override
  ListCopyWith<$R, PBFile, ObjectCopyWith<$R, PBFile, PBFile>>? get images =>
      $value.images != null
          ? ListCopyWith($value.images!,
              (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(images: v))
          : null;
  @override
  ListCopyWith<$R, Branch, BranchCopyWith<$R, Branch, Branch>> get branches =>
      ListCopyWith($value.branches, (v, t) => v.copyWith.$chain(t),
          (v) => call(branches: v));
  @override
  $R call(
          {Object? user = $none,
          Object? images = $none,
          List<Branch>? branches}) =>
      $apply(FieldCopyWithData({
        if (user != $none) #user: user,
        if (images != $none) #images: images,
        if (branches != null) #branches: branches
      }));
  @override
  UserFormState $make(CopyWithData data) => UserFormState(
      user: data.get(#user, or: $value.user),
      images: data.get(#images, or: $value.images),
      branches: data.get(#branches, or: $value.branches));

  @override
  UserFormStateCopyWith<$R2, UserFormState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserFormStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
