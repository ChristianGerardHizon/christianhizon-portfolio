// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'prescription.dart';

class PrescriptionMapper extends ClassMapperBase<Prescription> {
  PrescriptionMapper._();

  static PrescriptionMapper? _instance;
  static PrescriptionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PrescriptionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Prescription';

  static String _$id(Prescription v) => v.id;
  static const Field<Prescription, String> _f$id = Field('id', _$id);
  static String _$recordId(Prescription v) => v.recordId;
  static const Field<Prescription, String> _f$recordId = Field(
    'recordId',
    _$recordId,
  );
  static String _$medication(Prescription v) => v.medication;
  static const Field<Prescription, String> _f$medication = Field(
    'medication',
    _$medication,
  );
  static String? _$dosage(Prescription v) => v.dosage;
  static const Field<Prescription, String> _f$dosage = Field(
    'dosage',
    _$dosage,
    opt: true,
  );
  static String? _$instructions(Prescription v) => v.instructions;
  static const Field<Prescription, String> _f$instructions = Field(
    'instructions',
    _$instructions,
    opt: true,
  );
  static DateTime? _$date(Prescription v) => v.date;
  static const Field<Prescription, DateTime> _f$date = Field(
    'date',
    _$date,
    opt: true,
  );
  static bool _$isDeleted(Prescription v) => v.isDeleted;
  static const Field<Prescription, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static DateTime? _$created(Prescription v) => v.created;
  static const Field<Prescription, DateTime> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static DateTime? _$updated(Prescription v) => v.updated;
  static const Field<Prescription, DateTime> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );

  @override
  final MappableFields<Prescription> fields = const {
    #id: _f$id,
    #recordId: _f$recordId,
    #medication: _f$medication,
    #dosage: _f$dosage,
    #instructions: _f$instructions,
    #date: _f$date,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static Prescription _instantiate(DecodingData data) {
    return Prescription(
      id: data.dec(_f$id),
      recordId: data.dec(_f$recordId),
      medication: data.dec(_f$medication),
      dosage: data.dec(_f$dosage),
      instructions: data.dec(_f$instructions),
      date: data.dec(_f$date),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Prescription fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Prescription>(map);
  }

  static Prescription fromJson(String json) {
    return ensureInitialized().decodeJson<Prescription>(json);
  }
}

mixin PrescriptionMappable {
  String toJson() {
    return PrescriptionMapper.ensureInitialized().encodeJson<Prescription>(
      this as Prescription,
    );
  }

  Map<String, dynamic> toMap() {
    return PrescriptionMapper.ensureInitialized().encodeMap<Prescription>(
      this as Prescription,
    );
  }

  PrescriptionCopyWith<Prescription, Prescription, Prescription> get copyWith =>
      _PrescriptionCopyWithImpl<Prescription, Prescription>(
        this as Prescription,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PrescriptionMapper.ensureInitialized().stringifyValue(
      this as Prescription,
    );
  }

  @override
  bool operator ==(Object other) {
    return PrescriptionMapper.ensureInitialized().equalsValue(
      this as Prescription,
      other,
    );
  }

  @override
  int get hashCode {
    return PrescriptionMapper.ensureInitialized().hashValue(
      this as Prescription,
    );
  }
}

extension PrescriptionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Prescription, $Out> {
  PrescriptionCopyWith<$R, Prescription, $Out> get $asPrescription =>
      $base.as((v, t, t2) => _PrescriptionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PrescriptionCopyWith<$R, $In extends Prescription, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? recordId,
    String? medication,
    String? dosage,
    String? instructions,
    DateTime? date,
    bool? isDeleted,
    DateTime? created,
    DateTime? updated,
  });
  PrescriptionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PrescriptionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Prescription, $Out>
    implements PrescriptionCopyWith<$R, Prescription, $Out> {
  _PrescriptionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Prescription> $mapper =
      PrescriptionMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? recordId,
    String? medication,
    Object? dosage = $none,
    Object? instructions = $none,
    Object? date = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (recordId != null) #recordId: recordId,
      if (medication != null) #medication: medication,
      if (dosage != $none) #dosage: dosage,
      if (instructions != $none) #instructions: instructions,
      if (date != $none) #date: date,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
    }),
  );
  @override
  Prescription $make(CopyWithData data) => Prescription(
    id: data.get(#id, or: $value.id),
    recordId: data.get(#recordId, or: $value.recordId),
    medication: data.get(#medication, or: $value.medication),
    dosage: data.get(#dosage, or: $value.dosage),
    instructions: data.get(#instructions, or: $value.instructions),
    date: data.get(#date, or: $value.date),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
  );

  @override
  PrescriptionCopyWith<$R2, Prescription, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PrescriptionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

