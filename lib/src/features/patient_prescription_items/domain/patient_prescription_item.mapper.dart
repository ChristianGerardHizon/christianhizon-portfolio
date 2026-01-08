// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_prescription_item.dart';

class PatientPrescriptionItemMapper
    extends ClassMapperBase<PatientPrescriptionItem> {
  PatientPrescriptionItemMapper._();

  static PatientPrescriptionItemMapper? _instance;
  static PatientPrescriptionItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = PatientPrescriptionItemMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'PatientPrescriptionItem';

  static String _$collectionId(PatientPrescriptionItem v) => v.collectionId;
  static const Field<PatientPrescriptionItem, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(PatientPrescriptionItem v) => v.collectionName;
  static const Field<PatientPrescriptionItem, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static String _$id(PatientPrescriptionItem v) => v.id;
  static const Field<PatientPrescriptionItem, String> _f$id = Field('id', _$id);
  static String _$patientRecord(PatientPrescriptionItem v) => v.patientRecord;
  static const Field<PatientPrescriptionItem, String> _f$patientRecord = Field(
    'patientRecord',
    _$patientRecord,
  );
  static DateTime _$date(PatientPrescriptionItem v) => v.date;
  static const Field<PatientPrescriptionItem, DateTime> _f$date = Field(
    'date',
    _$date,
    hook: DateTimeHook(),
  );
  static String? _$medication(PatientPrescriptionItem v) => v.medication;
  static const Field<PatientPrescriptionItem, String> _f$medication = Field(
    'medication',
    _$medication,
    opt: true,
    def: '',
  );
  static String? _$instructions(PatientPrescriptionItem v) => v.instructions;
  static const Field<PatientPrescriptionItem, String> _f$instructions = Field(
    'instructions',
    _$instructions,
    opt: true,
  );
  static String? _$dosage(PatientPrescriptionItem v) => v.dosage;
  static const Field<PatientPrescriptionItem, String> _f$dosage = Field(
    'dosage',
    _$dosage,
    opt: true,
  );
  static DateTime? _$created(PatientPrescriptionItem v) => v.created;
  static const Field<PatientPrescriptionItem, DateTime> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static DateTime? _$updated(PatientPrescriptionItem v) => v.updated;
  static const Field<PatientPrescriptionItem, DateTime> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );
  static bool _$isDeleted(PatientPrescriptionItem v) => v.isDeleted;
  static const Field<PatientPrescriptionItem, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<PatientPrescriptionItem> fields = const {
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #id: _f$id,
    #patientRecord: _f$patientRecord,
    #date: _f$date,
    #medication: _f$medication,
    #instructions: _f$instructions,
    #dosage: _f$dosage,
    #created: _f$created,
    #updated: _f$updated,
    #isDeleted: _f$isDeleted,
  };

  static PatientPrescriptionItem _instantiate(DecodingData data) {
    return PatientPrescriptionItem(
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      id: data.dec(_f$id),
      patientRecord: data.dec(_f$patientRecord),
      date: data.dec(_f$date),
      medication: data.dec(_f$medication),
      instructions: data.dec(_f$instructions),
      dosage: data.dec(_f$dosage),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
      isDeleted: data.dec(_f$isDeleted),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PatientPrescriptionItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientPrescriptionItem>(map);
  }

  static PatientPrescriptionItem fromJson(String json) {
    return ensureInitialized().decodeJson<PatientPrescriptionItem>(json);
  }
}

mixin PatientPrescriptionItemMappable {
  String toJson() {
    return PatientPrescriptionItemMapper.ensureInitialized()
        .encodeJson<PatientPrescriptionItem>(this as PatientPrescriptionItem);
  }

  Map<String, dynamic> toMap() {
    return PatientPrescriptionItemMapper.ensureInitialized()
        .encodeMap<PatientPrescriptionItem>(this as PatientPrescriptionItem);
  }

  PatientPrescriptionItemCopyWith<
    PatientPrescriptionItem,
    PatientPrescriptionItem,
    PatientPrescriptionItem
  >
  get copyWith =>
      _PatientPrescriptionItemCopyWithImpl<
        PatientPrescriptionItem,
        PatientPrescriptionItem
      >(this as PatientPrescriptionItem, $identity, $identity);
  @override
  String toString() {
    return PatientPrescriptionItemMapper.ensureInitialized().stringifyValue(
      this as PatientPrescriptionItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return PatientPrescriptionItemMapper.ensureInitialized().equalsValue(
      this as PatientPrescriptionItem,
      other,
    );
  }

  @override
  int get hashCode {
    return PatientPrescriptionItemMapper.ensureInitialized().hashValue(
      this as PatientPrescriptionItem,
    );
  }
}

extension PatientPrescriptionItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientPrescriptionItem, $Out> {
  PatientPrescriptionItemCopyWith<$R, PatientPrescriptionItem, $Out>
  get $asPatientPrescriptionItem => $base.as(
    (v, t, t2) => _PatientPrescriptionItemCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PatientPrescriptionItemCopyWith<
  $R,
  $In extends PatientPrescriptionItem,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? collectionId,
    String? collectionName,
    String? id,
    String? patientRecord,
    DateTime? date,
    String? medication,
    String? instructions,
    String? dosage,
    DateTime? created,
    DateTime? updated,
    bool? isDeleted,
  });
  PatientPrescriptionItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PatientPrescriptionItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientPrescriptionItem, $Out>
    implements
        PatientPrescriptionItemCopyWith<$R, PatientPrescriptionItem, $Out> {
  _PatientPrescriptionItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientPrescriptionItem> $mapper =
      PatientPrescriptionItemMapper.ensureInitialized();
  @override
  $R call({
    String? collectionId,
    String? collectionName,
    String? id,
    String? patientRecord,
    DateTime? date,
    Object? medication = $none,
    Object? instructions = $none,
    Object? dosage = $none,
    Object? created = $none,
    Object? updated = $none,
    bool? isDeleted,
  }) => $apply(
    FieldCopyWithData({
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (id != null) #id: id,
      if (patientRecord != null) #patientRecord: patientRecord,
      if (date != null) #date: date,
      if (medication != $none) #medication: medication,
      if (instructions != $none) #instructions: instructions,
      if (dosage != $none) #dosage: dosage,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
      if (isDeleted != null) #isDeleted: isDeleted,
    }),
  );
  @override
  PatientPrescriptionItem $make(CopyWithData data) => PatientPrescriptionItem(
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    id: data.get(#id, or: $value.id),
    patientRecord: data.get(#patientRecord, or: $value.patientRecord),
    date: data.get(#date, or: $value.date),
    medication: data.get(#medication, or: $value.medication),
    instructions: data.get(#instructions, or: $value.instructions),
    dosage: data.get(#dosage, or: $value.dosage),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
  );

  @override
  PatientPrescriptionItemCopyWith<$R2, PatientPrescriptionItem, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PatientPrescriptionItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

