// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'treatment_plan.dart';

class TreatmentPlanMapper extends ClassMapperBase<TreatmentPlan> {
  TreatmentPlanMapper._();

  static TreatmentPlanMapper? _instance;
  static TreatmentPlanMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TreatmentPlanMapper._());
      PatientMapper.ensureInitialized();
      PatientTreatmentMapper.ensureInitialized();
      TreatmentPlanStatusMapper.ensureInitialized();
      TreatmentPlanItemMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TreatmentPlan';

  static String _$id(TreatmentPlan v) => v.id;
  static const Field<TreatmentPlan, String> _f$id = Field('id', _$id);
  static String _$patientId(TreatmentPlan v) => v.patientId;
  static const Field<TreatmentPlan, String> _f$patientId = Field(
    'patientId',
    _$patientId,
  );
  static Patient? _$patient(TreatmentPlan v) => v.patient;
  static const Field<TreatmentPlan, Patient> _f$patient = Field(
    'patient',
    _$patient,
    opt: true,
  );
  static String _$treatmentId(TreatmentPlan v) => v.treatmentId;
  static const Field<TreatmentPlan, String> _f$treatmentId = Field(
    'treatmentId',
    _$treatmentId,
  );
  static PatientTreatment? _$treatment(TreatmentPlan v) => v.treatment;
  static const Field<TreatmentPlan, PatientTreatment> _f$treatment = Field(
    'treatment',
    _$treatment,
    opt: true,
  );
  static TreatmentPlanStatus _$status(TreatmentPlan v) => v.status;
  static const Field<TreatmentPlan, TreatmentPlanStatus> _f$status = Field(
    'status',
    _$status,
  );
  static DateTime _$startDate(TreatmentPlan v) => v.startDate;
  static const Field<TreatmentPlan, DateTime> _f$startDate = Field(
    'startDate',
    _$startDate,
  );
  static String? _$title(TreatmentPlan v) => v.title;
  static const Field<TreatmentPlan, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
  );
  static String? _$notes(TreatmentPlan v) => v.notes;
  static const Field<TreatmentPlan, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static List<TreatmentPlanItem> _$items(TreatmentPlan v) => v.items;
  static const Field<TreatmentPlan, List<TreatmentPlanItem>> _f$items = Field(
    'items',
    _$items,
    opt: true,
    def: const [],
  );
  static bool _$isDeleted(TreatmentPlan v) => v.isDeleted;
  static const Field<TreatmentPlan, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static DateTime? _$created(TreatmentPlan v) => v.created;
  static const Field<TreatmentPlan, DateTime> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static DateTime? _$updated(TreatmentPlan v) => v.updated;
  static const Field<TreatmentPlan, DateTime> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );

  @override
  final MappableFields<TreatmentPlan> fields = const {
    #id: _f$id,
    #patientId: _f$patientId,
    #patient: _f$patient,
    #treatmentId: _f$treatmentId,
    #treatment: _f$treatment,
    #status: _f$status,
    #startDate: _f$startDate,
    #title: _f$title,
    #notes: _f$notes,
    #items: _f$items,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static TreatmentPlan _instantiate(DecodingData data) {
    return TreatmentPlan(
      id: data.dec(_f$id),
      patientId: data.dec(_f$patientId),
      patient: data.dec(_f$patient),
      treatmentId: data.dec(_f$treatmentId),
      treatment: data.dec(_f$treatment),
      status: data.dec(_f$status),
      startDate: data.dec(_f$startDate),
      title: data.dec(_f$title),
      notes: data.dec(_f$notes),
      items: data.dec(_f$items),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TreatmentPlan fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TreatmentPlan>(map);
  }

  static TreatmentPlan fromJson(String json) {
    return ensureInitialized().decodeJson<TreatmentPlan>(json);
  }
}

mixin TreatmentPlanMappable {
  String toJson() {
    return TreatmentPlanMapper.ensureInitialized().encodeJson<TreatmentPlan>(
      this as TreatmentPlan,
    );
  }

  Map<String, dynamic> toMap() {
    return TreatmentPlanMapper.ensureInitialized().encodeMap<TreatmentPlan>(
      this as TreatmentPlan,
    );
  }

  TreatmentPlanCopyWith<TreatmentPlan, TreatmentPlan, TreatmentPlan>
  get copyWith => _TreatmentPlanCopyWithImpl<TreatmentPlan, TreatmentPlan>(
    this as TreatmentPlan,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return TreatmentPlanMapper.ensureInitialized().stringifyValue(
      this as TreatmentPlan,
    );
  }

  @override
  bool operator ==(Object other) {
    return TreatmentPlanMapper.ensureInitialized().equalsValue(
      this as TreatmentPlan,
      other,
    );
  }

  @override
  int get hashCode {
    return TreatmentPlanMapper.ensureInitialized().hashValue(
      this as TreatmentPlan,
    );
  }
}

extension TreatmentPlanValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TreatmentPlan, $Out> {
  TreatmentPlanCopyWith<$R, TreatmentPlan, $Out> get $asTreatmentPlan =>
      $base.as((v, t, t2) => _TreatmentPlanCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TreatmentPlanCopyWith<$R, $In extends TreatmentPlan, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PatientCopyWith<$R, Patient, Patient>? get patient;
  PatientTreatmentCopyWith<$R, PatientTreatment, PatientTreatment>?
  get treatment;
  ListCopyWith<
    $R,
    TreatmentPlanItem,
    TreatmentPlanItemCopyWith<$R, TreatmentPlanItem, TreatmentPlanItem>
  >
  get items;
  $R call({
    String? id,
    String? patientId,
    Patient? patient,
    String? treatmentId,
    PatientTreatment? treatment,
    TreatmentPlanStatus? status,
    DateTime? startDate,
    String? title,
    String? notes,
    List<TreatmentPlanItem>? items,
    bool? isDeleted,
    DateTime? created,
    DateTime? updated,
  });
  TreatmentPlanCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TreatmentPlanCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TreatmentPlan, $Out>
    implements TreatmentPlanCopyWith<$R, TreatmentPlan, $Out> {
  _TreatmentPlanCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TreatmentPlan> $mapper =
      TreatmentPlanMapper.ensureInitialized();
  @override
  PatientCopyWith<$R, Patient, Patient>? get patient =>
      $value.patient?.copyWith.$chain((v) => call(patient: v));
  @override
  PatientTreatmentCopyWith<$R, PatientTreatment, PatientTreatment>?
  get treatment => $value.treatment?.copyWith.$chain((v) => call(treatment: v));
  @override
  ListCopyWith<
    $R,
    TreatmentPlanItem,
    TreatmentPlanItemCopyWith<$R, TreatmentPlanItem, TreatmentPlanItem>
  >
  get items => ListCopyWith(
    $value.items,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(items: v),
  );
  @override
  $R call({
    String? id,
    String? patientId,
    Object? patient = $none,
    String? treatmentId,
    Object? treatment = $none,
    TreatmentPlanStatus? status,
    DateTime? startDate,
    Object? title = $none,
    Object? notes = $none,
    List<TreatmentPlanItem>? items,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (patientId != null) #patientId: patientId,
      if (patient != $none) #patient: patient,
      if (treatmentId != null) #treatmentId: treatmentId,
      if (treatment != $none) #treatment: treatment,
      if (status != null) #status: status,
      if (startDate != null) #startDate: startDate,
      if (title != $none) #title: title,
      if (notes != $none) #notes: notes,
      if (items != null) #items: items,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
    }),
  );
  @override
  TreatmentPlan $make(CopyWithData data) => TreatmentPlan(
    id: data.get(#id, or: $value.id),
    patientId: data.get(#patientId, or: $value.patientId),
    patient: data.get(#patient, or: $value.patient),
    treatmentId: data.get(#treatmentId, or: $value.treatmentId),
    treatment: data.get(#treatment, or: $value.treatment),
    status: data.get(#status, or: $value.status),
    startDate: data.get(#startDate, or: $value.startDate),
    title: data.get(#title, or: $value.title),
    notes: data.get(#notes, or: $value.notes),
    items: data.get(#items, or: $value.items),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
  );

  @override
  TreatmentPlanCopyWith<$R2, TreatmentPlan, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TreatmentPlanCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

