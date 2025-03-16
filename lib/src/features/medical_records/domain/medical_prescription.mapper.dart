// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'medical_prescription.dart';

class MedicalPrescriptionMapper extends ClassMapperBase<MedicalPrescription> {
  MedicalPrescriptionMapper._();

  static MedicalPrescriptionMapper? _instance;
  static MedicalPrescriptionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MedicalPrescriptionMapper._());
      MedicalPrescriptionItemMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MedicalPrescription';

  static String? _$note(MedicalPrescription v) => v.note;
  static const Field<MedicalPrescription, String> _f$note =
      Field('note', _$note, opt: true);
  static List<MedicalPrescriptionItem> _$items(MedicalPrescription v) =>
      v.items;
  static const Field<MedicalPrescription, List<MedicalPrescriptionItem>>
      _f$items = Field('items', _$items, opt: true, def: const []);

  @override
  final MappableFields<MedicalPrescription> fields = const {
    #note: _f$note,
    #items: _f$items,
  };

  static MedicalPrescription _instantiate(DecodingData data) {
    return MedicalPrescription(
        note: data.dec(_f$note), items: data.dec(_f$items));
  }

  @override
  final Function instantiate = _instantiate;

  static MedicalPrescription fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MedicalPrescription>(map);
  }

  static MedicalPrescription fromJson(String json) {
    return ensureInitialized().decodeJson<MedicalPrescription>(json);
  }
}

mixin MedicalPrescriptionMappable {
  String toJson() {
    return MedicalPrescriptionMapper.ensureInitialized()
        .encodeJson<MedicalPrescription>(this as MedicalPrescription);
  }

  Map<String, dynamic> toMap() {
    return MedicalPrescriptionMapper.ensureInitialized()
        .encodeMap<MedicalPrescription>(this as MedicalPrescription);
  }

  MedicalPrescriptionCopyWith<MedicalPrescription, MedicalPrescription,
          MedicalPrescription>
      get copyWith => _MedicalPrescriptionCopyWithImpl(
          this as MedicalPrescription, $identity, $identity);
  @override
  String toString() {
    return MedicalPrescriptionMapper.ensureInitialized()
        .stringifyValue(this as MedicalPrescription);
  }

  @override
  bool operator ==(Object other) {
    return MedicalPrescriptionMapper.ensureInitialized()
        .equalsValue(this as MedicalPrescription, other);
  }

  @override
  int get hashCode {
    return MedicalPrescriptionMapper.ensureInitialized()
        .hashValue(this as MedicalPrescription);
  }
}

extension MedicalPrescriptionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MedicalPrescription, $Out> {
  MedicalPrescriptionCopyWith<$R, MedicalPrescription, $Out>
      get $asMedicalPrescription =>
          $base.as((v, t, t2) => _MedicalPrescriptionCopyWithImpl(v, t, t2));
}

abstract class MedicalPrescriptionCopyWith<$R, $In extends MedicalPrescription,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
      $R,
      MedicalPrescriptionItem,
      MedicalPrescriptionItemCopyWith<$R, MedicalPrescriptionItem,
          MedicalPrescriptionItem>> get items;
  $R call({String? note, List<MedicalPrescriptionItem>? items});
  MedicalPrescriptionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _MedicalPrescriptionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MedicalPrescription, $Out>
    implements MedicalPrescriptionCopyWith<$R, MedicalPrescription, $Out> {
  _MedicalPrescriptionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MedicalPrescription> $mapper =
      MedicalPrescriptionMapper.ensureInitialized();
  @override
  ListCopyWith<
      $R,
      MedicalPrescriptionItem,
      MedicalPrescriptionItemCopyWith<$R, MedicalPrescriptionItem,
          MedicalPrescriptionItem>> get items => ListCopyWith(
      $value.items, (v, t) => v.copyWith.$chain(t), (v) => call(items: v));
  @override
  $R call({Object? note = $none, List<MedicalPrescriptionItem>? items}) =>
      $apply(FieldCopyWithData(
          {if (note != $none) #note: note, if (items != null) #items: items}));
  @override
  MedicalPrescription $make(CopyWithData data) => MedicalPrescription(
      note: data.get(#note, or: $value.note),
      items: data.get(#items, or: $value.items));

  @override
  MedicalPrescriptionCopyWith<$R2, MedicalPrescription, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _MedicalPrescriptionCopyWithImpl($value, $cast, t);
}
