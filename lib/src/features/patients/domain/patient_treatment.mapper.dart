// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_treatment.dart';

class PatientTreatmentMapper extends ClassMapperBase<PatientTreatment> {
  PatientTreatmentMapper._();

  static PatientTreatmentMapper? _instance;
  static PatientTreatmentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientTreatmentMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PatientTreatment';

  static String _$id(PatientTreatment v) => v.id;
  static const Field<PatientTreatment, String> _f$id = Field('id', _$id);
  static String _$name(PatientTreatment v) => v.name;
  static const Field<PatientTreatment, String> _f$name = Field('name', _$name);
  static String? _$icon(PatientTreatment v) => v.icon;
  static const Field<PatientTreatment, String> _f$icon = Field(
    'icon',
    _$icon,
    opt: true,
  );
  static bool _$isDeleted(PatientTreatment v) => v.isDeleted;
  static const Field<PatientTreatment, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static DateTime? _$created(PatientTreatment v) => v.created;
  static const Field<PatientTreatment, DateTime> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static DateTime? _$updated(PatientTreatment v) => v.updated;
  static const Field<PatientTreatment, DateTime> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );

  @override
  final MappableFields<PatientTreatment> fields = const {
    #id: _f$id,
    #name: _f$name,
    #icon: _f$icon,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static PatientTreatment _instantiate(DecodingData data) {
    return PatientTreatment(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      icon: data.dec(_f$icon),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PatientTreatment fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientTreatment>(map);
  }

  static PatientTreatment fromJson(String json) {
    return ensureInitialized().decodeJson<PatientTreatment>(json);
  }
}

mixin PatientTreatmentMappable {
  String toJson() {
    return PatientTreatmentMapper.ensureInitialized()
        .encodeJson<PatientTreatment>(this as PatientTreatment);
  }

  Map<String, dynamic> toMap() {
    return PatientTreatmentMapper.ensureInitialized()
        .encodeMap<PatientTreatment>(this as PatientTreatment);
  }

  PatientTreatmentCopyWith<PatientTreatment, PatientTreatment, PatientTreatment>
  get copyWith =>
      _PatientTreatmentCopyWithImpl<PatientTreatment, PatientTreatment>(
        this as PatientTreatment,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PatientTreatmentMapper.ensureInitialized().stringifyValue(
      this as PatientTreatment,
    );
  }

  @override
  bool operator ==(Object other) {
    return PatientTreatmentMapper.ensureInitialized().equalsValue(
      this as PatientTreatment,
      other,
    );
  }

  @override
  int get hashCode {
    return PatientTreatmentMapper.ensureInitialized().hashValue(
      this as PatientTreatment,
    );
  }
}

extension PatientTreatmentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientTreatment, $Out> {
  PatientTreatmentCopyWith<$R, PatientTreatment, $Out>
  get $asPatientTreatment =>
      $base.as((v, t, t2) => _PatientTreatmentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientTreatmentCopyWith<$R, $In extends PatientTreatment, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    String? icon,
    bool? isDeleted,
    DateTime? created,
    DateTime? updated,
  });
  PatientTreatmentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PatientTreatmentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientTreatment, $Out>
    implements PatientTreatmentCopyWith<$R, PatientTreatment, $Out> {
  _PatientTreatmentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientTreatment> $mapper =
      PatientTreatmentMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? name,
    Object? icon = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (icon != $none) #icon: icon,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
    }),
  );
  @override
  PatientTreatment $make(CopyWithData data) => PatientTreatment(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    icon: data.get(#icon, or: $value.icon),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
  );

  @override
  PatientTreatmentCopyWith<$R2, PatientTreatment, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PatientTreatmentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

