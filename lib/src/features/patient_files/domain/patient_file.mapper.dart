// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_file.dart';

class PatientFileMapper extends ClassMapperBase<PatientFile> {
  PatientFileMapper._();

  static PatientFileMapper? _instance;
  static PatientFileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientFileMapper._());
      PbRecordMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PatientFile';

  static String _$id(PatientFile v) => v.id;
  static const Field<PatientFile, String> _f$id = Field('id', _$id);
  static String _$collectionId(PatientFile v) => v.collectionId;
  static const Field<PatientFile, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(PatientFile v) => v.collectionName;
  static const Field<PatientFile, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static bool _$isDeleted(PatientFile v) => v.isDeleted;
  static const Field<PatientFile, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static DateTime? _$created(PatientFile v) => v.created;
  static const Field<PatientFile, DateTime> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static DateTime? _$updated(PatientFile v) => v.updated;
  static const Field<PatientFile, DateTime> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );
  static String _$patient(PatientFile v) => v.patient;
  static const Field<PatientFile, String> _f$patient = Field(
    'patient',
    _$patient,
  );
  static String _$file(PatientFile v) => v.file;
  static const Field<PatientFile, String> _f$file = Field('file', _$file);
  static String? _$notes(PatientFile v) => v.notes;
  static const Field<PatientFile, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );

  @override
  final MappableFields<PatientFile> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #patient: _f$patient,
    #file: _f$file,
    #notes: _f$notes,
  };

  static PatientFile _instantiate(DecodingData data) {
    return PatientFile(
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
      patient: data.dec(_f$patient),
      file: data.dec(_f$file),
      notes: data.dec(_f$notes),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PatientFile fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientFile>(map);
  }

  static PatientFile fromJson(String json) {
    return ensureInitialized().decodeJson<PatientFile>(json);
  }
}

mixin PatientFileMappable {
  String toJson() {
    return PatientFileMapper.ensureInitialized().encodeJson<PatientFile>(
      this as PatientFile,
    );
  }

  Map<String, dynamic> toMap() {
    return PatientFileMapper.ensureInitialized().encodeMap<PatientFile>(
      this as PatientFile,
    );
  }

  PatientFileCopyWith<PatientFile, PatientFile, PatientFile> get copyWith =>
      _PatientFileCopyWithImpl<PatientFile, PatientFile>(
        this as PatientFile,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PatientFileMapper.ensureInitialized().stringifyValue(
      this as PatientFile,
    );
  }

  @override
  bool operator ==(Object other) {
    return PatientFileMapper.ensureInitialized().equalsValue(
      this as PatientFile,
      other,
    );
  }

  @override
  int get hashCode {
    return PatientFileMapper.ensureInitialized().hashValue(this as PatientFile);
  }
}

extension PatientFileValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientFile, $Out> {
  PatientFileCopyWith<$R, PatientFile, $Out> get $asPatientFile =>
      $base.as((v, t, t2) => _PatientFileCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientFileCopyWith<$R, $In extends PatientFile, $Out>
    implements PbRecordCopyWith<$R, $In, $Out> {
  @override
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    bool? isDeleted,
    DateTime? created,
    DateTime? updated,
    String? patient,
    String? file,
    String? notes,
  });
  PatientFileCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PatientFileCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientFile, $Out>
    implements PatientFileCopyWith<$R, PatientFile, $Out> {
  _PatientFileCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientFile> $mapper =
      PatientFileMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
    String? patient,
    String? file,
    Object? notes = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
      if (patient != null) #patient: patient,
      if (file != null) #file: file,
      if (notes != $none) #notes: notes,
    }),
  );
  @override
  PatientFile $make(CopyWithData data) => PatientFile(
    id: data.get(#id, or: $value.id),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
    patient: data.get(#patient, or: $value.patient),
    file: data.get(#file, or: $value.file),
    notes: data.get(#notes, or: $value.notes),
  );

  @override
  PatientFileCopyWith<$R2, PatientFile, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PatientFileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

