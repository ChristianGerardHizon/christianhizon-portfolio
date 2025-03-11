// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'prescription_item_create.dart';

class PrescriptionItemCreateMapper
    extends ClassMapperBase<PrescriptionItemCreate> {
  PrescriptionItemCreateMapper._();

  static PrescriptionItemCreateMapper? _instance;
  static PrescriptionItemCreateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PrescriptionItemCreateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PrescriptionItemCreate';

  static String _$medicalRecord(PrescriptionItemCreate v) => v.medicalRecord;
  static const Field<PrescriptionItemCreate, String> _f$medicalRecord =
      Field('medicalRecord', _$medicalRecord);
  static String? _$medication(PrescriptionItemCreate v) => v.medication;
  static const Field<PrescriptionItemCreate, String> _f$medication =
      Field('medication', _$medication, opt: true);
  static String? _$dosage(PrescriptionItemCreate v) => v.dosage;
  static const Field<PrescriptionItemCreate, String> _f$dosage =
      Field('dosage', _$dosage, opt: true);
  static String? _$instruction(PrescriptionItemCreate v) => v.instruction;
  static const Field<PrescriptionItemCreate, String> _f$instruction =
      Field('instruction', _$instruction, opt: true);

  @override
  final MappableFields<PrescriptionItemCreate> fields = const {
    #medicalRecord: _f$medicalRecord,
    #medication: _f$medication,
    #dosage: _f$dosage,
    #instruction: _f$instruction,
  };

  static PrescriptionItemCreate _instantiate(DecodingData data) {
    return PrescriptionItemCreate(
        medicalRecord: data.dec(_f$medicalRecord),
        medication: data.dec(_f$medication),
        dosage: data.dec(_f$dosage),
        instruction: data.dec(_f$instruction));
  }

  @override
  final Function instantiate = _instantiate;

  static PrescriptionItemCreate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PrescriptionItemCreate>(map);
  }

  static PrescriptionItemCreate fromJson(String json) {
    return ensureInitialized().decodeJson<PrescriptionItemCreate>(json);
  }
}

mixin PrescriptionItemCreateMappable {
  String toJson() {
    return PrescriptionItemCreateMapper.ensureInitialized()
        .encodeJson<PrescriptionItemCreate>(this as PrescriptionItemCreate);
  }

  Map<String, dynamic> toMap() {
    return PrescriptionItemCreateMapper.ensureInitialized()
        .encodeMap<PrescriptionItemCreate>(this as PrescriptionItemCreate);
  }

  PrescriptionItemCreateCopyWith<PrescriptionItemCreate, PrescriptionItemCreate,
          PrescriptionItemCreate>
      get copyWith => _PrescriptionItemCreateCopyWithImpl(
          this as PrescriptionItemCreate, $identity, $identity);
  @override
  String toString() {
    return PrescriptionItemCreateMapper.ensureInitialized()
        .stringifyValue(this as PrescriptionItemCreate);
  }

  @override
  bool operator ==(Object other) {
    return PrescriptionItemCreateMapper.ensureInitialized()
        .equalsValue(this as PrescriptionItemCreate, other);
  }

  @override
  int get hashCode {
    return PrescriptionItemCreateMapper.ensureInitialized()
        .hashValue(this as PrescriptionItemCreate);
  }
}

extension PrescriptionItemCreateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PrescriptionItemCreate, $Out> {
  PrescriptionItemCreateCopyWith<$R, PrescriptionItemCreate, $Out>
      get $asPrescriptionItemCreate =>
          $base.as((v, t, t2) => _PrescriptionItemCreateCopyWithImpl(v, t, t2));
}

abstract class PrescriptionItemCreateCopyWith<
    $R,
    $In extends PrescriptionItemCreate,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? medicalRecord,
      String? medication,
      String? dosage,
      String? instruction});
  PrescriptionItemCreateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PrescriptionItemCreateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PrescriptionItemCreate, $Out>
    implements
        PrescriptionItemCreateCopyWith<$R, PrescriptionItemCreate, $Out> {
  _PrescriptionItemCreateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PrescriptionItemCreate> $mapper =
      PrescriptionItemCreateMapper.ensureInitialized();
  @override
  $R call(
          {String? medicalRecord,
          Object? medication = $none,
          Object? dosage = $none,
          Object? instruction = $none}) =>
      $apply(FieldCopyWithData({
        if (medicalRecord != null) #medicalRecord: medicalRecord,
        if (medication != $none) #medication: medication,
        if (dosage != $none) #dosage: dosage,
        if (instruction != $none) #instruction: instruction
      }));
  @override
  PrescriptionItemCreate $make(CopyWithData data) => PrescriptionItemCreate(
      medicalRecord: data.get(#medicalRecord, or: $value.medicalRecord),
      medication: data.get(#medication, or: $value.medication),
      dosage: data.get(#dosage, or: $value.dosage),
      instruction: data.get(#instruction, or: $value.instruction));

  @override
  PrescriptionItemCreateCopyWith<$R2, PrescriptionItemCreate, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PrescriptionItemCreateCopyWithImpl($value, $cast, t);
}
