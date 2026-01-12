// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_dto.dart';

class PatientDtoMapper extends ClassMapperBase<PatientDto> {
  PatientDtoMapper._();

  static PatientDtoMapper? _instance;
  static PatientDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PatientDto';

  static String _$id(PatientDto v) => v.id;
  static const Field<PatientDto, String> _f$id = Field('id', _$id);
  static String _$collectionId(PatientDto v) => v.collectionId;
  static const Field<PatientDto, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(PatientDto v) => v.collectionName;
  static const Field<PatientDto, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static String _$name(PatientDto v) => v.name;
  static const Field<PatientDto, String> _f$name = Field('name', _$name);
  static String? _$species(PatientDto v) => v.species;
  static const Field<PatientDto, String> _f$species = Field(
    'species',
    _$species,
    opt: true,
  );
  static String? _$breed(PatientDto v) => v.breed;
  static const Field<PatientDto, String> _f$breed = Field(
    'breed',
    _$breed,
    opt: true,
  );
  static String? _$owner(PatientDto v) => v.owner;
  static const Field<PatientDto, String> _f$owner = Field(
    'owner',
    _$owner,
    opt: true,
  );
  static String? _$contactNumber(PatientDto v) => v.contactNumber;
  static const Field<PatientDto, String> _f$contactNumber = Field(
    'contactNumber',
    _$contactNumber,
    opt: true,
  );
  static String? _$email(PatientDto v) => v.email;
  static const Field<PatientDto, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
  );
  static String? _$address(PatientDto v) => v.address;
  static const Field<PatientDto, String> _f$address = Field(
    'address',
    _$address,
    opt: true,
  );
  static String? _$color(PatientDto v) => v.color;
  static const Field<PatientDto, String> _f$color = Field(
    'color',
    _$color,
    opt: true,
  );
  static String? _$sex(PatientDto v) => v.sex;
  static const Field<PatientDto, String> _f$sex = Field(
    'sex',
    _$sex,
    opt: true,
  );
  static String? _$branch(PatientDto v) => v.branch;
  static const Field<PatientDto, String> _f$branch = Field(
    'branch',
    _$branch,
    opt: true,
  );
  static String? _$dateOfBirth(PatientDto v) => v.dateOfBirth;
  static const Field<PatientDto, String> _f$dateOfBirth = Field(
    'dateOfBirth',
    _$dateOfBirth,
    opt: true,
  );
  static String? _$avatar(PatientDto v) => v.avatar;
  static const Field<PatientDto, String> _f$avatar = Field(
    'avatar',
    _$avatar,
    opt: true,
  );
  static List<String> _$images(PatientDto v) => v.images;
  static const Field<PatientDto, List<String>> _f$images = Field(
    'images',
    _$images,
    opt: true,
    def: const [],
  );
  static bool _$isDeleted(PatientDto v) => v.isDeleted;
  static const Field<PatientDto, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static String? _$created(PatientDto v) => v.created;
  static const Field<PatientDto, String> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static String? _$updated(PatientDto v) => v.updated;
  static const Field<PatientDto, String> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );

  @override
  final MappableFields<PatientDto> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #name: _f$name,
    #species: _f$species,
    #breed: _f$breed,
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

  static PatientDto _instantiate(DecodingData data) {
    return PatientDto(
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      name: data.dec(_f$name),
      species: data.dec(_f$species),
      breed: data.dec(_f$breed),
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

  static PatientDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientDto>(map);
  }

  static PatientDto fromJson(String json) {
    return ensureInitialized().decodeJson<PatientDto>(json);
  }
}

mixin PatientDtoMappable {
  String toJson() {
    return PatientDtoMapper.ensureInitialized().encodeJson<PatientDto>(
      this as PatientDto,
    );
  }

  Map<String, dynamic> toMap() {
    return PatientDtoMapper.ensureInitialized().encodeMap<PatientDto>(
      this as PatientDto,
    );
  }

  PatientDtoCopyWith<PatientDto, PatientDto, PatientDto> get copyWith =>
      _PatientDtoCopyWithImpl<PatientDto, PatientDto>(
        this as PatientDto,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PatientDtoMapper.ensureInitialized().stringifyValue(
      this as PatientDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return PatientDtoMapper.ensureInitialized().equalsValue(
      this as PatientDto,
      other,
    );
  }

  @override
  int get hashCode {
    return PatientDtoMapper.ensureInitialized().hashValue(this as PatientDto);
  }
}

extension PatientDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientDto, $Out> {
  PatientDtoCopyWith<$R, PatientDto, $Out> get $asPatientDto =>
      $base.as((v, t, t2) => _PatientDtoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientDtoCopyWith<$R, $In extends PatientDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get images;
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? name,
    String? species,
    String? breed,
    String? owner,
    String? contactNumber,
    String? email,
    String? address,
    String? color,
    String? sex,
    String? branch,
    String? dateOfBirth,
    String? avatar,
    List<String>? images,
    bool? isDeleted,
    String? created,
    String? updated,
  });
  PatientDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PatientDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientDto, $Out>
    implements PatientDtoCopyWith<$R, PatientDto, $Out> {
  _PatientDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientDto> $mapper =
      PatientDtoMapper.ensureInitialized();
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
    String? collectionId,
    String? collectionName,
    String? name,
    Object? species = $none,
    Object? breed = $none,
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
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (name != null) #name: name,
      if (species != $none) #species: species,
      if (breed != $none) #breed: breed,
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
  PatientDto $make(CopyWithData data) => PatientDto(
    id: data.get(#id, or: $value.id),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    name: data.get(#name, or: $value.name),
    species: data.get(#species, or: $value.species),
    breed: data.get(#breed, or: $value.breed),
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
  PatientDtoCopyWith<$R2, PatientDto, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PatientDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

