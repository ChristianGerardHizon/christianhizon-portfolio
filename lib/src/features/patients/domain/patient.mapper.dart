// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient.dart';

class PatientMapper extends ClassMapperBase<Patient> {
  PatientMapper._();

  static PatientMapper? _instance;
  static PatientMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Patient';

  static String _$id(Patient v) => v.id;
  static const Field<Patient, String> _f$id = Field('id', _$id);
  static String _$name(Patient v) => v.name;
  static const Field<Patient, String> _f$name =
      Field('name', _$name, opt: true, def: '');

  @override
  final MappableFields<Patient> fields = const {
    #id: _f$id,
    #name: _f$name,
  };

  static Patient _instantiate(DecodingData data) {
    return Patient(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static Patient fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Patient>(map);
  }

  static Patient fromJson(String json) {
    return ensureInitialized().decodeJson<Patient>(json);
  }
}

mixin PatientMappable {
  String toJson() {
    return PatientMapper.ensureInitialized()
        .encodeJson<Patient>(this as Patient);
  }

  Map<String, dynamic> toMap() {
    return PatientMapper.ensureInitialized()
        .encodeMap<Patient>(this as Patient);
  }

  PatientCopyWith<Patient, Patient, Patient> get copyWith =>
      _PatientCopyWithImpl(this as Patient, $identity, $identity);
  @override
  String toString() {
    return PatientMapper.ensureInitialized().stringifyValue(this as Patient);
  }

  @override
  bool operator ==(Object other) {
    return PatientMapper.ensureInitialized()
        .equalsValue(this as Patient, other);
  }

  @override
  int get hashCode {
    return PatientMapper.ensureInitialized().hashValue(this as Patient);
  }
}

extension PatientValueCopy<$R, $Out> on ObjectCopyWith<$R, Patient, $Out> {
  PatientCopyWith<$R, Patient, $Out> get $asPatient =>
      $base.as((v, t, t2) => _PatientCopyWithImpl(v, t, t2));
}

abstract class PatientCopyWith<$R, $In extends Patient, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name});
  PatientCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PatientCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Patient, $Out>
    implements PatientCopyWith<$R, Patient, $Out> {
  _PatientCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Patient> $mapper =
      PatientMapper.ensureInitialized();
  @override
  $R call({String? id, String? name}) => $apply(FieldCopyWithData(
      {if (id != null) #id: id, if (name != null) #name: name}));
  @override
  Patient $make(CopyWithData data) => Patient(
      id: data.get(#id, or: $value.id), name: data.get(#name, or: $value.name));

  @override
  PatientCopyWith<$R2, Patient, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PatientCopyWithImpl($value, $cast, t);
}
