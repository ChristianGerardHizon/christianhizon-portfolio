// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'treatment_plan_item_dto.dart';

class TreatmentPlanItemDtoMapper extends ClassMapperBase<TreatmentPlanItemDto> {
  TreatmentPlanItemDtoMapper._();

  static TreatmentPlanItemDtoMapper? _instance;
  static TreatmentPlanItemDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TreatmentPlanItemDtoMapper._());
      AppointmentScheduleMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TreatmentPlanItemDto';

  static String _$id(TreatmentPlanItemDto v) => v.id;
  static const Field<TreatmentPlanItemDto, String> _f$id = Field('id', _$id);
  static String _$collectionId(TreatmentPlanItemDto v) => v.collectionId;
  static const Field<TreatmentPlanItemDto, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(TreatmentPlanItemDto v) => v.collectionName;
  static const Field<TreatmentPlanItemDto, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static String _$plan(TreatmentPlanItemDto v) => v.plan;
  static const Field<TreatmentPlanItemDto, String> _f$plan = Field(
    'plan',
    _$plan,
  );
  static int _$sequence(TreatmentPlanItemDto v) => v.sequence;
  static const Field<TreatmentPlanItemDto, int> _f$sequence = Field(
    'sequence',
    _$sequence,
  );
  static String _$expectedDate(TreatmentPlanItemDto v) => v.expectedDate;
  static const Field<TreatmentPlanItemDto, String> _f$expectedDate = Field(
    'expectedDate',
    _$expectedDate,
  );
  static String _$status(TreatmentPlanItemDto v) => v.status;
  static const Field<TreatmentPlanItemDto, String> _f$status = Field(
    'status',
    _$status,
  );
  static String? _$appointment(TreatmentPlanItemDto v) => v.appointment;
  static const Field<TreatmentPlanItemDto, String> _f$appointment = Field(
    'appointment',
    _$appointment,
    opt: true,
  );
  static String? _$completedDate(TreatmentPlanItemDto v) => v.completedDate;
  static const Field<TreatmentPlanItemDto, String> _f$completedDate = Field(
    'completedDate',
    _$completedDate,
    opt: true,
  );
  static String? _$notes(TreatmentPlanItemDto v) => v.notes;
  static const Field<TreatmentPlanItemDto, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static bool _$isDeleted(TreatmentPlanItemDto v) => v.isDeleted;
  static const Field<TreatmentPlanItemDto, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static String? _$created(TreatmentPlanItemDto v) => v.created;
  static const Field<TreatmentPlanItemDto, String> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static String? _$updated(TreatmentPlanItemDto v) => v.updated;
  static const Field<TreatmentPlanItemDto, String> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );
  static AppointmentSchedule? _$expandedAppointment(TreatmentPlanItemDto v) =>
      v.expandedAppointment;
  static const Field<TreatmentPlanItemDto, AppointmentSchedule>
  _f$expandedAppointment = Field(
    'expandedAppointment',
    _$expandedAppointment,
    opt: true,
  );
  static String? _$patientName(TreatmentPlanItemDto v) => v.patientName;
  static const Field<TreatmentPlanItemDto, String> _f$patientName = Field(
    'patientName',
    _$patientName,
    opt: true,
  );
  static String? _$treatmentName(TreatmentPlanItemDto v) => v.treatmentName;
  static const Field<TreatmentPlanItemDto, String> _f$treatmentName = Field(
    'treatmentName',
    _$treatmentName,
    opt: true,
  );

  @override
  final MappableFields<TreatmentPlanItemDto> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #plan: _f$plan,
    #sequence: _f$sequence,
    #expectedDate: _f$expectedDate,
    #status: _f$status,
    #appointment: _f$appointment,
    #completedDate: _f$completedDate,
    #notes: _f$notes,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #expandedAppointment: _f$expandedAppointment,
    #patientName: _f$patientName,
    #treatmentName: _f$treatmentName,
  };

  static TreatmentPlanItemDto _instantiate(DecodingData data) {
    return TreatmentPlanItemDto(
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      plan: data.dec(_f$plan),
      sequence: data.dec(_f$sequence),
      expectedDate: data.dec(_f$expectedDate),
      status: data.dec(_f$status),
      appointment: data.dec(_f$appointment),
      completedDate: data.dec(_f$completedDate),
      notes: data.dec(_f$notes),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
      expandedAppointment: data.dec(_f$expandedAppointment),
      patientName: data.dec(_f$patientName),
      treatmentName: data.dec(_f$treatmentName),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TreatmentPlanItemDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TreatmentPlanItemDto>(map);
  }

  static TreatmentPlanItemDto fromJson(String json) {
    return ensureInitialized().decodeJson<TreatmentPlanItemDto>(json);
  }
}

mixin TreatmentPlanItemDtoMappable {
  String toJson() {
    return TreatmentPlanItemDtoMapper.ensureInitialized()
        .encodeJson<TreatmentPlanItemDto>(this as TreatmentPlanItemDto);
  }

  Map<String, dynamic> toMap() {
    return TreatmentPlanItemDtoMapper.ensureInitialized()
        .encodeMap<TreatmentPlanItemDto>(this as TreatmentPlanItemDto);
  }

  TreatmentPlanItemDtoCopyWith<
    TreatmentPlanItemDto,
    TreatmentPlanItemDto,
    TreatmentPlanItemDto
  >
  get copyWith =>
      _TreatmentPlanItemDtoCopyWithImpl<
        TreatmentPlanItemDto,
        TreatmentPlanItemDto
      >(this as TreatmentPlanItemDto, $identity, $identity);
  @override
  String toString() {
    return TreatmentPlanItemDtoMapper.ensureInitialized().stringifyValue(
      this as TreatmentPlanItemDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return TreatmentPlanItemDtoMapper.ensureInitialized().equalsValue(
      this as TreatmentPlanItemDto,
      other,
    );
  }

  @override
  int get hashCode {
    return TreatmentPlanItemDtoMapper.ensureInitialized().hashValue(
      this as TreatmentPlanItemDto,
    );
  }
}

extension TreatmentPlanItemDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TreatmentPlanItemDto, $Out> {
  TreatmentPlanItemDtoCopyWith<$R, TreatmentPlanItemDto, $Out>
  get $asTreatmentPlanItemDto => $base.as(
    (v, t, t2) => _TreatmentPlanItemDtoCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class TreatmentPlanItemDtoCopyWith<
  $R,
  $In extends TreatmentPlanItemDto,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  AppointmentScheduleCopyWith<$R, AppointmentSchedule, AppointmentSchedule>?
  get expandedAppointment;
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? plan,
    int? sequence,
    String? expectedDate,
    String? status,
    String? appointment,
    String? completedDate,
    String? notes,
    bool? isDeleted,
    String? created,
    String? updated,
    AppointmentSchedule? expandedAppointment,
    String? patientName,
    String? treatmentName,
  });
  TreatmentPlanItemDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TreatmentPlanItemDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TreatmentPlanItemDto, $Out>
    implements TreatmentPlanItemDtoCopyWith<$R, TreatmentPlanItemDto, $Out> {
  _TreatmentPlanItemDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TreatmentPlanItemDto> $mapper =
      TreatmentPlanItemDtoMapper.ensureInitialized();
  @override
  AppointmentScheduleCopyWith<$R, AppointmentSchedule, AppointmentSchedule>?
  get expandedAppointment => $value.expandedAppointment?.copyWith.$chain(
    (v) => call(expandedAppointment: v),
  );
  @override
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    String? plan,
    int? sequence,
    String? expectedDate,
    String? status,
    Object? appointment = $none,
    Object? completedDate = $none,
    Object? notes = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
    Object? expandedAppointment = $none,
    Object? patientName = $none,
    Object? treatmentName = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (plan != null) #plan: plan,
      if (sequence != null) #sequence: sequence,
      if (expectedDate != null) #expectedDate: expectedDate,
      if (status != null) #status: status,
      if (appointment != $none) #appointment: appointment,
      if (completedDate != $none) #completedDate: completedDate,
      if (notes != $none) #notes: notes,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
      if (expandedAppointment != $none)
        #expandedAppointment: expandedAppointment,
      if (patientName != $none) #patientName: patientName,
      if (treatmentName != $none) #treatmentName: treatmentName,
    }),
  );
  @override
  TreatmentPlanItemDto $make(CopyWithData data) => TreatmentPlanItemDto(
    id: data.get(#id, or: $value.id),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    plan: data.get(#plan, or: $value.plan),
    sequence: data.get(#sequence, or: $value.sequence),
    expectedDate: data.get(#expectedDate, or: $value.expectedDate),
    status: data.get(#status, or: $value.status),
    appointment: data.get(#appointment, or: $value.appointment),
    completedDate: data.get(#completedDate, or: $value.completedDate),
    notes: data.get(#notes, or: $value.notes),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
    expandedAppointment: data.get(
      #expandedAppointment,
      or: $value.expandedAppointment,
    ),
    patientName: data.get(#patientName, or: $value.patientName),
    treatmentName: data.get(#treatmentName, or: $value.treatmentName),
  );

  @override
  TreatmentPlanItemDtoCopyWith<$R2, TreatmentPlanItemDto, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _TreatmentPlanItemDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

