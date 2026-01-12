// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'prescription_dto.dart';

class PrescriptionDtoMapper extends ClassMapperBase<PrescriptionDto> {
  PrescriptionDtoMapper._();

  static PrescriptionDtoMapper? _instance;
  static PrescriptionDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PrescriptionDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PrescriptionDto';

  static String _$id(PrescriptionDto v) => v.id;
  static const Field<PrescriptionDto, String> _f$id = Field('id', _$id);
  static String _$collectionId(PrescriptionDto v) => v.collectionId;
  static const Field<PrescriptionDto, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(PrescriptionDto v) => v.collectionName;
  static const Field<PrescriptionDto, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static String _$patientRecord(PrescriptionDto v) => v.patientRecord;
  static const Field<PrescriptionDto, String> _f$patientRecord = Field(
    'patientRecord',
    _$patientRecord,
  );
  static String? _$date(PrescriptionDto v) => v.date;
  static const Field<PrescriptionDto, String> _f$date = Field(
    'date',
    _$date,
    opt: true,
  );
  static String _$medication(PrescriptionDto v) => v.medication;
  static const Field<PrescriptionDto, String> _f$medication = Field(
    'medication',
    _$medication,
  );
  static String? _$instructions(PrescriptionDto v) => v.instructions;
  static const Field<PrescriptionDto, String> _f$instructions = Field(
    'instructions',
    _$instructions,
    opt: true,
  );
  static String? _$dosage(PrescriptionDto v) => v.dosage;
  static const Field<PrescriptionDto, String> _f$dosage = Field(
    'dosage',
    _$dosage,
    opt: true,
  );
  static bool _$isDeleted(PrescriptionDto v) => v.isDeleted;
  static const Field<PrescriptionDto, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static String? _$created(PrescriptionDto v) => v.created;
  static const Field<PrescriptionDto, String> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static String? _$updated(PrescriptionDto v) => v.updated;
  static const Field<PrescriptionDto, String> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );

  @override
  final MappableFields<PrescriptionDto> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #patientRecord: _f$patientRecord,
    #date: _f$date,
    #medication: _f$medication,
    #instructions: _f$instructions,
    #dosage: _f$dosage,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static PrescriptionDto _instantiate(DecodingData data) {
    return PrescriptionDto(
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      patientRecord: data.dec(_f$patientRecord),
      date: data.dec(_f$date),
      medication: data.dec(_f$medication),
      instructions: data.dec(_f$instructions),
      dosage: data.dec(_f$dosage),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PrescriptionDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PrescriptionDto>(map);
  }

  static PrescriptionDto fromJson(String json) {
    return ensureInitialized().decodeJson<PrescriptionDto>(json);
  }
}

mixin PrescriptionDtoMappable {
  String toJson() {
    return PrescriptionDtoMapper.ensureInitialized()
        .encodeJson<PrescriptionDto>(this as PrescriptionDto);
  }

  Map<String, dynamic> toMap() {
    return PrescriptionDtoMapper.ensureInitialized().encodeMap<PrescriptionDto>(
      this as PrescriptionDto,
    );
  }

  PrescriptionDtoCopyWith<PrescriptionDto, PrescriptionDto, PrescriptionDto>
  get copyWith =>
      _PrescriptionDtoCopyWithImpl<PrescriptionDto, PrescriptionDto>(
        this as PrescriptionDto,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PrescriptionDtoMapper.ensureInitialized().stringifyValue(
      this as PrescriptionDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return PrescriptionDtoMapper.ensureInitialized().equalsValue(
      this as PrescriptionDto,
      other,
    );
  }

  @override
  int get hashCode {
    return PrescriptionDtoMapper.ensureInitialized().hashValue(
      this as PrescriptionDto,
    );
  }
}

extension PrescriptionDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PrescriptionDto, $Out> {
  PrescriptionDtoCopyWith<$R, PrescriptionDto, $Out> get $asPrescriptionDto =>
      $base.as((v, t, t2) => _PrescriptionDtoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PrescriptionDtoCopyWith<$R, $In extends PrescriptionDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? patientRecord,
    String? date,
    String? medication,
    String? instructions,
    String? dosage,
    bool? isDeleted,
    String? created,
    String? updated,
  });
  PrescriptionDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PrescriptionDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PrescriptionDto, $Out>
    implements PrescriptionDtoCopyWith<$R, PrescriptionDto, $Out> {
  _PrescriptionDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PrescriptionDto> $mapper =
      PrescriptionDtoMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? patientRecord,
    Object? date = $none,
    String? medication,
    Object? instructions = $none,
    Object? dosage = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (patientRecord != null) #patientRecord: patientRecord,
      if (date != $none) #date: date,
      if (medication != null) #medication: medication,
      if (instructions != $none) #instructions: instructions,
      if (dosage != $none) #dosage: dosage,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
    }),
  );
  @override
  PrescriptionDto $make(CopyWithData data) => PrescriptionDto(
    id: data.get(#id, or: $value.id),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    patientRecord: data.get(#patientRecord, or: $value.patientRecord),
    date: data.get(#date, or: $value.date),
    medication: data.get(#medication, or: $value.medication),
    instructions: data.get(#instructions, or: $value.instructions),
    dosage: data.get(#dosage, or: $value.dosage),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
  );

  @override
  PrescriptionDtoCopyWith<$R2, PrescriptionDto, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PrescriptionDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

