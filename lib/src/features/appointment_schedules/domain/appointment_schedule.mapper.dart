// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
      MapperContainer.globals
          .use(_instance = AppointmentScheduleStatusMapper._());
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
      PbRecordMapper.ensureInitialized();
      AppointmentScheduleStatusMapper.ensureInitialized();
      AppointmentScheduleExpandMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AppointmentSchedule';

  static String _$id(AppointmentSchedule v) => v.id;
  static const Field<AppointmentSchedule, String> _f$id = Field('id', _$id);
  static String _$collectionId(AppointmentSchedule v) => v.collectionId;
  static const Field<AppointmentSchedule, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(AppointmentSchedule v) => v.collectionName;
  static const Field<AppointmentSchedule, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static bool _$isDeleted(AppointmentSchedule v) => v.isDeleted;
  static const Field<AppointmentSchedule, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static DateTime? _$created(AppointmentSchedule v) => v.created;
  static const Field<AppointmentSchedule, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(AppointmentSchedule v) => v.updated;
  static const Field<AppointmentSchedule, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);
  static DateTime _$date(AppointmentSchedule v) => v.date;
  static const Field<AppointmentSchedule, DateTime> _f$date =
      Field('date', _$date, hook: DateTimeHook());
  static String? _$patientRecord(AppointmentSchedule v) => v.patientRecord;
  static const Field<AppointmentSchedule, String> _f$patientRecord =
      Field('patientRecord', _$patientRecord, opt: true);
  static String? _$purpose(AppointmentSchedule v) => v.purpose;
  static const Field<AppointmentSchedule, String> _f$purpose =
      Field('purpose', _$purpose, opt: true);
  static AppointmentScheduleStatus _$status(AppointmentSchedule v) => v.status;
  static const Field<AppointmentSchedule, AppointmentScheduleStatus> _f$status =
      Field('status', _$status);
  static bool _$hasTime(AppointmentSchedule v) => v.hasTime;
  static const Field<AppointmentSchedule, bool> _f$hasTime =
      Field('hasTime', _$hasTime, opt: true, def: false);
  static AppointmentScheduleExpand _$expand(AppointmentSchedule v) => v.expand;
  static const Field<AppointmentSchedule, AppointmentScheduleExpand> _f$expand =
      Field('expand', _$expand);

  @override
  final MappableFields<AppointmentSchedule> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #date: _f$date,
    #patientRecord: _f$patientRecord,
    #purpose: _f$purpose,
    #status: _f$status,
    #hasTime: _f$hasTime,
    #expand: _f$expand,
  };

  static AppointmentSchedule _instantiate(DecodingData data) {
    return AppointmentSchedule(
        id: data.dec(_f$id),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        isDeleted: data.dec(_f$isDeleted),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated),
        date: data.dec(_f$date),
        patientRecord: data.dec(_f$patientRecord),
        purpose: data.dec(_f$purpose),
        status: data.dec(_f$status),
        hasTime: data.dec(_f$hasTime),
        expand: data.dec(_f$expand));
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

  AppointmentScheduleCopyWith<AppointmentSchedule, AppointmentSchedule,
      AppointmentSchedule> get copyWith => _AppointmentScheduleCopyWithImpl<
          AppointmentSchedule, AppointmentSchedule>(
      this as AppointmentSchedule, $identity, $identity);
  @override
  String toString() {
    return AppointmentScheduleMapper.ensureInitialized()
        .stringifyValue(this as AppointmentSchedule);
  }

  @override
  bool operator ==(Object other) {
    return AppointmentScheduleMapper.ensureInitialized()
        .equalsValue(this as AppointmentSchedule, other);
  }

  @override
  int get hashCode {
    return AppointmentScheduleMapper.ensureInitialized()
        .hashValue(this as AppointmentSchedule);
  }
}

extension AppointmentScheduleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppointmentSchedule, $Out> {
  AppointmentScheduleCopyWith<$R, AppointmentSchedule, $Out>
      get $asAppointmentSchedule => $base.as(
          (v, t, t2) => _AppointmentScheduleCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AppointmentScheduleCopyWith<$R, $In extends AppointmentSchedule,
    $Out> implements PbRecordCopyWith<$R, $In, $Out> {
  AppointmentScheduleExpandCopyWith<$R, AppointmentScheduleExpand,
      AppointmentScheduleExpand> get expand;
  @override
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      bool? isDeleted,
      DateTime? created,
      DateTime? updated,
      DateTime? date,
      String? patientRecord,
      String? purpose,
      AppointmentScheduleStatus? status,
      bool? hasTime,
      AppointmentScheduleExpand? expand});
  AppointmentScheduleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AppointmentScheduleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppointmentSchedule, $Out>
    implements AppointmentScheduleCopyWith<$R, AppointmentSchedule, $Out> {
  _AppointmentScheduleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppointmentSchedule> $mapper =
      AppointmentScheduleMapper.ensureInitialized();
  @override
  AppointmentScheduleExpandCopyWith<$R, AppointmentScheduleExpand,
          AppointmentScheduleExpand>
      get expand => $value.expand.copyWith.$chain((v) => call(expand: v));
  @override
  $R call(
          {String? id,
          String? collectionId,
          String? collectionName,
          bool? isDeleted,
          Object? created = $none,
          Object? updated = $none,
          DateTime? date,
          Object? patientRecord = $none,
          Object? purpose = $none,
          AppointmentScheduleStatus? status,
          bool? hasTime,
          AppointmentScheduleExpand? expand}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName,
        if (isDeleted != null) #isDeleted: isDeleted,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated,
        if (date != null) #date: date,
        if (patientRecord != $none) #patientRecord: patientRecord,
        if (purpose != $none) #purpose: purpose,
        if (status != null) #status: status,
        if (hasTime != null) #hasTime: hasTime,
        if (expand != null) #expand: expand
      }));
  @override
  AppointmentSchedule $make(CopyWithData data) => AppointmentSchedule(
      id: data.get(#id, or: $value.id),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated),
      date: data.get(#date, or: $value.date),
      patientRecord: data.get(#patientRecord, or: $value.patientRecord),
      purpose: data.get(#purpose, or: $value.purpose),
      status: data.get(#status, or: $value.status),
      hasTime: data.get(#hasTime, or: $value.hasTime),
      expand: data.get(#expand, or: $value.expand));

  @override
  AppointmentScheduleCopyWith<$R2, AppointmentSchedule, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _AppointmentScheduleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AppointmentScheduleExpandMapper
    extends ClassMapperBase<AppointmentScheduleExpand> {
  AppointmentScheduleExpandMapper._();

  static AppointmentScheduleExpandMapper? _instance;
  static AppointmentScheduleExpandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = AppointmentScheduleExpandMapper._());
      PatientMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AppointmentScheduleExpand';

  static Patient? _$patient(AppointmentScheduleExpand v) => v.patient;
  static const Field<AppointmentScheduleExpand, Patient> _f$patient =
      Field('patient', _$patient, opt: true);

  @override
  final MappableFields<AppointmentScheduleExpand> fields = const {
    #patient: _f$patient,
  };

  static AppointmentScheduleExpand _instantiate(DecodingData data) {
    return AppointmentScheduleExpand(patient: data.dec(_f$patient));
  }

  @override
  final Function instantiate = _instantiate;

  static AppointmentScheduleExpand fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppointmentScheduleExpand>(map);
  }

  static AppointmentScheduleExpand fromJson(String json) {
    return ensureInitialized().decodeJson<AppointmentScheduleExpand>(json);
  }
}

mixin AppointmentScheduleExpandMappable {
  String toJson() {
    return AppointmentScheduleExpandMapper.ensureInitialized()
        .encodeJson<AppointmentScheduleExpand>(
            this as AppointmentScheduleExpand);
  }

  Map<String, dynamic> toMap() {
    return AppointmentScheduleExpandMapper.ensureInitialized()
        .encodeMap<AppointmentScheduleExpand>(
            this as AppointmentScheduleExpand);
  }

  AppointmentScheduleExpandCopyWith<AppointmentScheduleExpand,
          AppointmentScheduleExpand, AppointmentScheduleExpand>
      get copyWith => _AppointmentScheduleExpandCopyWithImpl<
              AppointmentScheduleExpand, AppointmentScheduleExpand>(
          this as AppointmentScheduleExpand, $identity, $identity);
  @override
  String toString() {
    return AppointmentScheduleExpandMapper.ensureInitialized()
        .stringifyValue(this as AppointmentScheduleExpand);
  }

  @override
  bool operator ==(Object other) {
    return AppointmentScheduleExpandMapper.ensureInitialized()
        .equalsValue(this as AppointmentScheduleExpand, other);
  }

  @override
  int get hashCode {
    return AppointmentScheduleExpandMapper.ensureInitialized()
        .hashValue(this as AppointmentScheduleExpand);
  }
}

extension AppointmentScheduleExpandValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppointmentScheduleExpand, $Out> {
  AppointmentScheduleExpandCopyWith<$R, AppointmentScheduleExpand, $Out>
      get $asAppointmentScheduleExpand => $base.as((v, t, t2) =>
          _AppointmentScheduleExpandCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AppointmentScheduleExpandCopyWith<
    $R,
    $In extends AppointmentScheduleExpand,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  PatientCopyWith<$R, Patient, Patient>? get patient;
  $R call({Patient? patient});
  AppointmentScheduleExpandCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AppointmentScheduleExpandCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppointmentScheduleExpand, $Out>
    implements
        AppointmentScheduleExpandCopyWith<$R, AppointmentScheduleExpand, $Out> {
  _AppointmentScheduleExpandCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppointmentScheduleExpand> $mapper =
      AppointmentScheduleExpandMapper.ensureInitialized();
  @override
  PatientCopyWith<$R, Patient, Patient>? get patient =>
      $value.patient?.copyWith.$chain((v) => call(patient: v));
  @override
  $R call({Object? patient = $none}) =>
      $apply(FieldCopyWithData({if (patient != $none) #patient: patient}));
  @override
  AppointmentScheduleExpand $make(CopyWithData data) =>
      AppointmentScheduleExpand(
          patient: data.get(#patient, or: $value.patient));

  @override
  AppointmentScheduleExpandCopyWith<$R2, AppointmentScheduleExpand, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _AppointmentScheduleExpandCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
