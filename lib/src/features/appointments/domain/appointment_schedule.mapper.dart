// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'appointment_schedule.dart';

class AppointmentScheduleStatusMapper
    extends EnumMapper<AppointmentScheduleStatus> {
  AppointmentScheduleStatusMapper._();

  static AppointmentScheduleStatusMapper? _instance;
  static AppointmentScheduleStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = AppointmentScheduleStatusMapper._(),
      );
    }
    return _instance!;
  }

  static AppointmentScheduleStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AppointmentScheduleStatus decode(dynamic value) {
    switch (value) {
      case r'scheduled':
        return AppointmentScheduleStatus.scheduled;
      case r'completed':
        return AppointmentScheduleStatus.completed;
      case r'missed':
        return AppointmentScheduleStatus.missed;
      case r'cancelled':
        return AppointmentScheduleStatus.cancelled;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AppointmentScheduleStatus self) {
    switch (self) {
      case AppointmentScheduleStatus.scheduled:
        return r'scheduled';
      case AppointmentScheduleStatus.completed:
        return r'completed';
      case AppointmentScheduleStatus.missed:
        return r'missed';
      case AppointmentScheduleStatus.cancelled:
        return r'cancelled';
    }
  }
}

extension AppointmentScheduleStatusMapperExtension
    on AppointmentScheduleStatus {
  String toValue() {
    AppointmentScheduleStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AppointmentScheduleStatus>(this)
        as String;
  }
}

class AppointmentScheduleMapper extends ClassMapperBase<AppointmentSchedule> {
  AppointmentScheduleMapper._();

  static AppointmentScheduleMapper? _instance;
  static AppointmentScheduleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppointmentScheduleMapper._());
      AppointmentScheduleStatusMapper.ensureInitialized();
      PatientMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AppointmentSchedule';

  static String _$id(AppointmentSchedule v) => v.id;
  static const Field<AppointmentSchedule, String> _f$id = Field('id', _$id);
  static DateTime _$date(AppointmentSchedule v) => v.date;
  static const Field<AppointmentSchedule, DateTime> _f$date = Field(
    'date',
    _$date,
  );
  static bool _$hasTime(AppointmentSchedule v) => v.hasTime;
  static const Field<AppointmentSchedule, bool> _f$hasTime = Field(
    'hasTime',
    _$hasTime,
    opt: true,
    def: true,
  );
  static String? _$notes(AppointmentSchedule v) => v.notes;
  static const Field<AppointmentSchedule, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static String? _$purpose(AppointmentSchedule v) => v.purpose;
  static const Field<AppointmentSchedule, String> _f$purpose = Field(
    'purpose',
    _$purpose,
    opt: true,
  );
  static AppointmentScheduleStatus _$status(AppointmentSchedule v) => v.status;
  static const Field<AppointmentSchedule, AppointmentScheduleStatus> _f$status =
      Field(
        'status',
        _$status,
        opt: true,
        def: AppointmentScheduleStatus.scheduled,
      );
  static String? _$patient(AppointmentSchedule v) => v.patient;
  static const Field<AppointmentSchedule, String> _f$patient = Field(
    'patient',
    _$patient,
    opt: true,
  );
  static String? _$patientRecord(AppointmentSchedule v) => v.patientRecord;
  static const Field<AppointmentSchedule, String> _f$patientRecord = Field(
    'patientRecord',
    _$patientRecord,
    opt: true,
  );
  static String? _$branch(AppointmentSchedule v) => v.branch;
  static const Field<AppointmentSchedule, String> _f$branch = Field(
    'branch',
    _$branch,
    opt: true,
  );
  static String? _$patientName(AppointmentSchedule v) => v.patientName;
  static const Field<AppointmentSchedule, String> _f$patientName = Field(
    'patientName',
    _$patientName,
    opt: true,
  );
  static String? _$ownerName(AppointmentSchedule v) => v.ownerName;
  static const Field<AppointmentSchedule, String> _f$ownerName = Field(
    'ownerName',
    _$ownerName,
    opt: true,
  );
  static String? _$ownerContact(AppointmentSchedule v) => v.ownerContact;
  static const Field<AppointmentSchedule, String> _f$ownerContact = Field(
    'ownerContact',
    _$ownerContact,
    opt: true,
  );
  static bool _$isDeleted(AppointmentSchedule v) => v.isDeleted;
  static const Field<AppointmentSchedule, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static DateTime? _$created(AppointmentSchedule v) => v.created;
  static const Field<AppointmentSchedule, DateTime> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static DateTime? _$updated(AppointmentSchedule v) => v.updated;
  static const Field<AppointmentSchedule, DateTime> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );
  static Patient? _$patientExpanded(AppointmentSchedule v) => v.patientExpanded;
  static const Field<AppointmentSchedule, Patient> _f$patientExpanded = Field(
    'patientExpanded',
    _$patientExpanded,
    opt: true,
  );

  @override
  final MappableFields<AppointmentSchedule> fields = const {
    #id: _f$id,
    #date: _f$date,
    #hasTime: _f$hasTime,
    #notes: _f$notes,
    #purpose: _f$purpose,
    #status: _f$status,
    #patient: _f$patient,
    #patientRecord: _f$patientRecord,
    #branch: _f$branch,
    #patientName: _f$patientName,
    #ownerName: _f$ownerName,
    #ownerContact: _f$ownerContact,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #patientExpanded: _f$patientExpanded,
  };

  static AppointmentSchedule _instantiate(DecodingData data) {
    return AppointmentSchedule(
      id: data.dec(_f$id),
      date: data.dec(_f$date),
      hasTime: data.dec(_f$hasTime),
      notes: data.dec(_f$notes),
      purpose: data.dec(_f$purpose),
      status: data.dec(_f$status),
      patient: data.dec(_f$patient),
      patientRecord: data.dec(_f$patientRecord),
      branch: data.dec(_f$branch),
      patientName: data.dec(_f$patientName),
      ownerName: data.dec(_f$ownerName),
      ownerContact: data.dec(_f$ownerContact),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
      patientExpanded: data.dec(_f$patientExpanded),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppointmentSchedule fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppointmentSchedule>(map);
  }

  static AppointmentSchedule fromJson(String json) {
    return ensureInitialized().decodeJson<AppointmentSchedule>(json);
  }
}

mixin AppointmentScheduleMappable {
  String toJson() {
    return AppointmentScheduleMapper.ensureInitialized()
        .encodeJson<AppointmentSchedule>(this as AppointmentSchedule);
  }

  Map<String, dynamic> toMap() {
    return AppointmentScheduleMapper.ensureInitialized()
        .encodeMap<AppointmentSchedule>(this as AppointmentSchedule);
  }

  AppointmentScheduleCopyWith<
    AppointmentSchedule,
    AppointmentSchedule,
    AppointmentSchedule
  >
  get copyWith =>
      _AppointmentScheduleCopyWithImpl<
        AppointmentSchedule,
        AppointmentSchedule
      >(this as AppointmentSchedule, $identity, $identity);
  @override
  String toString() {
    return AppointmentScheduleMapper.ensureInitialized().stringifyValue(
      this as AppointmentSchedule,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppointmentScheduleMapper.ensureInitialized().equalsValue(
      this as AppointmentSchedule,
      other,
    );
  }

  @override
  int get hashCode {
    return AppointmentScheduleMapper.ensureInitialized().hashValue(
      this as AppointmentSchedule,
    );
  }
}

extension AppointmentScheduleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppointmentSchedule, $Out> {
  AppointmentScheduleCopyWith<$R, AppointmentSchedule, $Out>
  get $asAppointmentSchedule => $base.as(
    (v, t, t2) => _AppointmentScheduleCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AppointmentScheduleCopyWith<
  $R,
  $In extends AppointmentSchedule,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  PatientCopyWith<$R, Patient, Patient>? get patientExpanded;
  $R call({
    String? id,
    DateTime? date,
    bool? hasTime,
    String? notes,
    String? purpose,
    AppointmentScheduleStatus? status,
    String? patient,
    String? patientRecord,
    String? branch,
    String? patientName,
    String? ownerName,
    String? ownerContact,
    bool? isDeleted,
    DateTime? created,
    DateTime? updated,
    Patient? patientExpanded,
  });
  AppointmentScheduleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppointmentScheduleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppointmentSchedule, $Out>
    implements AppointmentScheduleCopyWith<$R, AppointmentSchedule, $Out> {
  _AppointmentScheduleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppointmentSchedule> $mapper =
      AppointmentScheduleMapper.ensureInitialized();
  @override
  PatientCopyWith<$R, Patient, Patient>? get patientExpanded =>
      $value.patientExpanded?.copyWith.$chain((v) => call(patientExpanded: v));
  @override
  $R call({
    String? id,
    DateTime? date,
    bool? hasTime,
    Object? notes = $none,
    Object? purpose = $none,
    AppointmentScheduleStatus? status,
    Object? patient = $none,
    Object? patientRecord = $none,
    Object? branch = $none,
    Object? patientName = $none,
    Object? ownerName = $none,
    Object? ownerContact = $none,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
    Object? patientExpanded = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (date != null) #date: date,
      if (hasTime != null) #hasTime: hasTime,
      if (notes != $none) #notes: notes,
      if (purpose != $none) #purpose: purpose,
      if (status != null) #status: status,
      if (patient != $none) #patient: patient,
      if (patientRecord != $none) #patientRecord: patientRecord,
      if (branch != $none) #branch: branch,
      if (patientName != $none) #patientName: patientName,
      if (ownerName != $none) #ownerName: ownerName,
      if (ownerContact != $none) #ownerContact: ownerContact,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
      if (patientExpanded != $none) #patientExpanded: patientExpanded,
    }),
  );
  @override
  AppointmentSchedule $make(CopyWithData data) => AppointmentSchedule(
    id: data.get(#id, or: $value.id),
    date: data.get(#date, or: $value.date),
    hasTime: data.get(#hasTime, or: $value.hasTime),
    notes: data.get(#notes, or: $value.notes),
    purpose: data.get(#purpose, or: $value.purpose),
    status: data.get(#status, or: $value.status),
    patient: data.get(#patient, or: $value.patient),
    patientRecord: data.get(#patientRecord, or: $value.patientRecord),
    branch: data.get(#branch, or: $value.branch),
    patientName: data.get(#patientName, or: $value.patientName),
    ownerName: data.get(#ownerName, or: $value.ownerName),
    ownerContact: data.get(#ownerContact, or: $value.ownerContact),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
    patientExpanded: data.get(#patientExpanded, or: $value.patientExpanded),
  );

  @override
  AppointmentScheduleCopyWith<$R2, AppointmentSchedule, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AppointmentScheduleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

