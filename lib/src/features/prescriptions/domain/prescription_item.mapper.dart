// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'prescription_item.dart';

class PrescriptionItemMapper extends ClassMapperBase<PrescriptionItem> {
  PrescriptionItemMapper._();

  static PrescriptionItemMapper? _instance;
  static PrescriptionItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PrescriptionItemMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PrescriptionItem';

  static String _$id(PrescriptionItem v) => v.id;
  static const Field<PrescriptionItem, String> _f$id = Field('id', _$id);
  static String _$medicalRecord(PrescriptionItem v) => v.medicalRecord;
  static const Field<PrescriptionItem, String> _f$medicalRecord =
      Field('medicalRecord', _$medicalRecord);
  static String? _$medication(PrescriptionItem v) => v.medication;
  static const Field<PrescriptionItem, String> _f$medication =
      Field('medication', _$medication, opt: true, def: '');
  static String? _$instructions(PrescriptionItem v) => v.instructions;
  static const Field<PrescriptionItem, String> _f$instructions =
      Field('instructions', _$instructions, opt: true);
  static DateTime? _$created(PrescriptionItem v) => v.created;
  static const Field<PrescriptionItem, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(PrescriptionItem v) => v.updated;
  static const Field<PrescriptionItem, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);
  static bool _$isDeleted(PrescriptionItem v) => v.isDeleted;
  static const Field<PrescriptionItem, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);

  @override
  final MappableFields<PrescriptionItem> fields = const {
    #id: _f$id,
    #medicalRecord: _f$medicalRecord,
    #medication: _f$medication,
    #instructions: _f$instructions,
    #created: _f$created,
    #updated: _f$updated,
    #isDeleted: _f$isDeleted,
  };

  static PrescriptionItem _instantiate(DecodingData data) {
    return PrescriptionItem(
        id: data.dec(_f$id),
        medicalRecord: data.dec(_f$medicalRecord),
        medication: data.dec(_f$medication),
        instructions: data.dec(_f$instructions),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated),
        isDeleted: data.dec(_f$isDeleted));
  }

  @override
  final Function instantiate = _instantiate;

  static PrescriptionItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PrescriptionItem>(map);
  }

  static PrescriptionItem fromJson(String json) {
    return ensureInitialized().decodeJson<PrescriptionItem>(json);
  }
}

mixin PrescriptionItemMappable {
  String toJson() {
    return PrescriptionItemMapper.ensureInitialized()
        .encodeJson<PrescriptionItem>(this as PrescriptionItem);
  }

  Map<String, dynamic> toMap() {
    return PrescriptionItemMapper.ensureInitialized()
        .encodeMap<PrescriptionItem>(this as PrescriptionItem);
  }

  PrescriptionItemCopyWith<PrescriptionItem, PrescriptionItem, PrescriptionItem>
      get copyWith => _PrescriptionItemCopyWithImpl(
          this as PrescriptionItem, $identity, $identity);
  @override
  String toString() {
    return PrescriptionItemMapper.ensureInitialized()
        .stringifyValue(this as PrescriptionItem);
  }

  @override
  bool operator ==(Object other) {
    return PrescriptionItemMapper.ensureInitialized()
        .equalsValue(this as PrescriptionItem, other);
  }

  @override
  int get hashCode {
    return PrescriptionItemMapper.ensureInitialized()
        .hashValue(this as PrescriptionItem);
  }
}

extension PrescriptionItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PrescriptionItem, $Out> {
  PrescriptionItemCopyWith<$R, PrescriptionItem, $Out>
      get $asPrescriptionItem =>
          $base.as((v, t, t2) => _PrescriptionItemCopyWithImpl(v, t, t2));
}

abstract class PrescriptionItemCopyWith<$R, $In extends PrescriptionItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? medicalRecord,
      String? medication,
      String? instructions,
      DateTime? created,
      DateTime? updated,
      bool? isDeleted});
  PrescriptionItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PrescriptionItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PrescriptionItem, $Out>
    implements PrescriptionItemCopyWith<$R, PrescriptionItem, $Out> {
  _PrescriptionItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PrescriptionItem> $mapper =
      PrescriptionItemMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? medicalRecord,
          Object? medication = $none,
          Object? instructions = $none,
          Object? created = $none,
          Object? updated = $none,
          bool? isDeleted}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (medicalRecord != null) #medicalRecord: medicalRecord,
        if (medication != $none) #medication: medication,
        if (instructions != $none) #instructions: instructions,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated,
        if (isDeleted != null) #isDeleted: isDeleted
      }));
  @override
  PrescriptionItem $make(CopyWithData data) => PrescriptionItem(
      id: data.get(#id, or: $value.id),
      medicalRecord: data.get(#medicalRecord, or: $value.medicalRecord),
      medication: data.get(#medication, or: $value.medication),
      instructions: data.get(#instructions, or: $value.instructions),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted));

  @override
  PrescriptionItemCopyWith<$R2, PrescriptionItem, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PrescriptionItemCopyWithImpl($value, $cast, t);
}
