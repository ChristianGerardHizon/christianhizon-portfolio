// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'history.dart';

class HistoryMapper extends ClassMapperBase<History> {
  HistoryMapper._();

  static HistoryMapper? _instance;
  static HistoryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HistoryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'History';

  static String _$id(History v) => v.id;
  static const Field<History, String> _f$id = Field('id', _$id);
  static String _$type(History v) => v.type;
  static const Field<History, String> _f$type = Field('type', _$type);
  static String _$patient(History v) => v.patient;
  static const Field<History, String> _f$patient = Field('patient', _$patient);
  static DateTime? _$created(History v) => v.created;
  static const Field<History, DateTime> _f$created =
      Field('created', _$created);
  static DateTime? _$updated(History v) => v.updated;
  static const Field<History, DateTime> _f$updated =
      Field('updated', _$updated);

  @override
  final MappableFields<History> fields = const {
    #id: _f$id,
    #type: _f$type,
    #patient: _f$patient,
    #created: _f$created,
    #updated: _f$updated,
  };

  static History _instantiate(DecodingData data) {
    return History(
        id: data.dec(_f$id),
        type: data.dec(_f$type),
        patient: data.dec(_f$patient),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static History fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<History>(map);
  }

  static History fromJson(String json) {
    return ensureInitialized().decodeJson<History>(json);
  }
}

mixin HistoryMappable {
  String toJson() {
    return HistoryMapper.ensureInitialized()
        .encodeJson<History>(this as History);
  }

  Map<String, dynamic> toMap() {
    return HistoryMapper.ensureInitialized()
        .encodeMap<History>(this as History);
  }

  HistoryCopyWith<History, History, History> get copyWith =>
      _HistoryCopyWithImpl(this as History, $identity, $identity);
  @override
  String toString() {
    return HistoryMapper.ensureInitialized().stringifyValue(this as History);
  }

  @override
  bool operator ==(Object other) {
    return HistoryMapper.ensureInitialized()
        .equalsValue(this as History, other);
  }

  @override
  int get hashCode {
    return HistoryMapper.ensureInitialized().hashValue(this as History);
  }
}

extension HistoryValueCopy<$R, $Out> on ObjectCopyWith<$R, History, $Out> {
  HistoryCopyWith<$R, History, $Out> get $asHistory =>
      $base.as((v, t, t2) => _HistoryCopyWithImpl(v, t, t2));
}

abstract class HistoryCopyWith<$R, $In extends History, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? type,
      String? patient,
      DateTime? created,
      DateTime? updated});
  HistoryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HistoryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, History, $Out>
    implements HistoryCopyWith<$R, History, $Out> {
  _HistoryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<History> $mapper =
      HistoryMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? type,
          String? patient,
          Object? created = $none,
          Object? updated = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (type != null) #type: type,
        if (patient != null) #patient: patient,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated
      }));
  @override
  History $make(CopyWithData data) => History(
      id: data.get(#id, or: $value.id),
      type: data.get(#type, or: $value.type),
      patient: data.get(#patient, or: $value.patient),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  HistoryCopyWith<$R2, History, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _HistoryCopyWithImpl($value, $cast, t);
}
