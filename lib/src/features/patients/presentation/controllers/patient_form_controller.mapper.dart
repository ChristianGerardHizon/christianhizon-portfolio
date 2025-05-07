// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_form_controller.dart';

class PatientFormStateMapper extends ClassMapperBase<PatientFormState> {
  PatientFormStateMapper._();

  static PatientFormStateMapper? _instance;
  static PatientFormStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientFormStateMapper._());
      PatientMapper.ensureInitialized();
      BranchMapper.ensureInitialized();
      PBFileMapper.ensureInitialized();
      PatientSpeciesMapper.ensureInitialized();
      PatientBreedMapper.ensureInitialized();
      PatientSexMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PatientFormState';

  static Patient? _$patient(PatientFormState v) => v.patient;
  static const Field<PatientFormState, Patient> _f$patient =
      Field('patient', _$patient);
  static List<Branch> _$branches(PatientFormState v) => v.branches;
  static const Field<PatientFormState, List<Branch>> _f$branches =
      Field('branches', _$branches, opt: true, def: const []);
  static List<PBFile>? _$images(PatientFormState v) => v.images;
  static const Field<PatientFormState, List<PBFile>> _f$images =
      Field('images', _$images, opt: true);
  static List<PatientSpecies> _$species(PatientFormState v) => v.species;
  static const Field<PatientFormState, List<PatientSpecies>> _f$species =
      Field('species', _$species, opt: true, def: const []);
  static List<PatientBreed> _$breeds(PatientFormState v) => v.breeds;
  static const Field<PatientFormState, List<PatientBreed>> _f$breeds =
      Field('breeds', _$breeds, opt: true, def: const []);
  static List<PatientSex> _$sexes(PatientFormState v) => v.sexes;
  static const Field<PatientFormState, List<PatientSex>> _f$sexes =
      Field('sexes', _$sexes, opt: true, def: const []);

  @override
  final MappableFields<PatientFormState> fields = const {
    #patient: _f$patient,
    #branches: _f$branches,
    #images: _f$images,
    #species: _f$species,
    #breeds: _f$breeds,
    #sexes: _f$sexes,
  };

  static PatientFormState _instantiate(DecodingData data) {
    return PatientFormState(
        patient: data.dec(_f$patient),
        branches: data.dec(_f$branches),
        images: data.dec(_f$images),
        species: data.dec(_f$species),
        breeds: data.dec(_f$breeds),
        sexes: data.dec(_f$sexes));
  }

  @override
  final Function instantiate = _instantiate;

  static PatientFormState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientFormState>(map);
  }

  static PatientFormState fromJson(String json) {
    return ensureInitialized().decodeJson<PatientFormState>(json);
  }
}

mixin PatientFormStateMappable {
  String toJson() {
    return PatientFormStateMapper.ensureInitialized()
        .encodeJson<PatientFormState>(this as PatientFormState);
  }

  Map<String, dynamic> toMap() {
    return PatientFormStateMapper.ensureInitialized()
        .encodeMap<PatientFormState>(this as PatientFormState);
  }

  PatientFormStateCopyWith<PatientFormState, PatientFormState, PatientFormState>
      get copyWith =>
          _PatientFormStateCopyWithImpl<PatientFormState, PatientFormState>(
              this as PatientFormState, $identity, $identity);
  @override
  String toString() {
    return PatientFormStateMapper.ensureInitialized()
        .stringifyValue(this as PatientFormState);
  }

  @override
  bool operator ==(Object other) {
    return PatientFormStateMapper.ensureInitialized()
        .equalsValue(this as PatientFormState, other);
  }

  @override
  int get hashCode {
    return PatientFormStateMapper.ensureInitialized()
        .hashValue(this as PatientFormState);
  }
}

extension PatientFormStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientFormState, $Out> {
  PatientFormStateCopyWith<$R, PatientFormState, $Out>
      get $asPatientFormState => $base
          .as((v, t, t2) => _PatientFormStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientFormStateCopyWith<$R, $In extends PatientFormState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PatientCopyWith<$R, Patient, Patient>? get patient;
  ListCopyWith<$R, Branch, BranchCopyWith<$R, Branch, Branch>> get branches;
  ListCopyWith<$R, PBFile, ObjectCopyWith<$R, PBFile, PBFile>>? get images;
  ListCopyWith<$R, PatientSpecies,
      PatientSpeciesCopyWith<$R, PatientSpecies, PatientSpecies>> get species;
  ListCopyWith<$R, PatientBreed,
      PatientBreedCopyWith<$R, PatientBreed, PatientBreed>> get breeds;
  ListCopyWith<$R, PatientSex, ObjectCopyWith<$R, PatientSex, PatientSex>>
      get sexes;
  $R call(
      {Patient? patient,
      List<Branch>? branches,
      List<PBFile>? images,
      List<PatientSpecies>? species,
      List<PatientBreed>? breeds,
      List<PatientSex>? sexes});
  PatientFormStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PatientFormStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientFormState, $Out>
    implements PatientFormStateCopyWith<$R, PatientFormState, $Out> {
  _PatientFormStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientFormState> $mapper =
      PatientFormStateMapper.ensureInitialized();
  @override
  PatientCopyWith<$R, Patient, Patient>? get patient =>
      $value.patient?.copyWith.$chain((v) => call(patient: v));
  @override
  ListCopyWith<$R, Branch, BranchCopyWith<$R, Branch, Branch>> get branches =>
      ListCopyWith($value.branches, (v, t) => v.copyWith.$chain(t),
          (v) => call(branches: v));
  @override
  ListCopyWith<$R, PBFile, ObjectCopyWith<$R, PBFile, PBFile>>? get images =>
      $value.images != null
          ? ListCopyWith($value.images!,
              (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(images: v))
          : null;
  @override
  ListCopyWith<$R, PatientSpecies,
          PatientSpeciesCopyWith<$R, PatientSpecies, PatientSpecies>>
      get species => ListCopyWith($value.species,
          (v, t) => v.copyWith.$chain(t), (v) => call(species: v));
  @override
  ListCopyWith<$R, PatientBreed,
          PatientBreedCopyWith<$R, PatientBreed, PatientBreed>>
      get breeds => ListCopyWith($value.breeds, (v, t) => v.copyWith.$chain(t),
          (v) => call(breeds: v));
  @override
  ListCopyWith<$R, PatientSex, ObjectCopyWith<$R, PatientSex, PatientSex>>
      get sexes => ListCopyWith($value.sexes,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(sexes: v));
  @override
  $R call(
          {Object? patient = $none,
          List<Branch>? branches,
          Object? images = $none,
          List<PatientSpecies>? species,
          List<PatientBreed>? breeds,
          List<PatientSex>? sexes}) =>
      $apply(FieldCopyWithData({
        if (patient != $none) #patient: patient,
        if (branches != null) #branches: branches,
        if (images != $none) #images: images,
        if (species != null) #species: species,
        if (breeds != null) #breeds: breeds,
        if (sexes != null) #sexes: sexes
      }));
  @override
  PatientFormState $make(CopyWithData data) => PatientFormState(
      patient: data.get(#patient, or: $value.patient),
      branches: data.get(#branches, or: $value.branches),
      images: data.get(#images, or: $value.images),
      species: data.get(#species, or: $value.species),
      breeds: data.get(#breeds, or: $value.breeds),
      sexes: data.get(#sexes, or: $value.sexes));

  @override
  PatientFormStateCopyWith<$R2, PatientFormState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PatientFormStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
