// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_species.dart';

class PatientSpeciesMapper extends ClassMapperBase<PatientSpecies> {
  PatientSpeciesMapper._();

  static PatientSpeciesMapper? _instance;
  static PatientSpeciesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientSpeciesMapper._());
      PbRecordMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PatientSpecies';

  static String _$id(PatientSpecies v) => v.id;
  static const Field<PatientSpecies, String> _f$id = Field('id', _$id);
  static String _$collectionId(PatientSpecies v) => v.collectionId;
  static const Field<PatientSpecies, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(PatientSpecies v) => v.collectionName;
  static const Field<PatientSpecies, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static String _$name(PatientSpecies v) => v.name;
  static const Field<PatientSpecies, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static bool _$isDeleted(PatientSpecies v) => v.isDeleted;
  static const Field<PatientSpecies, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static DateTime? _$created(PatientSpecies v) => v.created;
  static const Field<PatientSpecies, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(PatientSpecies v) => v.updated;
  static const Field<PatientSpecies, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);

  @override
  final MappableFields<PatientSpecies> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #name: _f$name,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static PatientSpecies _instantiate(DecodingData data) {
    return PatientSpecies(
        id: data.dec(_f$id),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        name: data.dec(_f$name),
        isDeleted: data.dec(_f$isDeleted),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static PatientSpecies fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientSpecies>(map);
  }

  static PatientSpecies fromJson(String json) {
    return ensureInitialized().decodeJson<PatientSpecies>(json);
  }
}

mixin PatientSpeciesMappable {
  String toJson() {
    return PatientSpeciesMapper.ensureInitialized()
        .encodeJson<PatientSpecies>(this as PatientSpecies);
  }

  Map<String, dynamic> toMap() {
    return PatientSpeciesMapper.ensureInitialized()
        .encodeMap<PatientSpecies>(this as PatientSpecies);
  }

  PatientSpeciesCopyWith<PatientSpecies, PatientSpecies, PatientSpecies>
      get copyWith =>
          _PatientSpeciesCopyWithImpl<PatientSpecies, PatientSpecies>(
              this as PatientSpecies, $identity, $identity);
  @override
  String toString() {
    return PatientSpeciesMapper.ensureInitialized()
        .stringifyValue(this as PatientSpecies);
  }

  @override
  bool operator ==(Object other) {
    return PatientSpeciesMapper.ensureInitialized()
        .equalsValue(this as PatientSpecies, other);
  }

  @override
  int get hashCode {
    return PatientSpeciesMapper.ensureInitialized()
        .hashValue(this as PatientSpecies);
  }
}

extension PatientSpeciesValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientSpecies, $Out> {
  PatientSpeciesCopyWith<$R, PatientSpecies, $Out> get $asPatientSpecies =>
      $base.as((v, t, t2) => _PatientSpeciesCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientSpeciesCopyWith<$R, $In extends PatientSpecies, $Out>
    implements PbRecordCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      String? name,
      bool? isDeleted,
      DateTime? created,
      DateTime? updated});
  PatientSpeciesCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PatientSpeciesCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientSpecies, $Out>
    implements PatientSpeciesCopyWith<$R, PatientSpecies, $Out> {
  _PatientSpeciesCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientSpecies> $mapper =
      PatientSpeciesMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? collectionId,
          String? collectionName,
          String? name,
          bool? isDeleted,
          Object? created = $none,
          Object? updated = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName,
        if (name != null) #name: name,
        if (isDeleted != null) #isDeleted: isDeleted,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated
      }));
  @override
  PatientSpecies $make(CopyWithData data) => PatientSpecies(
      id: data.get(#id, or: $value.id),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      name: data.get(#name, or: $value.name),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  PatientSpeciesCopyWith<$R2, PatientSpecies, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PatientSpeciesCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
