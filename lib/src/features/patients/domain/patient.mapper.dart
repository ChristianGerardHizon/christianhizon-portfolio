// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient.dart';

class PatientSexMapper extends EnumMapper<PatientSex> {
  PatientSexMapper._();

  static PatientSexMapper? _instance;
  static PatientSexMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientSexMapper._());
    }
    return _instance!;
  }

  static PatientSex fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  PatientSex decode(dynamic value) {
    switch (value) {
      case r'male':
        return PatientSex.male;
      case r'female':
        return PatientSex.female;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(PatientSex self) {
    switch (self) {
      case PatientSex.male:
        return r'male';
      case PatientSex.female:
        return r'female';
    }
  }
}

extension PatientSexMapperExtension on PatientSex {
  String toValue() {
    PatientSexMapper.ensureInitialized();
    return MapperContainer.globals.toValue<PatientSex>(this) as String;
  }
}

class PatientMapper extends ClassMapperBase<Patient> {
  PatientMapper._();

  static PatientMapper? _instance;
  static PatientMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientMapper._());
      PatientSexMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Patient';

  static String _$id(Patient v) => v.id;
  static const Field<Patient, String> _f$id = Field('id', _$id);
  static String _$name(Patient v) => v.name;
  static const Field<Patient, String> _f$name = Field('name', _$name);
  static String? _$species(Patient v) => v.species;
  static const Field<Patient, String> _f$species = Field(
    'species',
    _$species,
    opt: true,
  );
  static String? _$speciesId(Patient v) => v.speciesId;
  static const Field<Patient, String> _f$speciesId = Field(
    'speciesId',
    _$speciesId,
    opt: true,
  );
  static String? _$breed(Patient v) => v.breed;
  static const Field<Patient, String> _f$breed = Field(
    'breed',
    _$breed,
    opt: true,
  );
  static String? _$breedId(Patient v) => v.breedId;
  static const Field<Patient, String> _f$breedId = Field(
    'breedId',
    _$breedId,
    opt: true,
  );
  static String? _$owner(Patient v) => v.owner;
  static const Field<Patient, String> _f$owner = Field(
    'owner',
    _$owner,
    opt: true,
  );
  static String? _$contactNumber(Patient v) => v.contactNumber;
  static const Field<Patient, String> _f$contactNumber = Field(
    'contactNumber',
    _$contactNumber,
    opt: true,
  );
  static String? _$email(Patient v) => v.email;
  static const Field<Patient, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
  );
  static String? _$address(Patient v) => v.address;
  static const Field<Patient, String> _f$address = Field(
    'address',
    _$address,
    opt: true,
  );
  static String? _$color(Patient v) => v.color;
  static const Field<Patient, String> _f$color = Field(
    'color',
    _$color,
    opt: true,
  );
  static PatientSex? _$sex(Patient v) => v.sex;
  static const Field<Patient, PatientSex> _f$sex = Field(
    'sex',
    _$sex,
    opt: true,
  );
  static String? _$branch(Patient v) => v.branch;
  static const Field<Patient, String> _f$branch = Field(
    'branch',
    _$branch,
    opt: true,
  );
  static DateTime? _$dateOfBirth(Patient v) => v.dateOfBirth;
  static const Field<Patient, DateTime> _f$dateOfBirth = Field(
    'dateOfBirth',
    _$dateOfBirth,
    opt: true,
  );
  static String? _$avatar(Patient v) => v.avatar;
  static const Field<Patient, String> _f$avatar = Field(
    'avatar',
    _$avatar,
    opt: true,
  );
  static List<String> _$images(Patient v) => v.images;
  static const Field<Patient, List<String>> _f$images = Field(
    'images',
    _$images,
    opt: true,
    def: const [],
  );
  static bool _$isDeleted(Patient v) => v.isDeleted;
  static const Field<Patient, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static DateTime? _$created(Patient v) => v.created;
  static const Field<Patient, DateTime> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static DateTime? _$updated(Patient v) => v.updated;
  static const Field<Patient, DateTime> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );

  @override
  final MappableFields<Patient> fields = const {
    #id: _f$id,
    #name: _f$name,
    #species: _f$species,
    #speciesId: _f$speciesId,
    #breed: _f$breed,
    #breedId: _f$breedId,
    #owner: _f$owner,
    #contactNumber: _f$contactNumber,
    #email: _f$email,
    #address: _f$address,
    #color: _f$color,
    #sex: _f$sex,
    #branch: _f$branch,
    #dateOfBirth: _f$dateOfBirth,
    #avatar: _f$avatar,
    #images: _f$images,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static Patient _instantiate(DecodingData data) {
    return Patient(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      species: data.dec(_f$species),
      speciesId: data.dec(_f$speciesId),
      breed: data.dec(_f$breed),
      breedId: data.dec(_f$breedId),
      owner: data.dec(_f$owner),
      contactNumber: data.dec(_f$contactNumber),
      email: data.dec(_f$email),
      address: data.dec(_f$address),
      color: data.dec(_f$color),
      sex: data.dec(_f$sex),
      branch: data.dec(_f$branch),
      dateOfBirth: data.dec(_f$dateOfBirth),
      avatar: data.dec(_f$avatar),
      images: data.dec(_f$images),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
    );
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
    return PatientMapper.ensureInitialized().encodeJson<Patient>(
      this as Patient,
    );
  }

  Map<String, dynamic> toMap() {
    return PatientMapper.ensureInitialized().encodeMap<Patient>(
      this as Patient,
    );
  }

  PatientCopyWith<Patient, Patient, Patient> get copyWith =>
      _PatientCopyWithImpl<Patient, Patient>(
        this as Patient,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PatientMapper.ensureInitialized().stringifyValue(this as Patient);
  }

  @override
  bool operator ==(Object other) {
    return PatientMapper.ensureInitialized().equalsValue(
      this as Patient,
      other,
    );
  }

  @override
  int get hashCode {
    return PatientMapper.ensureInitialized().hashValue(this as Patient);
  }
}

extension PatientValueCopy<$R, $Out> on ObjectCopyWith<$R, Patient, $Out> {
  PatientCopyWith<$R, Patient, $Out> get $asPatient =>
      $base.as((v, t, t2) => _PatientCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientCopyWith<$R, $In extends Patient, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get images;
  $R call({
    String? id,
    String? name,
    String? species,
    String? speciesId,
    String? breed,
    String? breedId,
    String? owner,
    String? contactNumber,
    String? email,
    String? address,
    String? color,
    PatientSex? sex,
    String? branch,
    DateTime? dateOfBirth,
    String? avatar,
    List<String>? images,
    bool? isDeleted,
    DateTime? created,
    DateTime? updated,
  });
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
      ListCopyWith(
        $value.images,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(images: v),
      );
  @override
  $R call({
    String? id,
    String? name,
    Object? species = $none,
    Object? speciesId = $none,
    Object? breed = $none,
    Object? breedId = $none,
    Object? owner = $none,
    Object? contactNumber = $none,
    Object? email = $none,
    Object? address = $none,
    Object? color = $none,
    Object? sex = $none,
    Object? branch = $none,
    Object? dateOfBirth = $none,
    Object? avatar = $none,
    List<String>? images,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (species != $none) #species: species,
      if (speciesId != $none) #speciesId: speciesId,
      if (breed != $none) #breed: breed,
      if (breedId != $none) #breedId: breedId,
      if (owner != $none) #owner: owner,
      if (contactNumber != $none) #contactNumber: contactNumber,
      if (email != $none) #email: email,
      if (address != $none) #address: address,
      if (color != $none) #color: color,
      if (sex != $none) #sex: sex,
      if (branch != $none) #branch: branch,
      if (dateOfBirth != $none) #dateOfBirth: dateOfBirth,
      if (avatar != $none) #avatar: avatar,
      if (images != null) #images: images,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
    }),
  );
  @override
  Patient $make(CopyWithData data) => Patient(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    species: data.get(#species, or: $value.species),
    speciesId: data.get(#speciesId, or: $value.speciesId),
    breed: data.get(#breed, or: $value.breed),
    breedId: data.get(#breedId, or: $value.breedId),
    owner: data.get(#owner, or: $value.owner),
    contactNumber: data.get(#contactNumber, or: $value.contactNumber),
    email: data.get(#email, or: $value.email),
    address: data.get(#address, or: $value.address),
    color: data.get(#color, or: $value.color),
    sex: data.get(#sex, or: $value.sex),
    branch: data.get(#branch, or: $value.branch),
    dateOfBirth: data.get(#dateOfBirth, or: $value.dateOfBirth),
    avatar: data.get(#avatar, or: $value.avatar),
    images: data.get(#images, or: $value.images),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
  );

  @override
  PatientCopyWith<$R2, Patient, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PatientCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

