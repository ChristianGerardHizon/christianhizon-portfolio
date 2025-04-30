// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'change_log.dart';

class ChangeLogTypeMapper extends EnumMapper<ChangeLogType> {
  ChangeLogTypeMapper._();

  static ChangeLogTypeMapper? _instance;
  static ChangeLogTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChangeLogTypeMapper._());
    }
    return _instance!;
  }

  static ChangeLogType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ChangeLogType decode(dynamic value) {
    switch (value) {
      case r'create':
        return ChangeLogType.create;
      case r'update':
        return ChangeLogType.update;
      case r'delete':
        return ChangeLogType.delete;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ChangeLogType self) {
    switch (self) {
      case ChangeLogType.create:
        return r'create';
      case ChangeLogType.update:
        return r'update';
      case ChangeLogType.delete:
        return r'delete';
    }
  }
}

extension ChangeLogTypeMapperExtension on ChangeLogType {
  String toValue() {
    ChangeLogTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ChangeLogType>(this) as String;
  }
}

class ChangeLogMapper extends ClassMapperBase<ChangeLog> {
  ChangeLogMapper._();

  static ChangeLogMapper? _instance;
  static ChangeLogMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChangeLogMapper._());
      PbRecordMapper.ensureInitialized();
      ChangeLogTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ChangeLog';

  static String _$id(ChangeLog v) => v.id;
  static const Field<ChangeLog, String> _f$id = Field('id', _$id);
  static String _$collectionId(ChangeLog v) => v.collectionId;
  static const Field<ChangeLog, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(ChangeLog v) => v.collectionName;
  static const Field<ChangeLog, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static bool _$isDeleted(ChangeLog v) => v.isDeleted;
  static const Field<ChangeLog, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static ChangeLogType _$type(ChangeLog v) => v.type;
  static const Field<ChangeLog, ChangeLogType> _f$type = Field('type', _$type);
  static String? _$message(ChangeLog v) => v.message;
  static const Field<ChangeLog, String> _f$message =
      Field('message', _$message, opt: true);
  static DateTime? _$created(ChangeLog v) => v.created;
  static const Field<ChangeLog, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(ChangeLog v) => v.updated;
  static const Field<ChangeLog, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);
  static String? _$user(ChangeLog v) => v.user;
  static const Field<ChangeLog, String> _f$user =
      Field('user', _$user, opt: true);
  static String? _$admin(ChangeLog v) => v.admin;
  static const Field<ChangeLog, String> _f$admin =
      Field('admin', _$admin, opt: true);
  static dynamic _$change(ChangeLog v) => v.change;
  static const Field<ChangeLog, dynamic> _f$change =
      Field('change', _$change, opt: true);

  @override
  final MappableFields<ChangeLog> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #isDeleted: _f$isDeleted,
    #type: _f$type,
    #message: _f$message,
    #created: _f$created,
    #updated: _f$updated,
    #user: _f$user,
    #admin: _f$admin,
    #change: _f$change,
  };

  static ChangeLog _instantiate(DecodingData data) {
    return ChangeLog(
        id: data.dec(_f$id),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        isDeleted: data.dec(_f$isDeleted),
        type: data.dec(_f$type),
        message: data.dec(_f$message),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated),
        user: data.dec(_f$user),
        admin: data.dec(_f$admin),
        change: data.dec(_f$change));
  }

  @override
  final Function instantiate = _instantiate;

  static ChangeLog fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChangeLog>(map);
  }

  static ChangeLog fromJson(String json) {
    return ensureInitialized().decodeJson<ChangeLog>(json);
  }
}

mixin ChangeLogMappable {
  String toJson() {
    return ChangeLogMapper.ensureInitialized()
        .encodeJson<ChangeLog>(this as ChangeLog);
  }

  Map<String, dynamic> toMap() {
    return ChangeLogMapper.ensureInitialized()
        .encodeMap<ChangeLog>(this as ChangeLog);
  }

  ChangeLogCopyWith<ChangeLog, ChangeLog, ChangeLog> get copyWith =>
      _ChangeLogCopyWithImpl<ChangeLog, ChangeLog>(
          this as ChangeLog, $identity, $identity);
  @override
  String toString() {
    return ChangeLogMapper.ensureInitialized()
        .stringifyValue(this as ChangeLog);
  }

  @override
  bool operator ==(Object other) {
    return ChangeLogMapper.ensureInitialized()
        .equalsValue(this as ChangeLog, other);
  }

  @override
  int get hashCode {
    return ChangeLogMapper.ensureInitialized().hashValue(this as ChangeLog);
  }
}

extension ChangeLogValueCopy<$R, $Out> on ObjectCopyWith<$R, ChangeLog, $Out> {
  ChangeLogCopyWith<$R, ChangeLog, $Out> get $asChangeLog =>
      $base.as((v, t, t2) => _ChangeLogCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ChangeLogCopyWith<$R, $In extends ChangeLog, $Out>
    implements PbRecordCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      bool? isDeleted,
      ChangeLogType? type,
      String? message,
      DateTime? created,
      DateTime? updated,
      String? user,
      String? admin,
      dynamic change});
  ChangeLogCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ChangeLogCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChangeLog, $Out>
    implements ChangeLogCopyWith<$R, ChangeLog, $Out> {
  _ChangeLogCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChangeLog> $mapper =
      ChangeLogMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? collectionId,
          String? collectionName,
          bool? isDeleted,
          ChangeLogType? type,
          Object? message = $none,
          Object? created = $none,
          Object? updated = $none,
          Object? user = $none,
          Object? admin = $none,
          Object? change = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName,
        if (isDeleted != null) #isDeleted: isDeleted,
        if (type != null) #type: type,
        if (message != $none) #message: message,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated,
        if (user != $none) #user: user,
        if (admin != $none) #admin: admin,
        if (change != $none) #change: change
      }));
  @override
  ChangeLog $make(CopyWithData data) => ChangeLog(
      id: data.get(#id, or: $value.id),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      type: data.get(#type, or: $value.type),
      message: data.get(#message, or: $value.message),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated),
      user: data.get(#user, or: $value.user),
      admin: data.get(#admin, or: $value.admin),
      change: data.get(#change, or: $value.change));

  @override
  ChangeLogCopyWith<$R2, ChangeLog, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ChangeLogCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ChangeLogExpandMapper extends ClassMapperBase<ChangeLogExpand> {
  ChangeLogExpandMapper._();

  static ChangeLogExpandMapper? _instance;
  static ChangeLogExpandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChangeLogExpandMapper._());
      UserMapper.ensureInitialized();
      AdminMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ChangeLogExpand';

  static User? _$user(ChangeLogExpand v) => v.user;
  static const Field<ChangeLogExpand, User> _f$user =
      Field('user', _$user, opt: true);
  static Admin? _$admin(ChangeLogExpand v) => v.admin;
  static const Field<ChangeLogExpand, Admin> _f$admin =
      Field('admin', _$admin, opt: true);

  @override
  final MappableFields<ChangeLogExpand> fields = const {
    #user: _f$user,
    #admin: _f$admin,
  };

  static ChangeLogExpand _instantiate(DecodingData data) {
    return ChangeLogExpand(user: data.dec(_f$user), admin: data.dec(_f$admin));
  }

  @override
  final Function instantiate = _instantiate;

  static ChangeLogExpand fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChangeLogExpand>(map);
  }

  static ChangeLogExpand fromJson(String json) {
    return ensureInitialized().decodeJson<ChangeLogExpand>(json);
  }
}

mixin ChangeLogExpandMappable {
  String toJson() {
    return ChangeLogExpandMapper.ensureInitialized()
        .encodeJson<ChangeLogExpand>(this as ChangeLogExpand);
  }

  Map<String, dynamic> toMap() {
    return ChangeLogExpandMapper.ensureInitialized()
        .encodeMap<ChangeLogExpand>(this as ChangeLogExpand);
  }

  ChangeLogExpandCopyWith<ChangeLogExpand, ChangeLogExpand, ChangeLogExpand>
      get copyWith =>
          _ChangeLogExpandCopyWithImpl<ChangeLogExpand, ChangeLogExpand>(
              this as ChangeLogExpand, $identity, $identity);
  @override
  String toString() {
    return ChangeLogExpandMapper.ensureInitialized()
        .stringifyValue(this as ChangeLogExpand);
  }

  @override
  bool operator ==(Object other) {
    return ChangeLogExpandMapper.ensureInitialized()
        .equalsValue(this as ChangeLogExpand, other);
  }

  @override
  int get hashCode {
    return ChangeLogExpandMapper.ensureInitialized()
        .hashValue(this as ChangeLogExpand);
  }
}

extension ChangeLogExpandValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChangeLogExpand, $Out> {
  ChangeLogExpandCopyWith<$R, ChangeLogExpand, $Out> get $asChangeLogExpand =>
      $base.as((v, t, t2) => _ChangeLogExpandCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ChangeLogExpandCopyWith<$R, $In extends ChangeLogExpand, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  UserCopyWith<$R, User, User>? get user;
  AdminCopyWith<$R, Admin, Admin>? get admin;
  $R call({User? user, Admin? admin});
  ChangeLogExpandCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ChangeLogExpandCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChangeLogExpand, $Out>
    implements ChangeLogExpandCopyWith<$R, ChangeLogExpand, $Out> {
  _ChangeLogExpandCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChangeLogExpand> $mapper =
      ChangeLogExpandMapper.ensureInitialized();
  @override
  UserCopyWith<$R, User, User>? get user =>
      $value.user?.copyWith.$chain((v) => call(user: v));
  @override
  AdminCopyWith<$R, Admin, Admin>? get admin =>
      $value.admin?.copyWith.$chain((v) => call(admin: v));
  @override
  $R call({Object? user = $none, Object? admin = $none}) =>
      $apply(FieldCopyWithData(
          {if (user != $none) #user: user, if (admin != $none) #admin: admin}));
  @override
  ChangeLogExpand $make(CopyWithData data) => ChangeLogExpand(
      user: data.get(#user, or: $value.user),
      admin: data.get(#admin, or: $value.admin));

  @override
  ChangeLogExpandCopyWith<$R2, ChangeLogExpand, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ChangeLogExpandCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
