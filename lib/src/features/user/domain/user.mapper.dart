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
    }
    return _instance!;
  }

  @override
  final String id = 'User';

  static String _$id(User v) => v.id;
  static const Field<User, String> _f$id = Field('id', _$id);
  static String _$name(User v) => v.name;
  static const Field<User, String> _f$name = Field('name', _$name);
  static String _$email(User v) => v.email;
  static const Field<User, String> _f$email =
      Field('email', _$email, opt: true, def: '');
  static String? _$profilePhoto(User v) => v.profilePhoto;
  static const Field<User, String> _f$profilePhoto =
      Field('profilePhoto', _$profilePhoto, opt: true);
  static String? _$contactNumber(User v) => v.contactNumber;
  static const Field<User, String> _f$contactNumber =
      Field('contactNumber', _$contactNumber, opt: true);
  static bool _$isDeleted(User v) => v.isDeleted;
  static const Field<User, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);

  @override
  final MappableFields<User> fields = const {
    #id: _f$id,
    #name: _f$name,
    #email: _f$email,
    #profilePhoto: _f$profilePhoto,
    #contactNumber: _f$contactNumber,
    #isDeleted: _f$isDeleted,
  };

  static User _instantiate(DecodingData data) {
    return User(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        email: data.dec(_f$email),
        profilePhoto: data.dec(_f$profilePhoto),
        contactNumber: data.dec(_f$contactNumber),
        isDeleted: data.dec(_f$isDeleted));
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
      _UserCopyWithImpl(this as User, $identity, $identity);
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
      $base.as((v, t, t2) => _UserCopyWithImpl(v, t, t2));
}

abstract class UserCopyWith<$R, $In extends User, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? name,
      String? email,
      String? profilePhoto,
      String? contactNumber,
      bool? isDeleted});
  UserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, User, $Out>
    implements UserCopyWith<$R, User, $Out> {
  _UserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<User> $mapper = UserMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? name,
          String? email,
          Object? profilePhoto = $none,
          Object? contactNumber = $none,
          bool? isDeleted}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (email != null) #email: email,
        if (profilePhoto != $none) #profilePhoto: profilePhoto,
        if (contactNumber != $none) #contactNumber: contactNumber,
        if (isDeleted != null) #isDeleted: isDeleted
      }));
  @override
  User $make(CopyWithData data) => User(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      email: data.get(#email, or: $value.email),
      profilePhoto: data.get(#profilePhoto, or: $value.profilePhoto),
      contactNumber: data.get(#contactNumber, or: $value.contactNumber),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted));

  @override
  UserCopyWith<$R2, User, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UserCopyWithImpl($value, $cast, t);
}
