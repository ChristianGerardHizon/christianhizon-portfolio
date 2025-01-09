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
  static List<String> _$images(Patient v) => v.images;
  static const Field<Patient, List<String>> _f$images =
      Field('images', _$images, opt: true, def: const []);
  static String? _$parent(Patient v) => v.parent;
  static const Field<Patient, String> _f$parent =
      Field('parent', _$parent, opt: true);
  static String? _$contactNumber(Patient v) => v.contactNumber;
  static const Field<Patient, String> _f$contactNumber =
      Field('contactNumber', _$contactNumber, opt: true);
  static String? _$email(Patient v) => v.email;
  static const Field<Patient, String> _f$email =
      Field('email', _$email, opt: true);
  static String? _$address(Patient v) => v.address;
  static const Field<Patient, String> _f$address =
      Field('address', _$address, opt: true);
  static DateTime _$created(Patient v) => v.created;
  static const Field<Patient, DateTime> _f$created =
      Field('created', _$created);
  static DateTime _$updated(Patient v) => v.updated;
  static const Field<Patient, DateTime> _f$updated =
      Field('updated', _$updated);

  @override
  final MappableFields<Patient> fields = const {
    #id: _f$id,
    #name: _f$name,
    #images: _f$images,
    #parent: _f$parent,
    #contactNumber: _f$contactNumber,
    #email: _f$email,
    #address: _f$address,
    #created: _f$created,
    #updated: _f$updated,
  };

  static Patient _instantiate(DecodingData data) {
    return Patient(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        images: data.dec(_f$images),
        parent: data.dec(_f$parent),
        contactNumber: data.dec(_f$contactNumber),
        email: data.dec(_f$email),
        address: data.dec(_f$address),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
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
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get images;
  $R call(
      {String? id,
      String? name,
      List<String>? images,
      String? parent,
      String? contactNumber,
      String? email,
      String? address,
      DateTime? created,
      DateTime? updated});
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
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get images =>
      ListCopyWith($value.images, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(images: v));
  @override
  $R call(
          {String? id,
          String? name,
          List<String>? images,
          Object? parent = $none,
          Object? contactNumber = $none,
          Object? email = $none,
          Object? address = $none,
          DateTime? created,
          DateTime? updated}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (images != null) #images: images,
        if (parent != $none) #parent: parent,
        if (contactNumber != $none) #contactNumber: contactNumber,
        if (email != $none) #email: email,
        if (address != $none) #address: address,
        if (created != null) #created: created,
        if (updated != null) #updated: updated
      }));
  @override
  Patient $make(CopyWithData data) => Patient(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      images: data.get(#images, or: $value.images),
      parent: data.get(#parent, or: $value.parent),
      contactNumber: data.get(#contactNumber, or: $value.contactNumber),
      email: data.get(#email, or: $value.email),
      address: data.get(#address, or: $value.address),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  PatientCopyWith<$R2, Patient, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PatientCopyWithImpl($value, $cast, t);
}
