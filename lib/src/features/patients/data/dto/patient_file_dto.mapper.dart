// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_file_dto.dart';

class PatientFileDtoMapper extends ClassMapperBase<PatientFileDto> {
  PatientFileDtoMapper._();

  static PatientFileDtoMapper? _instance;
  static PatientFileDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientFileDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PatientFileDto';

  static String _$id(PatientFileDto v) => v.id;
  static const Field<PatientFileDto, String> _f$id = Field('id', _$id);
  static String _$collectionId(PatientFileDto v) => v.collectionId;
  static const Field<PatientFileDto, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(PatientFileDto v) => v.collectionName;
  static const Field<PatientFileDto, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static String _$patient(PatientFileDto v) => v.patient;
  static const Field<PatientFileDto, String> _f$patient = Field(
    'patient',
    _$patient,
  );
  static String _$file(PatientFileDto v) => v.file;
  static const Field<PatientFileDto, String> _f$file = Field('file', _$file);
  static String? _$notes(PatientFileDto v) => v.notes;
  static const Field<PatientFileDto, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static bool _$isDeleted(PatientFileDto v) => v.isDeleted;
  static const Field<PatientFileDto, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static String? _$created(PatientFileDto v) => v.created;
  static const Field<PatientFileDto, String> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static String? _$updated(PatientFileDto v) => v.updated;
  static const Field<PatientFileDto, String> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );

  @override
  final MappableFields<PatientFileDto> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #patient: _f$patient,
    #file: _f$file,
    #notes: _f$notes,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static PatientFileDto _instantiate(DecodingData data) {
    return PatientFileDto(
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      patient: data.dec(_f$patient),
      file: data.dec(_f$file),
      notes: data.dec(_f$notes),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PatientFileDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientFileDto>(map);
  }

  static PatientFileDto fromJson(String json) {
    return ensureInitialized().decodeJson<PatientFileDto>(json);
  }
}

mixin PatientFileDtoMappable {
  String toJson() {
    return PatientFileDtoMapper.ensureInitialized().encodeJson<PatientFileDto>(
      this as PatientFileDto,
    );
  }

  Map<String, dynamic> toMap() {
    return PatientFileDtoMapper.ensureInitialized().encodeMap<PatientFileDto>(
      this as PatientFileDto,
    );
  }

  PatientFileDtoCopyWith<PatientFileDto, PatientFileDto, PatientFileDto>
  get copyWith => _PatientFileDtoCopyWithImpl<PatientFileDto, PatientFileDto>(
    this as PatientFileDto,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return PatientFileDtoMapper.ensureInitialized().stringifyValue(
      this as PatientFileDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return PatientFileDtoMapper.ensureInitialized().equalsValue(
      this as PatientFileDto,
      other,
    );
  }

  @override
  int get hashCode {
    return PatientFileDtoMapper.ensureInitialized().hashValue(
      this as PatientFileDto,
    );
  }
}

extension PatientFileDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientFileDto, $Out> {
  PatientFileDtoCopyWith<$R, PatientFileDto, $Out> get $asPatientFileDto =>
      $base.as((v, t, t2) => _PatientFileDtoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientFileDtoCopyWith<$R, $In extends PatientFileDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? patient,
    String? file,
    String? notes,
    bool? isDeleted,
    String? created,
    String? updated,
  });
  PatientFileDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PatientFileDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientFileDto, $Out>
    implements PatientFileDtoCopyWith<$R, PatientFileDto, $Out> {
  _PatientFileDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientFileDto> $mapper =
      PatientFileDtoMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? patient,
    String? file,
    Object? notes = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (patient != null) #patient: patient,
      if (file != null) #file: file,
      if (notes != $none) #notes: notes,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
    }),
  );
  @override
  PatientFileDto $make(CopyWithData data) => PatientFileDto(
    id: data.get(#id, or: $value.id),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    patient: data.get(#patient, or: $value.patient),
    file: data.get(#file, or: $value.file),
    notes: data.get(#notes, or: $value.notes),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
  );

  @override
  PatientFileDtoCopyWith<$R2, PatientFileDto, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PatientFileDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

