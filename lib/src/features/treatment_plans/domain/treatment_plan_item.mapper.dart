// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'treatment_plan_item.dart';

class TreatmentPlanItemMapper extends ClassMapperBase<TreatmentPlanItem> {
  TreatmentPlanItemMapper._();

  static TreatmentPlanItemMapper? _instance;
  static TreatmentPlanItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TreatmentPlanItemMapper._());
      TreatmentPlanItemStatusMapper.ensureInitialized();
      AppointmentScheduleMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TreatmentPlanItem';

  static String _$id(TreatmentPlanItem v) => v.id;
  static const Field<TreatmentPlanItem, String> _f$id = Field('id', _$id);
  static String _$planId(TreatmentPlanItem v) => v.planId;
  static const Field<TreatmentPlanItem, String> _f$planId = Field(
    'planId',
    _$planId,
  );
  static int _$sequence(TreatmentPlanItem v) => v.sequence;
  static const Field<TreatmentPlanItem, int> _f$sequence = Field(
    'sequence',
    _$sequence,
  );
  static DateTime _$expectedDate(TreatmentPlanItem v) => v.expectedDate;
  static const Field<TreatmentPlanItem, DateTime> _f$expectedDate = Field(
    'expectedDate',
    _$expectedDate,
  );
  static TreatmentPlanItemStatus _$status(TreatmentPlanItem v) => v.status;
  static const Field<TreatmentPlanItem, TreatmentPlanItemStatus> _f$status =
      Field('status', _$status);
  static String? _$appointmentId(TreatmentPlanItem v) => v.appointmentId;
  static const Field<TreatmentPlanItem, String> _f$appointmentId = Field(
    'appointmentId',
    _$appointmentId,
    opt: true,
  );
  static AppointmentSchedule? _$appointment(TreatmentPlanItem v) =>
      v.appointment;
  static const Field<TreatmentPlanItem, AppointmentSchedule> _f$appointment =
      Field('appointment', _$appointment, opt: true);
  static DateTime? _$completedDate(TreatmentPlanItem v) => v.completedDate;
  static const Field<TreatmentPlanItem, DateTime> _f$completedDate = Field(
    'completedDate',
    _$completedDate,
    opt: true,
  );
  static String? _$notes(TreatmentPlanItem v) => v.notes;
  static const Field<TreatmentPlanItem, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static bool _$isDeleted(TreatmentPlanItem v) => v.isDeleted;
  static const Field<TreatmentPlanItem, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static DateTime? _$created(TreatmentPlanItem v) => v.created;
  static const Field<TreatmentPlanItem, DateTime> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static DateTime? _$updated(TreatmentPlanItem v) => v.updated;
  static const Field<TreatmentPlanItem, DateTime> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );
  static String? _$patientName(TreatmentPlanItem v) => v.patientName;
  static const Field<TreatmentPlanItem, String> _f$patientName = Field(
    'patientName',
    _$patientName,
    opt: true,
  );
  static String? _$patientId(TreatmentPlanItem v) => v.patientId;
  static const Field<TreatmentPlanItem, String> _f$patientId = Field(
    'patientId',
    _$patientId,
    opt: true,
  );
  static String? _$treatmentName(TreatmentPlanItem v) => v.treatmentName;
  static const Field<TreatmentPlanItem, String> _f$treatmentName = Field(
    'treatmentName',
    _$treatmentName,
    opt: true,
  );

  @override
  final MappableFields<TreatmentPlanItem> fields = const {
    #id: _f$id,
    #planId: _f$planId,
    #sequence: _f$sequence,
    #expectedDate: _f$expectedDate,
    #status: _f$status,
    #appointmentId: _f$appointmentId,
    #appointment: _f$appointment,
    #completedDate: _f$completedDate,
    #notes: _f$notes,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #patientName: _f$patientName,
    #patientId: _f$patientId,
    #treatmentName: _f$treatmentName,
  };

  static TreatmentPlanItem _instantiate(DecodingData data) {
    return TreatmentPlanItem(
      id: data.dec(_f$id),
      planId: data.dec(_f$planId),
      sequence: data.dec(_f$sequence),
      expectedDate: data.dec(_f$expectedDate),
      status: data.dec(_f$status),
      appointmentId: data.dec(_f$appointmentId),
      appointment: data.dec(_f$appointment),
      completedDate: data.dec(_f$completedDate),
      notes: data.dec(_f$notes),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
      patientName: data.dec(_f$patientName),
      patientId: data.dec(_f$patientId),
      treatmentName: data.dec(_f$treatmentName),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TreatmentPlanItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TreatmentPlanItem>(map);
  }

  static TreatmentPlanItem fromJson(String json) {
    return ensureInitialized().decodeJson<TreatmentPlanItem>(json);
  }
}

mixin TreatmentPlanItemMappable {
  String toJson() {
    return TreatmentPlanItemMapper.ensureInitialized()
        .encodeJson<TreatmentPlanItem>(this as TreatmentPlanItem);
  }

  Map<String, dynamic> toMap() {
    return TreatmentPlanItemMapper.ensureInitialized()
        .encodeMap<TreatmentPlanItem>(this as TreatmentPlanItem);
  }

  TreatmentPlanItemCopyWith<
    TreatmentPlanItem,
    TreatmentPlanItem,
    TreatmentPlanItem
  >
  get copyWith =>
      _TreatmentPlanItemCopyWithImpl<TreatmentPlanItem, TreatmentPlanItem>(
        this as TreatmentPlanItem,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TreatmentPlanItemMapper.ensureInitialized().stringifyValue(
      this as TreatmentPlanItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return TreatmentPlanItemMapper.ensureInitialized().equalsValue(
      this as TreatmentPlanItem,
      other,
    );
  }

  @override
  int get hashCode {
    return TreatmentPlanItemMapper.ensureInitialized().hashValue(
      this as TreatmentPlanItem,
    );
  }
}

extension TreatmentPlanItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TreatmentPlanItem, $Out> {
  TreatmentPlanItemCopyWith<$R, TreatmentPlanItem, $Out>
  get $asTreatmentPlanItem => $base.as(
    (v, t, t2) => _TreatmentPlanItemCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class TreatmentPlanItemCopyWith<
  $R,
  $In extends TreatmentPlanItem,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  AppointmentScheduleCopyWith<$R, AppointmentSchedule, AppointmentSchedule>?
  get appointment;
  $R call({
    String? id,
    String? planId,
    int? sequence,
    DateTime? expectedDate,
    TreatmentPlanItemStatus? status,
    String? appointmentId,
    AppointmentSchedule? appointment,
    DateTime? completedDate,
    String? notes,
    bool? isDeleted,
    DateTime? created,
    DateTime? updated,
    String? patientName,
    String? patientId,
    String? treatmentName,
  });
  TreatmentPlanItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TreatmentPlanItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TreatmentPlanItem, $Out>
    implements TreatmentPlanItemCopyWith<$R, TreatmentPlanItem, $Out> {
  _TreatmentPlanItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TreatmentPlanItem> $mapper =
      TreatmentPlanItemMapper.ensureInitialized();
  @override
  AppointmentScheduleCopyWith<$R, AppointmentSchedule, AppointmentSchedule>?
  get appointment =>
      $value.appointment?.copyWith.$chain((v) => call(appointment: v));
  @override
  $R call({
    String? id,
    String? planId,
    int? sequence,
    DateTime? expectedDate,
    TreatmentPlanItemStatus? status,
    Object? appointmentId = $none,
    Object? appointment = $none,
    Object? completedDate = $none,
    Object? notes = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
    Object? patientName = $none,
    Object? patientId = $none,
    Object? treatmentName = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (planId != null) #planId: planId,
      if (sequence != null) #sequence: sequence,
      if (expectedDate != null) #expectedDate: expectedDate,
      if (status != null) #status: status,
      if (appointmentId != $none) #appointmentId: appointmentId,
      if (appointment != $none) #appointment: appointment,
      if (completedDate != $none) #completedDate: completedDate,
      if (notes != $none) #notes: notes,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
      if (patientName != $none) #patientName: patientName,
      if (patientId != $none) #patientId: patientId,
      if (treatmentName != $none) #treatmentName: treatmentName,
    }),
  );
  @override
  TreatmentPlanItem $make(CopyWithData data) => TreatmentPlanItem(
    id: data.get(#id, or: $value.id),
    planId: data.get(#planId, or: $value.planId),
    sequence: data.get(#sequence, or: $value.sequence),
    expectedDate: data.get(#expectedDate, or: $value.expectedDate),
    status: data.get(#status, or: $value.status),
    appointmentId: data.get(#appointmentId, or: $value.appointmentId),
    appointment: data.get(#appointment, or: $value.appointment),
    completedDate: data.get(#completedDate, or: $value.completedDate),
    notes: data.get(#notes, or: $value.notes),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
    patientName: data.get(#patientName, or: $value.patientName),
    patientId: data.get(#patientId, or: $value.patientId),
    treatmentName: data.get(#treatmentName, or: $value.treatmentName),
  );

  @override
  TreatmentPlanItemCopyWith<$R2, TreatmentPlanItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TreatmentPlanItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

