// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'admin.dart';

class AdminMapper extends ClassMapperBase<Admin> {
  AdminMapper._();

  static AdminMapper? _instance;
  static AdminMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AdminMapper._());
      PbRecordMapper.ensureInitialized();
      AdminExpandMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Admin';

  static String _$id(Admin v) => v.id;
  static const Field<Admin, String> _f$id = Field('id', _$id);
  static String _$collectionId(Admin v) => v.collectionId;
  static const Field<Admin, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(Admin v) => v.collectionName;
  static const Field<Admin, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static String _$name(Admin v) => v.name;
  static const Field<Admin, String> _f$name = Field('name', _$name);
  static String? _$branch(Admin v) => v.branch;
  static const Field<Admin, String> _f$branch =
      Field('branch', _$branch, opt: true, hook: PbEmptyHook());
  static String _$email(Admin v) => v.email;
  static const Field<Admin, String> _f$email =
      Field('email', _$email, opt: true, def: '');
  static String? _$avatar(Admin v) => v.avatar;
  static const Field<Admin, String> _f$avatar =
      Field('avatar', _$avatar, opt: true);
  static bool _$verified(Admin v) => v.verified;
  static const Field<Admin, bool> _f$verified =
      Field('verified', _$verified, opt: true, def: false);
  static bool _$isDeleted(Admin v) => v.isDeleted;
  static const Field<Admin, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static DateTime? _$created(Admin v) => v.created;
  static const Field<Admin, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(Admin v) => v.updated;
  static const Field<Admin, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);
  static AdminExpand _$expand(Admin v) => v.expand;
  static const Field<Admin, AdminExpand> _f$expand = Field('expand', _$expand);

  @override
  final MappableFields<Admin> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #name: _f$name,
    #branch: _f$branch,
    #email: _f$email,
    #avatar: _f$avatar,
    #verified: _f$verified,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #expand: _f$expand,
  };

  static Admin _instantiate(DecodingData data) {
    return Admin(
        id: data.dec(_f$id),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        name: data.dec(_f$name),
        branch: data.dec(_f$branch),
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

  static Admin fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Admin>(map);
  }

  static Admin fromJson(String json) {
    return ensureInitialized().decodeJson<Admin>(json);
  }
}

mixin AdminMappable {
  String toJson() {
    return AdminMapper.ensureInitialized().encodeJson<Admin>(this as Admin);
  }

  Map<String, dynamic> toMap() {
    return AdminMapper.ensureInitialized().encodeMap<Admin>(this as Admin);
  }

  AdminCopyWith<Admin, Admin, Admin> get copyWith =>
      _AdminCopyWithImpl<Admin, Admin>(this as Admin, $identity, $identity);
  @override
  String toString() {
    return AdminMapper.ensureInitialized().stringifyValue(this as Admin);
  }

  @override
  bool operator ==(Object other) {
    return AdminMapper.ensureInitialized().equalsValue(this as Admin, other);
  }

  @override
  int get hashCode {
    return AdminMapper.ensureInitialized().hashValue(this as Admin);
  }
}

extension AdminValueCopy<$R, $Out> on ObjectCopyWith<$R, Admin, $Out> {
  AdminCopyWith<$R, Admin, $Out> get $asAdmin =>
      $base.as((v, t, t2) => _AdminCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AdminCopyWith<$R, $In extends Admin, $Out>
    implements PbRecordCopyWith<$R, $In, $Out> {
  AdminExpandCopyWith<$R, AdminExpand, AdminExpand> get expand;
  @override
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      String? name,
      String? branch,
      String? email,
      String? avatar,
      bool? verified,
      bool? isDeleted,
      DateTime? created,
      DateTime? updated,
      AdminExpand? expand});
  AdminCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AdminCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Admin, $Out>
    implements AdminCopyWith<$R, Admin, $Out> {
  _AdminCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Admin> $mapper = AdminMapper.ensureInitialized();
  @override
  AdminExpandCopyWith<$R, AdminExpand, AdminExpand> get expand =>
      $value.expand.copyWith.$chain((v) => call(expand: v));
  @override
  $R call(
          {String? id,
          String? collectionId,
          String? collectionName,
          String? name,
          Object? branch = $none,
          String? email,
          Object? avatar = $none,
          bool? verified,
          bool? isDeleted,
          Object? created = $none,
          Object? updated = $none,
          AdminExpand? expand}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName,
        if (name != null) #name: name,
        if (branch != $none) #branch: branch,
        if (email != null) #email: email,
        if (avatar != $none) #avatar: avatar,
        if (verified != null) #verified: verified,
        if (isDeleted != null) #isDeleted: isDeleted,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated,
        if (expand != null) #expand: expand
      }));
  @override
  Admin $make(CopyWithData data) => Admin(
      id: data.get(#id, or: $value.id),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      name: data.get(#name, or: $value.name),
      branch: data.get(#branch, or: $value.branch),
      email: data.get(#email, or: $value.email),
      avatar: data.get(#avatar, or: $value.avatar),
      verified: data.get(#verified, or: $value.verified),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated),
      expand: data.get(#expand, or: $value.expand));

  @override
  AdminCopyWith<$R2, Admin, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AdminCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AdminExpandMapper extends ClassMapperBase<AdminExpand> {
  AdminExpandMapper._();

  static AdminExpandMapper? _instance;
  static AdminExpandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AdminExpandMapper._());
      BranchMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AdminExpand';

  static Branch? _$branch(AdminExpand v) => v.branch;
  static const Field<AdminExpand, Branch> _f$branch =
      Field('branch', _$branch, opt: true);

  @override
  final MappableFields<AdminExpand> fields = const {
    #branch: _f$branch,
  };

  static AdminExpand _instantiate(DecodingData data) {
    return AdminExpand(branch: data.dec(_f$branch));
  }

  @override
  final Function instantiate = _instantiate;

  static AdminExpand fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AdminExpand>(map);
  }

  static AdminExpand fromJson(String json) {
    return ensureInitialized().decodeJson<AdminExpand>(json);
  }
}

mixin AdminExpandMappable {
  String toJson() {
    return AdminExpandMapper.ensureInitialized()
        .encodeJson<AdminExpand>(this as AdminExpand);
  }

  Map<String, dynamic> toMap() {
    return AdminExpandMapper.ensureInitialized()
        .encodeMap<AdminExpand>(this as AdminExpand);
  }

  AdminExpandCopyWith<AdminExpand, AdminExpand, AdminExpand> get copyWith =>
      _AdminExpandCopyWithImpl<AdminExpand, AdminExpand>(
          this as AdminExpand, $identity, $identity);
  @override
  String toString() {
    return AdminExpandMapper.ensureInitialized()
        .stringifyValue(this as AdminExpand);
  }

  @override
  bool operator ==(Object other) {
    return AdminExpandMapper.ensureInitialized()
        .equalsValue(this as AdminExpand, other);
  }

  @override
  int get hashCode {
    return AdminExpandMapper.ensureInitialized().hashValue(this as AdminExpand);
  }
}

extension AdminExpandValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AdminExpand, $Out> {
  AdminExpandCopyWith<$R, AdminExpand, $Out> get $asAdminExpand =>
      $base.as((v, t, t2) => _AdminExpandCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AdminExpandCopyWith<$R, $In extends AdminExpand, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  BranchCopyWith<$R, Branch, Branch>? get branch;
  $R call({Branch? branch});
  AdminExpandCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AdminExpandCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AdminExpand, $Out>
    implements AdminExpandCopyWith<$R, AdminExpand, $Out> {
  _AdminExpandCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AdminExpand> $mapper =
      AdminExpandMapper.ensureInitialized();
  @override
  BranchCopyWith<$R, Branch, Branch>? get branch =>
      $value.branch?.copyWith.$chain((v) => call(branch: v));
  @override
  $R call({Object? branch = $none}) =>
      $apply(FieldCopyWithData({if (branch != $none) #branch: branch}));
  @override
  AdminExpand $make(CopyWithData data) =>
      AdminExpand(branch: data.get(#branch, or: $value.branch));

  @override
  AdminExpandCopyWith<$R2, AdminExpand, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AdminExpandCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
