// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_file.dart';

class PatientFileTypeMapper extends EnumMapper<PatientFileType> {
  PatientFileTypeMapper._();

  static PatientFileTypeMapper? _instance;
  static PatientFileTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientFileTypeMapper._());
    }
    return _instance!;
  }

  static PatientFileType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  PatientFileType decode(dynamic value) {
    switch (value) {
      case r'image':
        return PatientFileType.image;
      case r'video':
        return PatientFileType.video;
      case r'document':
        return PatientFileType.document;
      case r'unknown':
        return PatientFileType.unknown;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(PatientFileType self) {
    switch (self) {
      case PatientFileType.image:
        return r'image';
      case PatientFileType.video:
        return r'video';
      case PatientFileType.document:
        return r'document';
      case PatientFileType.unknown:
        return r'unknown';
    }
  }
}

extension PatientFileTypeMapperExtension on PatientFileType {
  String toValue() {
    PatientFileTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<PatientFileType>(this) as String;
  }
}

class PatientFileMapper extends ClassMapperBase<PatientFile> {
  PatientFileMapper._();

  static PatientFileMapper? _instance;
  static PatientFileMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientFileMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PatientFile';

  static String _$id(PatientFile v) => v.id;
  static const Field<PatientFile, String> _f$id = Field('id', _$id);
  static String _$patientId(PatientFile v) => v.patientId;
  static const Field<PatientFile, String> _f$patientId = Field(
    'patientId',
    _$patientId,
  );
  static String _$fileName(PatientFile v) => v.fileName;
  static const Field<PatientFile, String> _f$fileName = Field(
    'fileName',
    _$fileName,
  );
  static String _$fileUrl(PatientFile v) => v.fileUrl;
  static const Field<PatientFile, String> _f$fileUrl = Field(
    'fileUrl',
    _$fileUrl,
  );
  static String? _$notes(PatientFile v) => v.notes;
  static const Field<PatientFile, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
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

  @override
  final MappableFields<PatientFile> fields = const {
    #id: _f$id,
    #patientId: _f$patientId,
    #fileName: _f$fileName,
    #fileUrl: _f$fileUrl,
    #notes: _f$notes,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static PatientFile _instantiate(DecodingData data) {
    return PatientFile(
      id: data.dec(_f$id),
      patientId: data.dec(_f$patientId),
      fileName: data.dec(_f$fileName),
      fileUrl: data.dec(_f$fileUrl),
      notes: data.dec(_f$notes),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
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
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? patientId,
    String? fileName,
    String? fileUrl,
    String? notes,
    bool? isDeleted,
    DateTime? created,
    DateTime? updated,
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
    String? patientId,
    String? fileName,
    String? fileUrl,
    Object? notes = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (patientId != null) #patientId: patientId,
      if (fileName != null) #fileName: fileName,
      if (fileUrl != null) #fileUrl: fileUrl,
      if (notes != $none) #notes: notes,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
    }),
  );
  @override
  PatientFile $make(CopyWithData data) => PatientFile(
    id: data.get(#id, or: $value.id),
    patientId: data.get(#patientId, or: $value.patientId),
    fileName: data.get(#fileName, or: $value.fileName),
    fileUrl: data.get(#fileUrl, or: $value.fileUrl),
    notes: data.get(#notes, or: $value.notes),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
  );

  @override
  PatientFileCopyWith<$R2, PatientFile, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PatientFileCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

