// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'appointment_report.dart';

class AppointmentReportMapper extends ClassMapperBase<AppointmentReport> {
  AppointmentReportMapper._();

  static AppointmentReportMapper? _instance;
  static AppointmentReportMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppointmentReportMapper._());
      DailyCountMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AppointmentReport';

  static int _$totalAppointments(AppointmentReport v) => v.totalAppointments;
  static const Field<AppointmentReport, int> _f$totalAppointments = Field(
    'totalAppointments',
    _$totalAppointments,
  );
  static int _$completedCount(AppointmentReport v) => v.completedCount;
  static const Field<AppointmentReport, int> _f$completedCount = Field(
    'completedCount',
    _$completedCount,
  );
  static int _$scheduledCount(AppointmentReport v) => v.scheduledCount;
  static const Field<AppointmentReport, int> _f$scheduledCount = Field(
    'scheduledCount',
    _$scheduledCount,
  );
  static int _$missedCount(AppointmentReport v) => v.missedCount;
  static const Field<AppointmentReport, int> _f$missedCount = Field(
    'missedCount',
    _$missedCount,
  );
  static int _$cancelledCount(AppointmentReport v) => v.cancelledCount;
  static const Field<AppointmentReport, int> _f$cancelledCount = Field(
    'cancelledCount',
    _$cancelledCount,
  );
  static Map<String, int> _$appointmentsByStatus(AppointmentReport v) =>
      v.appointmentsByStatus;
  static const Field<AppointmentReport, Map<String, int>>
  _f$appointmentsByStatus = Field(
    'appointmentsByStatus',
    _$appointmentsByStatus,
  );
  static List<DailyCount> _$appointmentsByDay(AppointmentReport v) =>
      v.appointmentsByDay;
  static const Field<AppointmentReport, List<DailyCount>> _f$appointmentsByDay =
      Field('appointmentsByDay', _$appointmentsByDay);
  static Map<String, int> _$appointmentsByPurpose(AppointmentReport v) =>
      v.appointmentsByPurpose;
  static const Field<AppointmentReport, Map<String, int>>
  _f$appointmentsByPurpose = Field(
    'appointmentsByPurpose',
    _$appointmentsByPurpose,
  );

  @override
  final MappableFields<AppointmentReport> fields = const {
    #totalAppointments: _f$totalAppointments,
    #completedCount: _f$completedCount,
    #scheduledCount: _f$scheduledCount,
    #missedCount: _f$missedCount,
    #cancelledCount: _f$cancelledCount,
    #appointmentsByStatus: _f$appointmentsByStatus,
    #appointmentsByDay: _f$appointmentsByDay,
    #appointmentsByPurpose: _f$appointmentsByPurpose,
  };

  static AppointmentReport _instantiate(DecodingData data) {
    return AppointmentReport(
      totalAppointments: data.dec(_f$totalAppointments),
      completedCount: data.dec(_f$completedCount),
      scheduledCount: data.dec(_f$scheduledCount),
      missedCount: data.dec(_f$missedCount),
      cancelledCount: data.dec(_f$cancelledCount),
      appointmentsByStatus: data.dec(_f$appointmentsByStatus),
      appointmentsByDay: data.dec(_f$appointmentsByDay),
      appointmentsByPurpose: data.dec(_f$appointmentsByPurpose),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppointmentReport fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppointmentReport>(map);
  }

  static AppointmentReport fromJson(String json) {
    return ensureInitialized().decodeJson<AppointmentReport>(json);
  }
}

mixin AppointmentReportMappable {
  String toJson() {
    return AppointmentReportMapper.ensureInitialized()
        .encodeJson<AppointmentReport>(this as AppointmentReport);
  }

  Map<String, dynamic> toMap() {
    return AppointmentReportMapper.ensureInitialized()
        .encodeMap<AppointmentReport>(this as AppointmentReport);
  }

  AppointmentReportCopyWith<
    AppointmentReport,
    AppointmentReport,
    AppointmentReport
  >
  get copyWith =>
      _AppointmentReportCopyWithImpl<AppointmentReport, AppointmentReport>(
        this as AppointmentReport,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AppointmentReportMapper.ensureInitialized().stringifyValue(
      this as AppointmentReport,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppointmentReportMapper.ensureInitialized().equalsValue(
      this as AppointmentReport,
      other,
    );
  }

  @override
  int get hashCode {
    return AppointmentReportMapper.ensureInitialized().hashValue(
      this as AppointmentReport,
    );
  }
}

extension AppointmentReportValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppointmentReport, $Out> {
  AppointmentReportCopyWith<$R, AppointmentReport, $Out>
  get $asAppointmentReport => $base.as(
    (v, t, t2) => _AppointmentReportCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AppointmentReportCopyWith<
  $R,
  $In extends AppointmentReport,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get appointmentsByStatus;
  ListCopyWith<$R, DailyCount, DailyCountCopyWith<$R, DailyCount, DailyCount>>
  get appointmentsByDay;
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get appointmentsByPurpose;
  $R call({
    int? totalAppointments,
    int? completedCount,
    int? scheduledCount,
    int? missedCount,
    int? cancelledCount,
    Map<String, int>? appointmentsByStatus,
    List<DailyCount>? appointmentsByDay,
    Map<String, int>? appointmentsByPurpose,
  });
  AppointmentReportCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppointmentReportCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppointmentReport, $Out>
    implements AppointmentReportCopyWith<$R, AppointmentReport, $Out> {
  _AppointmentReportCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppointmentReport> $mapper =
      AppointmentReportMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get appointmentsByStatus => MapCopyWith(
    $value.appointmentsByStatus,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(appointmentsByStatus: v),
  );
  @override
  ListCopyWith<$R, DailyCount, DailyCountCopyWith<$R, DailyCount, DailyCount>>
  get appointmentsByDay => ListCopyWith(
    $value.appointmentsByDay,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(appointmentsByDay: v),
  );
  @override
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get appointmentsByPurpose => MapCopyWith(
    $value.appointmentsByPurpose,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(appointmentsByPurpose: v),
  );
  @override
  $R call({
    int? totalAppointments,
    int? completedCount,
    int? scheduledCount,
    int? missedCount,
    int? cancelledCount,
    Map<String, int>? appointmentsByStatus,
    List<DailyCount>? appointmentsByDay,
    Map<String, int>? appointmentsByPurpose,
  }) => $apply(
    FieldCopyWithData({
      if (totalAppointments != null) #totalAppointments: totalAppointments,
      if (completedCount != null) #completedCount: completedCount,
      if (scheduledCount != null) #scheduledCount: scheduledCount,
      if (missedCount != null) #missedCount: missedCount,
      if (cancelledCount != null) #cancelledCount: cancelledCount,
      if (appointmentsByStatus != null)
        #appointmentsByStatus: appointmentsByStatus,
      if (appointmentsByDay != null) #appointmentsByDay: appointmentsByDay,
      if (appointmentsByPurpose != null)
        #appointmentsByPurpose: appointmentsByPurpose,
    }),
  );
  @override
  AppointmentReport $make(CopyWithData data) => AppointmentReport(
    totalAppointments: data.get(
      #totalAppointments,
      or: $value.totalAppointments,
    ),
    completedCount: data.get(#completedCount, or: $value.completedCount),
    scheduledCount: data.get(#scheduledCount, or: $value.scheduledCount),
    missedCount: data.get(#missedCount, or: $value.missedCount),
    cancelledCount: data.get(#cancelledCount, or: $value.cancelledCount),
    appointmentsByStatus: data.get(
      #appointmentsByStatus,
      or: $value.appointmentsByStatus,
    ),
    appointmentsByDay: data.get(
      #appointmentsByDay,
      or: $value.appointmentsByDay,
    ),
    appointmentsByPurpose: data.get(
      #appointmentsByPurpose,
      or: $value.appointmentsByPurpose,
    ),
  );

  @override
  AppointmentReportCopyWith<$R2, AppointmentReport, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AppointmentReportCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

