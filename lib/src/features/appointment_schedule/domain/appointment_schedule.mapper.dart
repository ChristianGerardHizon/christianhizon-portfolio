// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'appointment_schedule.dart';

class AppointmentScheduleMapper extends ClassMapperBase<AppointmentSchedule> {
  AppointmentScheduleMapper._();

  static AppointmentScheduleMapper? _instance;
  static AppointmentScheduleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppointmentScheduleMapper._());
      PbRecordMapper.ensureInitialized();
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
  static DateTime _$date(AppointmentSchedule v) => v.date;
  static const Field<AppointmentSchedule, DateTime> _f$date =
      Field('date', _$date, hook: DateTimeHook());
  static String? _$purpose(AppointmentSchedule v) => v.purpose;
  static const Field<AppointmentSchedule, String> _f$purpose =
      Field('purpose', _$purpose, opt: true);
  static bool _$isCompleted(AppointmentSchedule v) => v.isCompleted;
  static const Field<AppointmentSchedule, bool> _f$isCompleted =
      Field('isCompleted', _$isCompleted, opt: true, def: false);
  static bool _$hasTime(AppointmentSchedule v) => v.hasTime;
  static const Field<AppointmentSchedule, bool> _f$hasTime =
      Field('hasTime', _$hasTime, opt: true, def: false);
  static bool _$isDeleted(AppointmentSchedule v) => v.isDeleted;
  static const Field<AppointmentSchedule, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static DateTime? _$created(AppointmentSchedule v) => v.created;
  static const Field<AppointmentSchedule, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(AppointmentSchedule v) => v.updated;
  static const Field<AppointmentSchedule, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);

  @override
  final MappableFields<AppointmentSchedule> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #date: _f$date,
    #purpose: _f$purpose,
    #isCompleted: _f$isCompleted,
    #hasTime: _f$hasTime,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static AppointmentSchedule _instantiate(DecodingData data) {
    return AppointmentSchedule(
        id: data.dec(_f$id),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        date: data.dec(_f$date),
        purpose: data.dec(_f$purpose),
        isCompleted: data.dec(_f$isCompleted),
        hasTime: data.dec(_f$hasTime),
        isDeleted: data.dec(_f$isDeleted),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
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
  @override
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      DateTime? date,
      String? purpose,
      bool? isCompleted,
      bool? hasTime,
      bool? isDeleted,
      DateTime? created,
      DateTime? updated});
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
  $R call(
          {String? id,
          String? collectionId,
          String? collectionName,
          DateTime? date,
          Object? purpose = $none,
          bool? isCompleted,
          bool? hasTime,
          bool? isDeleted,
          Object? created = $none,
          Object? updated = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName,
        if (date != null) #date: date,
        if (purpose != $none) #purpose: purpose,
        if (isCompleted != null) #isCompleted: isCompleted,
        if (hasTime != null) #hasTime: hasTime,
        if (isDeleted != null) #isDeleted: isDeleted,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated
      }));
  @override
  AppointmentSchedule $make(CopyWithData data) => AppointmentSchedule(
      id: data.get(#id, or: $value.id),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      date: data.get(#date, or: $value.date),
      purpose: data.get(#purpose, or: $value.purpose),
      isCompleted: data.get(#isCompleted, or: $value.isCompleted),
      hasTime: data.get(#hasTime, or: $value.hasTime),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  AppointmentScheduleCopyWith<$R2, AppointmentSchedule, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _AppointmentScheduleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
