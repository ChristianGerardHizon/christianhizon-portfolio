// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_species_dto.dart';

class PatientSpeciesDtoMapper extends ClassMapperBase<PatientSpeciesDto> {
  PatientSpeciesDtoMapper._();

  static PatientSpeciesDtoMapper? _instance;
  static PatientSpeciesDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientSpeciesDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PatientSpeciesDto';

  static String _$id(PatientSpeciesDto v) => v.id;
  static const Field<PatientSpeciesDto, String> _f$id = Field('id', _$id);
  static String _$collectionId(PatientSpeciesDto v) => v.collectionId;
  static const Field<PatientSpeciesDto, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(PatientSpeciesDto v) => v.collectionName;
  static const Field<PatientSpeciesDto, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static String _$name(PatientSpeciesDto v) => v.name;
  static const Field<PatientSpeciesDto, String> _f$name = Field('name', _$name);
  static bool _$isDeleted(PatientSpeciesDto v) => v.isDeleted;
  static const Field<PatientSpeciesDto, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static String? _$created(PatientSpeciesDto v) => v.created;
  static const Field<PatientSpeciesDto, String> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static String? _$updated(PatientSpeciesDto v) => v.updated;
  static const Field<PatientSpeciesDto, String> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );

  @override
  final MappableFields<PatientSpeciesDto> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #name: _f$name,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static PatientSpeciesDto _instantiate(DecodingData data) {
    return PatientSpeciesDto(
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      name: data.dec(_f$name),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PatientSpeciesDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientSpeciesDto>(map);
  }

  static PatientSpeciesDto fromJson(String json) {
    return ensureInitialized().decodeJson<PatientSpeciesDto>(json);
  }
}

mixin PatientSpeciesDtoMappable {
  String toJson() {
    return PatientSpeciesDtoMapper.ensureInitialized()
        .encodeJson<PatientSpeciesDto>(this as PatientSpeciesDto);
  }

  Map<String, dynamic> toMap() {
    return PatientSpeciesDtoMapper.ensureInitialized()
        .encodeMap<PatientSpeciesDto>(this as PatientSpeciesDto);
  }

  PatientSpeciesDtoCopyWith<
    PatientSpeciesDto,
    PatientSpeciesDto,
    PatientSpeciesDto
  >
  get copyWith =>
      _PatientSpeciesDtoCopyWithImpl<PatientSpeciesDto, PatientSpeciesDto>(
        this as PatientSpeciesDto,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PatientSpeciesDtoMapper.ensureInitialized().stringifyValue(
      this as PatientSpeciesDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return PatientSpeciesDtoMapper.ensureInitialized().equalsValue(
      this as PatientSpeciesDto,
      other,
    );
  }

  @override
  int get hashCode {
    return PatientSpeciesDtoMapper.ensureInitialized().hashValue(
      this as PatientSpeciesDto,
    );
  }
}

extension PatientSpeciesDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientSpeciesDto, $Out> {
  PatientSpeciesDtoCopyWith<$R, PatientSpeciesDto, $Out>
  get $asPatientSpeciesDto => $base.as(
    (v, t, t2) => _PatientSpeciesDtoCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PatientSpeciesDtoCopyWith<
  $R,
  $In extends PatientSpeciesDto,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? name,
    bool? isDeleted,
    String? created,
    String? updated,
  });
  PatientSpeciesDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PatientSpeciesDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientSpeciesDto, $Out>
    implements PatientSpeciesDtoCopyWith<$R, PatientSpeciesDto, $Out> {
  _PatientSpeciesDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientSpeciesDto> $mapper =
      PatientSpeciesDtoMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? name,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (name != null) #name: name,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
    }),
  );
  @override
  PatientSpeciesDto $make(CopyWithData data) => PatientSpeciesDto(
    id: data.get(#id, or: $value.id),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    name: data.get(#name, or: $value.name),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
  );

  @override
  PatientSpeciesDtoCopyWith<$R2, PatientSpeciesDto, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PatientSpeciesDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

