// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_breed_dto.dart';

class PatientBreedDtoMapper extends ClassMapperBase<PatientBreedDto> {
  PatientBreedDtoMapper._();

  static PatientBreedDtoMapper? _instance;
  static PatientBreedDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientBreedDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PatientBreedDto';

  static String _$id(PatientBreedDto v) => v.id;
  static const Field<PatientBreedDto, String> _f$id = Field('id', _$id);
  static String _$collectionId(PatientBreedDto v) => v.collectionId;
  static const Field<PatientBreedDto, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(PatientBreedDto v) => v.collectionName;
  static const Field<PatientBreedDto, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static String _$name(PatientBreedDto v) => v.name;
  static const Field<PatientBreedDto, String> _f$name = Field('name', _$name);
  static String _$speciesId(PatientBreedDto v) => v.speciesId;
  static const Field<PatientBreedDto, String> _f$speciesId = Field(
    'speciesId',
    _$speciesId,
  );
  static bool _$isDeleted(PatientBreedDto v) => v.isDeleted;
  static const Field<PatientBreedDto, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static String? _$created(PatientBreedDto v) => v.created;
  static const Field<PatientBreedDto, String> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static String? _$updated(PatientBreedDto v) => v.updated;
  static const Field<PatientBreedDto, String> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );

  @override
  final MappableFields<PatientBreedDto> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #name: _f$name,
    #speciesId: _f$speciesId,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static PatientBreedDto _instantiate(DecodingData data) {
    return PatientBreedDto(
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      name: data.dec(_f$name),
      speciesId: data.dec(_f$speciesId),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PatientBreedDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientBreedDto>(map);
  }

  static PatientBreedDto fromJson(String json) {
    return ensureInitialized().decodeJson<PatientBreedDto>(json);
  }
}

mixin PatientBreedDtoMappable {
  String toJson() {
    return PatientBreedDtoMapper.ensureInitialized()
        .encodeJson<PatientBreedDto>(this as PatientBreedDto);
  }

  Map<String, dynamic> toMap() {
    return PatientBreedDtoMapper.ensureInitialized().encodeMap<PatientBreedDto>(
      this as PatientBreedDto,
    );
  }

  PatientBreedDtoCopyWith<PatientBreedDto, PatientBreedDto, PatientBreedDto>
  get copyWith =>
      _PatientBreedDtoCopyWithImpl<PatientBreedDto, PatientBreedDto>(
        this as PatientBreedDto,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PatientBreedDtoMapper.ensureInitialized().stringifyValue(
      this as PatientBreedDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return PatientBreedDtoMapper.ensureInitialized().equalsValue(
      this as PatientBreedDto,
      other,
    );
  }

  @override
  int get hashCode {
    return PatientBreedDtoMapper.ensureInitialized().hashValue(
      this as PatientBreedDto,
    );
  }
}

extension PatientBreedDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientBreedDto, $Out> {
  PatientBreedDtoCopyWith<$R, PatientBreedDto, $Out> get $asPatientBreedDto =>
      $base.as((v, t, t2) => _PatientBreedDtoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientBreedDtoCopyWith<$R, $In extends PatientBreedDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? name,
    String? speciesId,
    bool? isDeleted,
    String? created,
    String? updated,
  });
  PatientBreedDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PatientBreedDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientBreedDto, $Out>
    implements PatientBreedDtoCopyWith<$R, PatientBreedDto, $Out> {
  _PatientBreedDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientBreedDto> $mapper =
      PatientBreedDtoMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? name,
    String? speciesId,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (name != null) #name: name,
      if (speciesId != null) #speciesId: speciesId,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
    }),
  );
  @override
  PatientBreedDto $make(CopyWithData data) => PatientBreedDto(
    id: data.get(#id, or: $value.id),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    name: data.get(#name, or: $value.name),
    speciesId: data.get(#speciesId, or: $value.speciesId),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
  );

  @override
  PatientBreedDtoCopyWith<$R2, PatientBreedDto, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PatientBreedDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

