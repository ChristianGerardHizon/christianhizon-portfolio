// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
      PbRecordMapper.ensureInitialized();
      PatientSexMapper.ensureInitialized();
      PatientRecordExpandMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Patient';

  static String _$id(Patient v) => v.id;
  static const Field<Patient, String> _f$id = Field('id', _$id);
  static String _$collectionId(Patient v) => v.collectionId;
  static const Field<Patient, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(Patient v) => v.collectionName;
  static const Field<Patient, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static String _$name(Patient v) => v.name;
  static const Field<Patient, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static List<String> _$images(Patient v) => v.images;
  static const Field<Patient, List<String>> _f$images =
      Field('images', _$images, opt: true, def: const []);
  static String? _$avatar(Patient v) => v.avatar;
  static const Field<Patient, String> _f$avatar =
      Field('avatar', _$avatar, opt: true, hook: PbEmptyHook());
  static String? _$species(Patient v) => v.species;
  static const Field<Patient, String> _f$species =
      Field('species', _$species, opt: true, hook: PbEmptyHook());
  static String? _$branch(Patient v) => v.branch;
  static const Field<Patient, String> _f$branch =
      Field('branch', _$branch, opt: true, hook: PbEmptyHook());
  static String? _$owner(Patient v) => v.owner;
  static const Field<Patient, String> _f$owner =
      Field('owner', _$owner, opt: true);
  static String? _$contactNumber(Patient v) => v.contactNumber;
  static const Field<Patient, String> _f$contactNumber =
      Field('contactNumber', _$contactNumber, opt: true);
  static String? _$email(Patient v) => v.email;
  static const Field<Patient, String> _f$email =
      Field('email', _$email, opt: true);
  static String? _$address(Patient v) => v.address;
  static const Field<Patient, String> _f$address =
      Field('address', _$address, opt: true);
  static String? _$breed(Patient v) => v.breed;
  static const Field<Patient, String> _f$breed =
      Field('breed', _$breed, opt: true);
  static String? _$color(Patient v) => v.color;
  static const Field<Patient, String> _f$color =
      Field('color', _$color, opt: true);
  static PatientSex? _$sex(Patient v) => v.sex;
  static const Field<Patient, PatientSex> _f$sex =
      Field('sex', _$sex, opt: true, hook: PatientSexHook());
  static DateTime? _$dateOfBirth(Patient v) => v.dateOfBirth;
  static const Field<Patient, DateTime> _f$dateOfBirth =
      Field('dateOfBirth', _$dateOfBirth, opt: true, hook: DateTimeHook());
  static PatientRecordExpand _$expand(Patient v) => v.expand;
  static const Field<Patient, PatientRecordExpand> _f$expand =
      Field('expand', _$expand);
  static bool _$isDeleted(Patient v) => v.isDeleted;
  static const Field<Patient, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static DateTime? _$created(Patient v) => v.created;
  static const Field<Patient, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(Patient v) => v.updated;
  static const Field<Patient, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);

  @override
  final MappableFields<Patient> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #name: _f$name,
    #images: _f$images,
    #avatar: _f$avatar,
    #species: _f$species,
    #branch: _f$branch,
    #owner: _f$owner,
    #contactNumber: _f$contactNumber,
    #email: _f$email,
    #address: _f$address,
    #breed: _f$breed,
    #color: _f$color,
    #sex: _f$sex,
    #dateOfBirth: _f$dateOfBirth,
    #expand: _f$expand,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static Patient _instantiate(DecodingData data) {
    return Patient(
        id: data.dec(_f$id),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        name: data.dec(_f$name),
        images: data.dec(_f$images),
        avatar: data.dec(_f$avatar),
        species: data.dec(_f$species),
        branch: data.dec(_f$branch),
        owner: data.dec(_f$owner),
        contactNumber: data.dec(_f$contactNumber),
        email: data.dec(_f$email),
        address: data.dec(_f$address),
        breed: data.dec(_f$breed),
        color: data.dec(_f$color),
        sex: data.dec(_f$sex),
        dateOfBirth: data.dec(_f$dateOfBirth),
        expand: data.dec(_f$expand),
        isDeleted: data.dec(_f$isDeleted),
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
      _PatientCopyWithImpl<Patient, Patient>(
          this as Patient, $identity, $identity);
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
      $base.as((v, t, t2) => _PatientCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientCopyWith<$R, $In extends Patient, $Out>
    implements PbRecordCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get images;
  PatientRecordExpandCopyWith<$R, PatientRecordExpand, PatientRecordExpand>
      get expand;
  @override
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      String? name,
      List<String>? images,
      String? avatar,
      String? species,
      String? branch,
      String? owner,
      String? contactNumber,
      String? email,
      String? address,
      String? breed,
      String? color,
      PatientSex? sex,
      DateTime? dateOfBirth,
      PatientRecordExpand? expand,
      bool? isDeleted,
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
  PatientRecordExpandCopyWith<$R, PatientRecordExpand, PatientRecordExpand>
      get expand => $value.expand.copyWith.$chain((v) => call(expand: v));
  @override
  $R call(
          {String? id,
          String? collectionId,
          String? collectionName,
          String? name,
          List<String>? images,
          Object? avatar = $none,
          Object? species = $none,
          Object? branch = $none,
          Object? owner = $none,
          Object? contactNumber = $none,
          Object? email = $none,
          Object? address = $none,
          Object? breed = $none,
          Object? color = $none,
          Object? sex = $none,
          Object? dateOfBirth = $none,
          PatientRecordExpand? expand,
          bool? isDeleted,
          Object? created = $none,
          Object? updated = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName,
        if (name != null) #name: name,
        if (images != null) #images: images,
        if (avatar != $none) #avatar: avatar,
        if (species != $none) #species: species,
        if (branch != $none) #branch: branch,
        if (owner != $none) #owner: owner,
        if (contactNumber != $none) #contactNumber: contactNumber,
        if (email != $none) #email: email,
        if (address != $none) #address: address,
        if (breed != $none) #breed: breed,
        if (color != $none) #color: color,
        if (sex != $none) #sex: sex,
        if (dateOfBirth != $none) #dateOfBirth: dateOfBirth,
        if (expand != null) #expand: expand,
        if (isDeleted != null) #isDeleted: isDeleted,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated
      }));
  @override
  Patient $make(CopyWithData data) => Patient(
      id: data.get(#id, or: $value.id),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      name: data.get(#name, or: $value.name),
      images: data.get(#images, or: $value.images),
      avatar: data.get(#avatar, or: $value.avatar),
      species: data.get(#species, or: $value.species),
      branch: data.get(#branch, or: $value.branch),
      owner: data.get(#owner, or: $value.owner),
      contactNumber: data.get(#contactNumber, or: $value.contactNumber),
      email: data.get(#email, or: $value.email),
      address: data.get(#address, or: $value.address),
      breed: data.get(#breed, or: $value.breed),
      color: data.get(#color, or: $value.color),
      sex: data.get(#sex, or: $value.sex),
      dateOfBirth: data.get(#dateOfBirth, or: $value.dateOfBirth),
      expand: data.get(#expand, or: $value.expand),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  PatientCopyWith<$R2, Patient, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PatientCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PatientRecordExpandMapper extends ClassMapperBase<PatientRecordExpand> {
  PatientRecordExpandMapper._();

  static PatientRecordExpandMapper? _instance;
  static PatientRecordExpandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientRecordExpandMapper._());
      PatientSpeciesMapper.ensureInitialized();
      PatientBreedMapper.ensureInitialized();
      BranchMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PatientRecordExpand';

  static PatientSpecies? _$species(PatientRecordExpand v) => v.species;
  static const Field<PatientRecordExpand, PatientSpecies> _f$species =
      Field('species', _$species, opt: true);
  static PatientBreed? _$breed(PatientRecordExpand v) => v.breed;
  static const Field<PatientRecordExpand, PatientBreed> _f$breed =
      Field('breed', _$breed, opt: true);
  static Branch? _$branch(PatientRecordExpand v) => v.branch;
  static const Field<PatientRecordExpand, Branch> _f$branch =
      Field('branch', _$branch, opt: true);

  @override
  final MappableFields<PatientRecordExpand> fields = const {
    #species: _f$species,
    #breed: _f$breed,
    #branch: _f$branch,
  };

  static PatientRecordExpand _instantiate(DecodingData data) {
    return PatientRecordExpand(
        species: data.dec(_f$species),
        breed: data.dec(_f$breed),
        branch: data.dec(_f$branch));
  }

  @override
  final Function instantiate = _instantiate;

  static PatientRecordExpand fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientRecordExpand>(map);
  }

  static PatientRecordExpand fromJson(String json) {
    return ensureInitialized().decodeJson<PatientRecordExpand>(json);
  }
}

mixin PatientRecordExpandMappable {
  String toJson() {
    return PatientRecordExpandMapper.ensureInitialized()
        .encodeJson<PatientRecordExpand>(this as PatientRecordExpand);
  }

  Map<String, dynamic> toMap() {
    return PatientRecordExpandMapper.ensureInitialized()
        .encodeMap<PatientRecordExpand>(this as PatientRecordExpand);
  }

  PatientRecordExpandCopyWith<PatientRecordExpand, PatientRecordExpand,
      PatientRecordExpand> get copyWith => _PatientRecordExpandCopyWithImpl<
          PatientRecordExpand, PatientRecordExpand>(
      this as PatientRecordExpand, $identity, $identity);
  @override
  String toString() {
    return PatientRecordExpandMapper.ensureInitialized()
        .stringifyValue(this as PatientRecordExpand);
  }

  @override
  bool operator ==(Object other) {
    return PatientRecordExpandMapper.ensureInitialized()
        .equalsValue(this as PatientRecordExpand, other);
  }

  @override
  int get hashCode {
    return PatientRecordExpandMapper.ensureInitialized()
        .hashValue(this as PatientRecordExpand);
  }
}

extension PatientRecordExpandValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientRecordExpand, $Out> {
  PatientRecordExpandCopyWith<$R, PatientRecordExpand, $Out>
      get $asPatientRecordExpand => $base.as(
          (v, t, t2) => _PatientRecordExpandCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientRecordExpandCopyWith<$R, $In extends PatientRecordExpand,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  PatientSpeciesCopyWith<$R, PatientSpecies, PatientSpecies>? get species;
  PatientBreedCopyWith<$R, PatientBreed, PatientBreed>? get breed;
  BranchCopyWith<$R, Branch, Branch>? get branch;
  $R call({PatientSpecies? species, PatientBreed? breed, Branch? branch});
  PatientRecordExpandCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PatientRecordExpandCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientRecordExpand, $Out>
    implements PatientRecordExpandCopyWith<$R, PatientRecordExpand, $Out> {
  _PatientRecordExpandCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientRecordExpand> $mapper =
      PatientRecordExpandMapper.ensureInitialized();
  @override
  PatientSpeciesCopyWith<$R, PatientSpecies, PatientSpecies>? get species =>
      $value.species?.copyWith.$chain((v) => call(species: v));
  @override
  PatientBreedCopyWith<$R, PatientBreed, PatientBreed>? get breed =>
      $value.breed?.copyWith.$chain((v) => call(breed: v));
  @override
  BranchCopyWith<$R, Branch, Branch>? get branch =>
      $value.branch?.copyWith.$chain((v) => call(branch: v));
  @override
  $R call(
          {Object? species = $none,
          Object? breed = $none,
          Object? branch = $none}) =>
      $apply(FieldCopyWithData({
        if (species != $none) #species: species,
        if (breed != $none) #breed: breed,
        if (branch != $none) #branch: branch
      }));
  @override
  PatientRecordExpand $make(CopyWithData data) => PatientRecordExpand(
      species: data.get(#species, or: $value.species),
      breed: data.get(#breed, or: $value.breed),
      branch: data.get(#branch, or: $value.branch));

  @override
  PatientRecordExpandCopyWith<$R2, PatientRecordExpand, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PatientRecordExpandCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
