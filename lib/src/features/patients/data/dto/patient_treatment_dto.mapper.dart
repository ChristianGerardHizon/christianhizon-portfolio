// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_treatment_dto.dart';

class PatientTreatmentDtoMapper extends ClassMapperBase<PatientTreatmentDto> {
  PatientTreatmentDtoMapper._();

  static PatientTreatmentDtoMapper? _instance;
  static PatientTreatmentDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientTreatmentDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PatientTreatmentDto';

  static String _$id(PatientTreatmentDto v) => v.id;
  static const Field<PatientTreatmentDto, String> _f$id = Field('id', _$id);
  static String _$collectionId(PatientTreatmentDto v) => v.collectionId;
  static const Field<PatientTreatmentDto, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(PatientTreatmentDto v) => v.collectionName;
  static const Field<PatientTreatmentDto, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static String _$name(PatientTreatmentDto v) => v.name;
  static const Field<PatientTreatmentDto, String> _f$name = Field(
    'name',
    _$name,
  );
  static String? _$icon(PatientTreatmentDto v) => v.icon;
  static const Field<PatientTreatmentDto, String> _f$icon = Field(
    'icon',
    _$icon,
    opt: true,
  );
  static String? _$branch(PatientTreatmentDto v) => v.branch;
  static const Field<PatientTreatmentDto, String> _f$branch = Field(
    'branch',
    _$branch,
    opt: true,
  );
  static bool _$isDeleted(PatientTreatmentDto v) => v.isDeleted;
  static const Field<PatientTreatmentDto, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static String? _$created(PatientTreatmentDto v) => v.created;
  static const Field<PatientTreatmentDto, String> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static String? _$updated(PatientTreatmentDto v) => v.updated;
  static const Field<PatientTreatmentDto, String> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );

  @override
  final MappableFields<PatientTreatmentDto> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #name: _f$name,
    #icon: _f$icon,
    #branch: _f$branch,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static PatientTreatmentDto _instantiate(DecodingData data) {
    return PatientTreatmentDto(
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      name: data.dec(_f$name),
      icon: data.dec(_f$icon),
      branch: data.dec(_f$branch),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PatientTreatmentDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientTreatmentDto>(map);
  }

  static PatientTreatmentDto fromJson(String json) {
    return ensureInitialized().decodeJson<PatientTreatmentDto>(json);
  }
}

mixin PatientTreatmentDtoMappable {
  String toJson() {
    return PatientTreatmentDtoMapper.ensureInitialized()
        .encodeJson<PatientTreatmentDto>(this as PatientTreatmentDto);
  }

  Map<String, dynamic> toMap() {
    return PatientTreatmentDtoMapper.ensureInitialized()
        .encodeMap<PatientTreatmentDto>(this as PatientTreatmentDto);
  }

  PatientTreatmentDtoCopyWith<
    PatientTreatmentDto,
    PatientTreatmentDto,
    PatientTreatmentDto
  >
  get copyWith =>
      _PatientTreatmentDtoCopyWithImpl<
        PatientTreatmentDto,
        PatientTreatmentDto
      >(this as PatientTreatmentDto, $identity, $identity);
  @override
  String toString() {
    return PatientTreatmentDtoMapper.ensureInitialized().stringifyValue(
      this as PatientTreatmentDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return PatientTreatmentDtoMapper.ensureInitialized().equalsValue(
      this as PatientTreatmentDto,
      other,
    );
  }

  @override
  int get hashCode {
    return PatientTreatmentDtoMapper.ensureInitialized().hashValue(
      this as PatientTreatmentDto,
    );
  }
}

extension PatientTreatmentDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientTreatmentDto, $Out> {
  PatientTreatmentDtoCopyWith<$R, PatientTreatmentDto, $Out>
  get $asPatientTreatmentDto => $base.as(
    (v, t, t2) => _PatientTreatmentDtoCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PatientTreatmentDtoCopyWith<
  $R,
  $In extends PatientTreatmentDto,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? name,
    String? icon,
    String? branch,
    bool? isDeleted,
    String? created,
    String? updated,
  });
  PatientTreatmentDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PatientTreatmentDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientTreatmentDto, $Out>
    implements PatientTreatmentDtoCopyWith<$R, PatientTreatmentDto, $Out> {
  _PatientTreatmentDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientTreatmentDto> $mapper =
      PatientTreatmentDtoMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? name,
    Object? icon = $none,
    Object? branch = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (name != null) #name: name,
      if (icon != $none) #icon: icon,
      if (branch != $none) #branch: branch,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
    }),
  );
  @override
  PatientTreatmentDto $make(CopyWithData data) => PatientTreatmentDto(
    id: data.get(#id, or: $value.id),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    name: data.get(#name, or: $value.name),
    icon: data.get(#icon, or: $value.icon),
    branch: data.get(#branch, or: $value.branch),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
  );

  @override
  PatientTreatmentDtoCopyWith<$R2, PatientTreatmentDto, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PatientTreatmentDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

