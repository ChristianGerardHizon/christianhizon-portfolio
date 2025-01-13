// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pet.dart';

class PetMapper extends ClassMapperBase<Pet> {
  PetMapper._();

  static PetMapper? _instance;
  static PetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PetMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Pet';

  static String _$id(Pet v) => v.id;
  static const Field<Pet, String> _f$id = Field('id', _$id);
  static String _$name(Pet v) => v.name;
  static const Field<Pet, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static List<String> _$images(Pet v) => v.images;
  static const Field<Pet, List<String>> _f$images =
      Field('images', _$images, opt: true, def: const []);
  static String? _$owner(Pet v) => v.owner;
  static const Field<Pet, String> _f$owner = Field('owner', _$owner, opt: true);
  static String? _$displayImage(Pet v) => v.displayImage;
  static const Field<Pet, String> _f$displayImage =
      Field('displayImage', _$displayImage, opt: true);
  static String? _$species(Pet v) => v.species;
  static const Field<Pet, String> _f$species =
      Field('species', _$species, opt: true);
  static String? _$breed(Pet v) => v.breed;
  static const Field<Pet, String> _f$breed = Field('breed', _$breed, opt: true);
  static String? _$sex(Pet v) => v.sex;
  static const Field<Pet, String> _f$sex = Field('sex', _$sex, opt: true);
  static String? _$color(Pet v) => v.color;
  static const Field<Pet, String> _f$color = Field('color', _$color, opt: true);
  static String? _$contactNumber(Pet v) => v.contactNumber;
  static const Field<Pet, String> _f$contactNumber =
      Field('contactNumber', _$contactNumber, opt: true);
  static String? _$email(Pet v) => v.email;
  static const Field<Pet, String> _f$email = Field('email', _$email, opt: true);
  static String? _$address(Pet v) => v.address;
  static const Field<Pet, String> _f$address =
      Field('address', _$address, opt: true);
  static DateTime? _$dateOfBirth(Pet v) => v.dateOfBirth;
  static const Field<Pet, DateTime> _f$dateOfBirth =
      Field('dateOfBirth', _$dateOfBirth, opt: true);
  static DateTime? _$created(Pet v) => v.created;
  static const Field<Pet, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(Pet v) => v.updated;
  static const Field<Pet, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);

  @override
  final MappableFields<Pet> fields = const {
    #id: _f$id,
    #name: _f$name,
    #images: _f$images,
    #owner: _f$owner,
    #displayImage: _f$displayImage,
    #species: _f$species,
    #breed: _f$breed,
    #sex: _f$sex,
    #color: _f$color,
    #contactNumber: _f$contactNumber,
    #email: _f$email,
    #address: _f$address,
    #dateOfBirth: _f$dateOfBirth,
    #created: _f$created,
    #updated: _f$updated,
  };

  static Pet _instantiate(DecodingData data) {
    return Pet(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        images: data.dec(_f$images),
        owner: data.dec(_f$owner),
        displayImage: data.dec(_f$displayImage),
        species: data.dec(_f$species),
        breed: data.dec(_f$breed),
        sex: data.dec(_f$sex),
        color: data.dec(_f$color),
        contactNumber: data.dec(_f$contactNumber),
        email: data.dec(_f$email),
        address: data.dec(_f$address),
        dateOfBirth: data.dec(_f$dateOfBirth),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static Pet fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Pet>(map);
  }

  static Pet fromJson(String json) {
    return ensureInitialized().decodeJson<Pet>(json);
  }
}

mixin PetMappable {
  String toJson() {
    return PetMapper.ensureInitialized().encodeJson<Pet>(this as Pet);
  }

  Map<String, dynamic> toMap() {
    return PetMapper.ensureInitialized().encodeMap<Pet>(this as Pet);
  }

  PetCopyWith<Pet, Pet, Pet> get copyWith =>
      _PetCopyWithImpl(this as Pet, $identity, $identity);
  @override
  String toString() {
    return PetMapper.ensureInitialized().stringifyValue(this as Pet);
  }

  @override
  bool operator ==(Object other) {
    return PetMapper.ensureInitialized().equalsValue(this as Pet, other);
  }

  @override
  int get hashCode {
    return PetMapper.ensureInitialized().hashValue(this as Pet);
  }
}

extension PetValueCopy<$R, $Out> on ObjectCopyWith<$R, Pet, $Out> {
  PetCopyWith<$R, Pet, $Out> get $asPet =>
      $base.as((v, t, t2) => _PetCopyWithImpl(v, t, t2));
}

abstract class PetCopyWith<$R, $In extends Pet, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get images;
  $R call(
      {String? id,
      String? name,
      List<String>? images,
      String? owner,
      String? displayImage,
      String? species,
      String? breed,
      String? sex,
      String? color,
      String? contactNumber,
      String? email,
      String? address,
      DateTime? dateOfBirth,
      DateTime? created,
      DateTime? updated});
  PetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PetCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Pet, $Out>
    implements PetCopyWith<$R, Pet, $Out> {
  _PetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Pet> $mapper = PetMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get images =>
      ListCopyWith($value.images, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(images: v));
  @override
  $R call(
          {String? id,
          String? name,
          List<String>? images,
          Object? owner = $none,
          Object? displayImage = $none,
          Object? species = $none,
          Object? breed = $none,
          Object? sex = $none,
          Object? color = $none,
          Object? contactNumber = $none,
          Object? email = $none,
          Object? address = $none,
          Object? dateOfBirth = $none,
          Object? created = $none,
          Object? updated = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (images != null) #images: images,
        if (owner != $none) #owner: owner,
        if (displayImage != $none) #displayImage: displayImage,
        if (species != $none) #species: species,
        if (breed != $none) #breed: breed,
        if (sex != $none) #sex: sex,
        if (color != $none) #color: color,
        if (contactNumber != $none) #contactNumber: contactNumber,
        if (email != $none) #email: email,
        if (address != $none) #address: address,
        if (dateOfBirth != $none) #dateOfBirth: dateOfBirth,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated
      }));
  @override
  Pet $make(CopyWithData data) => Pet(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      images: data.get(#images, or: $value.images),
      owner: data.get(#owner, or: $value.owner),
      displayImage: data.get(#displayImage, or: $value.displayImage),
      species: data.get(#species, or: $value.species),
      breed: data.get(#breed, or: $value.breed),
      sex: data.get(#sex, or: $value.sex),
      color: data.get(#color, or: $value.color),
      contactNumber: data.get(#contactNumber, or: $value.contactNumber),
      email: data.get(#email, or: $value.email),
      address: data.get(#address, or: $value.address),
      dateOfBirth: data.get(#dateOfBirth, or: $value.dateOfBirth),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  PetCopyWith<$R2, Pet, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PetCopyWithImpl($value, $cast, t);
}
