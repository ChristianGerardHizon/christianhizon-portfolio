// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_search.dart';

class PatientSearchMapper extends ClassMapperBase<PatientSearch> {
  PatientSearchMapper._();

  static PatientSearchMapper? _instance;
  static PatientSearchMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientSearchMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PatientSearch';

  static String? _$id(PatientSearch v) => v.id;
  static const Field<PatientSearch, String> _f$id =
      Field('id', _$id, opt: true);
  static String? _$name(PatientSearch v) => v.name;
  static const Field<PatientSearch, String> _f$name =
      Field('name', _$name, opt: true);

  @override
  final MappableFields<PatientSearch> fields = const {
    #id: _f$id,
    #name: _f$name,
  };

  static PatientSearch _instantiate(DecodingData data) {
    return PatientSearch(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static PatientSearch fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientSearch>(map);
  }

  static PatientSearch fromJson(String json) {
    return ensureInitialized().decodeJson<PatientSearch>(json);
  }
}

mixin PatientSearchMappable {
  String toJson() {
    return PatientSearchMapper.ensureInitialized()
        .encodeJson<PatientSearch>(this as PatientSearch);
  }

  Map<String, dynamic> toMap() {
    return PatientSearchMapper.ensureInitialized()
        .encodeMap<PatientSearch>(this as PatientSearch);
  }

  PatientSearchCopyWith<PatientSearch, PatientSearch, PatientSearch>
      get copyWith => _PatientSearchCopyWithImpl<PatientSearch, PatientSearch>(
          this as PatientSearch, $identity, $identity);
  @override
  String toString() {
    return PatientSearchMapper.ensureInitialized()
        .stringifyValue(this as PatientSearch);
  }

  @override
  bool operator ==(Object other) {
    return PatientSearchMapper.ensureInitialized()
        .equalsValue(this as PatientSearch, other);
  }

  @override
  int get hashCode {
    return PatientSearchMapper.ensureInitialized()
        .hashValue(this as PatientSearch);
  }
}

extension PatientSearchValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientSearch, $Out> {
  PatientSearchCopyWith<$R, PatientSearch, $Out> get $asPatientSearch =>
      $base.as((v, t, t2) => _PatientSearchCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientSearchCopyWith<$R, $In extends PatientSearch, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name});
  PatientSearchCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PatientSearchCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientSearch, $Out>
    implements PatientSearchCopyWith<$R, PatientSearch, $Out> {
  _PatientSearchCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientSearch> $mapper =
      PatientSearchMapper.ensureInitialized();
  @override
  $R call({Object? id = $none, Object? name = $none}) =>
      $apply(FieldCopyWithData(
          {if (id != $none) #id: id, if (name != $none) #name: name}));
  @override
  PatientSearch $make(CopyWithData data) => PatientSearch(
      id: data.get(#id, or: $value.id), name: data.get(#name, or: $value.name));

  @override
  PatientSearchCopyWith<$R2, PatientSearch, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PatientSearchCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
