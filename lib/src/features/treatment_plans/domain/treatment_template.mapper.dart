// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'treatment_template.dart';

class TreatmentTemplateMapper extends ClassMapperBase<TreatmentTemplate> {
  TreatmentTemplateMapper._();

  static TreatmentTemplateMapper? _instance;
  static TreatmentTemplateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TreatmentTemplateMapper._());
      PatientTreatmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TreatmentTemplate';

  static String _$id(TreatmentTemplate v) => v.id;
  static const Field<TreatmentTemplate, String> _f$id = Field('id', _$id);
  static String _$name(TreatmentTemplate v) => v.name;
  static const Field<TreatmentTemplate, String> _f$name = Field('name', _$name);
  static String _$treatmentId(TreatmentTemplate v) => v.treatmentId;
  static const Field<TreatmentTemplate, String> _f$treatmentId = Field(
    'treatmentId',
    _$treatmentId,
  );
  static PatientTreatment? _$treatment(TreatmentTemplate v) => v.treatment;
  static const Field<TreatmentTemplate, PatientTreatment> _f$treatment = Field(
    'treatment',
    _$treatment,
    opt: true,
  );
  static int _$defaultSessionCount(TreatmentTemplate v) =>
      v.defaultSessionCount;
  static const Field<TreatmentTemplate, int> _f$defaultSessionCount = Field(
    'defaultSessionCount',
    _$defaultSessionCount,
  );
  static int _$defaultIntervalDays(TreatmentTemplate v) =>
      v.defaultIntervalDays;
  static const Field<TreatmentTemplate, int> _f$defaultIntervalDays = Field(
    'defaultIntervalDays',
    _$defaultIntervalDays,
  );
  static String? _$notes(TreatmentTemplate v) => v.notes;
  static const Field<TreatmentTemplate, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static bool _$isDeleted(TreatmentTemplate v) => v.isDeleted;
  static const Field<TreatmentTemplate, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static DateTime? _$created(TreatmentTemplate v) => v.created;
  static const Field<TreatmentTemplate, DateTime> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static DateTime? _$updated(TreatmentTemplate v) => v.updated;
  static const Field<TreatmentTemplate, DateTime> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );

  @override
  final MappableFields<TreatmentTemplate> fields = const {
    #id: _f$id,
    #name: _f$name,
    #treatmentId: _f$treatmentId,
    #treatment: _f$treatment,
    #defaultSessionCount: _f$defaultSessionCount,
    #defaultIntervalDays: _f$defaultIntervalDays,
    #notes: _f$notes,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static TreatmentTemplate _instantiate(DecodingData data) {
    return TreatmentTemplate(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      treatmentId: data.dec(_f$treatmentId),
      treatment: data.dec(_f$treatment),
      defaultSessionCount: data.dec(_f$defaultSessionCount),
      defaultIntervalDays: data.dec(_f$defaultIntervalDays),
      notes: data.dec(_f$notes),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TreatmentTemplate fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TreatmentTemplate>(map);
  }

  static TreatmentTemplate fromJson(String json) {
    return ensureInitialized().decodeJson<TreatmentTemplate>(json);
  }
}

mixin TreatmentTemplateMappable {
  String toJson() {
    return TreatmentTemplateMapper.ensureInitialized()
        .encodeJson<TreatmentTemplate>(this as TreatmentTemplate);
  }

  Map<String, dynamic> toMap() {
    return TreatmentTemplateMapper.ensureInitialized()
        .encodeMap<TreatmentTemplate>(this as TreatmentTemplate);
  }

  TreatmentTemplateCopyWith<
    TreatmentTemplate,
    TreatmentTemplate,
    TreatmentTemplate
  >
  get copyWith =>
      _TreatmentTemplateCopyWithImpl<TreatmentTemplate, TreatmentTemplate>(
        this as TreatmentTemplate,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TreatmentTemplateMapper.ensureInitialized().stringifyValue(
      this as TreatmentTemplate,
    );
  }

  @override
  bool operator ==(Object other) {
    return TreatmentTemplateMapper.ensureInitialized().equalsValue(
      this as TreatmentTemplate,
      other,
    );
  }

  @override
  int get hashCode {
    return TreatmentTemplateMapper.ensureInitialized().hashValue(
      this as TreatmentTemplate,
    );
  }
}

extension TreatmentTemplateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TreatmentTemplate, $Out> {
  TreatmentTemplateCopyWith<$R, TreatmentTemplate, $Out>
  get $asTreatmentTemplate => $base.as(
    (v, t, t2) => _TreatmentTemplateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class TreatmentTemplateCopyWith<
  $R,
  $In extends TreatmentTemplate,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  PatientTreatmentCopyWith<$R, PatientTreatment, PatientTreatment>?
  get treatment;
  $R call({
    String? id,
    String? name,
    String? treatmentId,
    PatientTreatment? treatment,
    int? defaultSessionCount,
    int? defaultIntervalDays,
    String? notes,
    bool? isDeleted,
    DateTime? created,
    DateTime? updated,
  });
  TreatmentTemplateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TreatmentTemplateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TreatmentTemplate, $Out>
    implements TreatmentTemplateCopyWith<$R, TreatmentTemplate, $Out> {
  _TreatmentTemplateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TreatmentTemplate> $mapper =
      TreatmentTemplateMapper.ensureInitialized();
  @override
  PatientTreatmentCopyWith<$R, PatientTreatment, PatientTreatment>?
  get treatment => $value.treatment?.copyWith.$chain((v) => call(treatment: v));
  @override
  $R call({
    String? id,
    String? name,
    String? treatmentId,
    Object? treatment = $none,
    int? defaultSessionCount,
    int? defaultIntervalDays,
    Object? notes = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (treatmentId != null) #treatmentId: treatmentId,
      if (treatment != $none) #treatment: treatment,
      if (defaultSessionCount != null)
        #defaultSessionCount: defaultSessionCount,
      if (defaultIntervalDays != null)
        #defaultIntervalDays: defaultIntervalDays,
      if (notes != $none) #notes: notes,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
    }),
  );
  @override
  TreatmentTemplate $make(CopyWithData data) => TreatmentTemplate(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    treatmentId: data.get(#treatmentId, or: $value.treatmentId),
    treatment: data.get(#treatment, or: $value.treatment),
    defaultSessionCount: data.get(
      #defaultSessionCount,
      or: $value.defaultSessionCount,
    ),
    defaultIntervalDays: data.get(
      #defaultIntervalDays,
      or: $value.defaultIntervalDays,
    ),
    notes: data.get(#notes, or: $value.notes),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
  );

  @override
  TreatmentTemplateCopyWith<$R2, TreatmentTemplate, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TreatmentTemplateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

