// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'admin_form_controller.dart';

class AdminFormStateMapper extends ClassMapperBase<AdminFormState> {
  AdminFormStateMapper._();

  static AdminFormStateMapper? _instance;
  static AdminFormStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AdminFormStateMapper._());
      AdminMapper.ensureInitialized();
      BranchMapper.ensureInitialized();
      PBFileMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AdminFormState';

  static Admin? _$admin(AdminFormState v) => v.admin;
  static const Field<AdminFormState, Admin> _f$admin = Field('admin', _$admin);
  static List<Branch> _$branches(AdminFormState v) => v.branches;
  static const Field<AdminFormState, List<Branch>> _f$branches = Field(
    'branches',
    _$branches,
    opt: true,
    def: const [],
  );
  static List<PBFile>? _$images(AdminFormState v) => v.images;
  static const Field<AdminFormState, List<PBFile>> _f$images = Field(
    'images',
    _$images,
    opt: true,
  );

  @override
  final MappableFields<AdminFormState> fields = const {
    #admin: _f$admin,
    #branches: _f$branches,
    #images: _f$images,
  };

  static AdminFormState _instantiate(DecodingData data) {
    return AdminFormState(
      admin: data.dec(_f$admin),
      branches: data.dec(_f$branches),
      images: data.dec(_f$images),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AdminFormState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AdminFormState>(map);
  }

  static AdminFormState fromJson(String json) {
    return ensureInitialized().decodeJson<AdminFormState>(json);
  }
}

mixin AdminFormStateMappable {
  String toJson() {
    return AdminFormStateMapper.ensureInitialized().encodeJson<AdminFormState>(
      this as AdminFormState,
    );
  }

  Map<String, dynamic> toMap() {
    return AdminFormStateMapper.ensureInitialized().encodeMap<AdminFormState>(
      this as AdminFormState,
    );
  }

  AdminFormStateCopyWith<AdminFormState, AdminFormState, AdminFormState>
  get copyWith => _AdminFormStateCopyWithImpl<AdminFormState, AdminFormState>(
    this as AdminFormState,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return AdminFormStateMapper.ensureInitialized().stringifyValue(
      this as AdminFormState,
    );
  }

  @override
  bool operator ==(Object other) {
    return AdminFormStateMapper.ensureInitialized().equalsValue(
      this as AdminFormState,
      other,
    );
  }

  @override
  int get hashCode {
    return AdminFormStateMapper.ensureInitialized().hashValue(
      this as AdminFormState,
    );
  }
}

extension AdminFormStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AdminFormState, $Out> {
  AdminFormStateCopyWith<$R, AdminFormState, $Out> get $asAdminFormState =>
      $base.as((v, t, t2) => _AdminFormStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AdminFormStateCopyWith<$R, $In extends AdminFormState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  AdminCopyWith<$R, Admin, Admin>? get admin;
  ListCopyWith<$R, Branch, BranchCopyWith<$R, Branch, Branch>> get branches;
  ListCopyWith<$R, PBFile, ObjectCopyWith<$R, PBFile, PBFile>>? get images;
  $R call({Admin? admin, List<Branch>? branches, List<PBFile>? images});
  AdminFormStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AdminFormStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AdminFormState, $Out>
    implements AdminFormStateCopyWith<$R, AdminFormState, $Out> {
  _AdminFormStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AdminFormState> $mapper =
      AdminFormStateMapper.ensureInitialized();
  @override
  AdminCopyWith<$R, Admin, Admin>? get admin =>
      $value.admin?.copyWith.$chain((v) => call(admin: v));
  @override
  ListCopyWith<$R, Branch, BranchCopyWith<$R, Branch, Branch>> get branches =>
      ListCopyWith(
        $value.branches,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(branches: v),
      );
  @override
  ListCopyWith<$R, PBFile, ObjectCopyWith<$R, PBFile, PBFile>>? get images =>
      $value.images != null
      ? ListCopyWith(
          $value.images!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(images: v),
        )
      : null;
  @override
  $R call({
    Object? admin = $none,
    List<Branch>? branches,
    Object? images = $none,
  }) => $apply(
    FieldCopyWithData({
      if (admin != $none) #admin: admin,
      if (branches != null) #branches: branches,
      if (images != $none) #images: images,
    }),
  );
  @override
  AdminFormState $make(CopyWithData data) => AdminFormState(
    admin: data.get(#admin, or: $value.admin),
    branches: data.get(#branches, or: $value.branches),
    images: data.get(#images, or: $value.images),
  );

  @override
  AdminFormStateCopyWith<$R2, AdminFormState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AdminFormStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

