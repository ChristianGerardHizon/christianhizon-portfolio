// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_breed.dart';

class PatientBreedMapper extends ClassMapperBase<PatientBreed> {
  PatientBreedMapper._();

  static PatientBreedMapper? _instance;
  static PatientBreedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientBreedMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PatientBreed';

  static String _$id(PatientBreed v) => v.id;
  static const Field<PatientBreed, String> _f$id = Field('id', _$id);
  static String _$name(PatientBreed v) => v.name;
  static const Field<PatientBreed, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static String _$species(PatientBreed v) => v.species;
  static const Field<PatientBreed, String> _f$species =
      Field('species', _$species);
  static bool _$isDeleted(PatientBreed v) => v.isDeleted;
  static const Field<PatientBreed, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static DateTime? _$created(PatientBreed v) => v.created;
  static const Field<PatientBreed, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(PatientBreed v) => v.updated;
  static const Field<PatientBreed, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);

  @override
  final MappableFields<PatientBreed> fields = const {
    #id: _f$id,
    #name: _f$name,
    #species: _f$species,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static PatientBreed _instantiate(DecodingData data) {
    return PatientBreed(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        species: data.dec(_f$species),
        isDeleted: data.dec(_f$isDeleted),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static PatientBreed fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientBreed>(map);
  }

  static PatientBreed fromJson(String json) {
    return ensureInitialized().decodeJson<PatientBreed>(json);
  }
}

mixin PatientBreedMappable {
  String toJson() {
    return PatientBreedMapper.ensureInitialized()
        .encodeJson<PatientBreed>(this as PatientBreed);
  }

  Map<String, dynamic> toMap() {
    return PatientBreedMapper.ensureInitialized()
        .encodeMap<PatientBreed>(this as PatientBreed);
  }

  PatientBreedCopyWith<PatientBreed, PatientBreed, PatientBreed> get copyWith =>
      _PatientBreedCopyWithImpl<PatientBreed, PatientBreed>(
          this as PatientBreed, $identity, $identity);
  @override
  String toString() {
    return PatientBreedMapper.ensureInitialized()
        .stringifyValue(this as PatientBreed);
  }

  @override
  bool operator ==(Object other) {
    return PatientBreedMapper.ensureInitialized()
        .equalsValue(this as PatientBreed, other);
  }

  @override
  int get hashCode {
    return PatientBreedMapper.ensureInitialized()
        .hashValue(this as PatientBreed);
  }
}

extension PatientBreedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientBreed, $Out> {
  PatientBreedCopyWith<$R, PatientBreed, $Out> get $asPatientBreed =>
      $base.as((v, t, t2) => _PatientBreedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientBreedCopyWith<$R, $In extends PatientBreed, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? name,
      String? species,
      bool? isDeleted,
      DateTime? created,
      DateTime? updated});
  PatientBreedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PatientBreedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientBreed, $Out>
    implements PatientBreedCopyWith<$R, PatientBreed, $Out> {
  _PatientBreedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientBreed> $mapper =
      PatientBreedMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? name,
          String? species,
          bool? isDeleted,
          Object? created = $none,
          Object? updated = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (species != null) #species: species,
        if (isDeleted != null) #isDeleted: isDeleted,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated
      }));
  @override
  PatientBreed $make(CopyWithData data) => PatientBreed(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      species: data.get(#species, or: $value.species),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  PatientBreedCopyWith<$R2, PatientBreed, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PatientBreedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
