// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'medical_prescription_item.dart';

class MedicalPrescriptionItemMapper
    extends ClassMapperBase<MedicalPrescriptionItem> {
  MedicalPrescriptionItemMapper._();

  static MedicalPrescriptionItemMapper? _instance;
  static MedicalPrescriptionItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = MedicalPrescriptionItemMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MedicalPrescriptionItem';

  static String? _$note(MedicalPrescriptionItem v) => v.note;
  static const Field<MedicalPrescriptionItem, String> _f$note =
      Field('note', _$note, opt: true);
  static String? _$dosage(MedicalPrescriptionItem v) => v.dosage;
  static const Field<MedicalPrescriptionItem, String> _f$dosage =
      Field('dosage', _$dosage, opt: true);
  static String? _$medication(MedicalPrescriptionItem v) => v.medication;
  static const Field<MedicalPrescriptionItem, String> _f$medication =
      Field('medication', _$medication, opt: true);

  @override
  final MappableFields<MedicalPrescriptionItem> fields = const {
    #note: _f$note,
    #dosage: _f$dosage,
    #medication: _f$medication,
  };

  static MedicalPrescriptionItem _instantiate(DecodingData data) {
    return MedicalPrescriptionItem(
        note: data.dec(_f$note),
        dosage: data.dec(_f$dosage),
        medication: data.dec(_f$medication));
  }

  @override
  final Function instantiate = _instantiate;

  static MedicalPrescriptionItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MedicalPrescriptionItem>(map);
  }

  static MedicalPrescriptionItem fromJson(String json) {
    return ensureInitialized().decodeJson<MedicalPrescriptionItem>(json);
  }
}

mixin MedicalPrescriptionItemMappable {
  String toJson() {
    return MedicalPrescriptionItemMapper.ensureInitialized()
        .encodeJson<MedicalPrescriptionItem>(this as MedicalPrescriptionItem);
  }

  Map<String, dynamic> toMap() {
    return MedicalPrescriptionItemMapper.ensureInitialized()
        .encodeMap<MedicalPrescriptionItem>(this as MedicalPrescriptionItem);
  }

  MedicalPrescriptionItemCopyWith<MedicalPrescriptionItem,
          MedicalPrescriptionItem, MedicalPrescriptionItem>
      get copyWith => _MedicalPrescriptionItemCopyWithImpl(
          this as MedicalPrescriptionItem, $identity, $identity);
  @override
  String toString() {
    return MedicalPrescriptionItemMapper.ensureInitialized()
        .stringifyValue(this as MedicalPrescriptionItem);
  }

  @override
  bool operator ==(Object other) {
    return MedicalPrescriptionItemMapper.ensureInitialized()
        .equalsValue(this as MedicalPrescriptionItem, other);
  }

  @override
  int get hashCode {
    return MedicalPrescriptionItemMapper.ensureInitialized()
        .hashValue(this as MedicalPrescriptionItem);
  }
}

extension MedicalPrescriptionItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MedicalPrescriptionItem, $Out> {
  MedicalPrescriptionItemCopyWith<$R, MedicalPrescriptionItem, $Out>
      get $asMedicalPrescriptionItem => $base
          .as((v, t, t2) => _MedicalPrescriptionItemCopyWithImpl(v, t, t2));
}

abstract class MedicalPrescriptionItemCopyWith<
    $R,
    $In extends MedicalPrescriptionItem,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? note, String? dosage, String? medication});
  MedicalPrescriptionItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _MedicalPrescriptionItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MedicalPrescriptionItem, $Out>
    implements
        MedicalPrescriptionItemCopyWith<$R, MedicalPrescriptionItem, $Out> {
  _MedicalPrescriptionItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MedicalPrescriptionItem> $mapper =
      MedicalPrescriptionItemMapper.ensureInitialized();
  @override
  $R call(
          {Object? note = $none,
          Object? dosage = $none,
          Object? medication = $none}) =>
      $apply(FieldCopyWithData({
        if (note != $none) #note: note,
        if (dosage != $none) #dosage: dosage,
        if (medication != $none) #medication: medication
      }));
  @override
  MedicalPrescriptionItem $make(CopyWithData data) => MedicalPrescriptionItem(
      note: data.get(#note, or: $value.note),
      dosage: data.get(#dosage, or: $value.dosage),
      medication: data.get(#medication, or: $value.medication));

  @override
  MedicalPrescriptionItemCopyWith<$R2, MedicalPrescriptionItem, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _MedicalPrescriptionItemCopyWithImpl($value, $cast, t);
}
