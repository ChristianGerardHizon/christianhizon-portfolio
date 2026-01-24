// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'treatment_plan_report.dart';

class TreatmentPlanReportMapper extends ClassMapperBase<TreatmentPlanReport> {
  TreatmentPlanReportMapper._();

  static TreatmentPlanReportMapper? _instance;
  static TreatmentPlanReportMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TreatmentPlanReportMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TreatmentPlanReport';

  static int _$totalPlans(TreatmentPlanReport v) => v.totalPlans;
  static const Field<TreatmentPlanReport, int> _f$totalPlans = Field(
    'totalPlans',
    _$totalPlans,
  );
  static int _$activePlans(TreatmentPlanReport v) => v.activePlans;
  static const Field<TreatmentPlanReport, int> _f$activePlans = Field(
    'activePlans',
    _$activePlans,
  );
  static int _$completedPlans(TreatmentPlanReport v) => v.completedPlans;
  static const Field<TreatmentPlanReport, int> _f$completedPlans = Field(
    'completedPlans',
    _$completedPlans,
  );
  static int _$abandonedPlans(TreatmentPlanReport v) => v.abandonedPlans;
  static const Field<TreatmentPlanReport, int> _f$abandonedPlans = Field(
    'abandonedPlans',
    _$abandonedPlans,
  );
  static double _$averageProgressPercentage(TreatmentPlanReport v) =>
      v.averageProgressPercentage;
  static const Field<TreatmentPlanReport, double> _f$averageProgressPercentage =
      Field('averageProgressPercentage', _$averageProgressPercentage);
  static Map<String, int> _$plansByStatus(TreatmentPlanReport v) =>
      v.plansByStatus;
  static const Field<TreatmentPlanReport, Map<String, int>> _f$plansByStatus =
      Field('plansByStatus', _$plansByStatus);
  static Map<String, int> _$plansByTreatmentType(TreatmentPlanReport v) =>
      v.plansByTreatmentType;
  static const Field<TreatmentPlanReport, Map<String, int>>
  _f$plansByTreatmentType = Field(
    'plansByTreatmentType',
    _$plansByTreatmentType,
  );
  static int _$overdueItemsCount(TreatmentPlanReport v) => v.overdueItemsCount;
  static const Field<TreatmentPlanReport, int> _f$overdueItemsCount = Field(
    'overdueItemsCount',
    _$overdueItemsCount,
  );

  @override
  final MappableFields<TreatmentPlanReport> fields = const {
    #totalPlans: _f$totalPlans,
    #activePlans: _f$activePlans,
    #completedPlans: _f$completedPlans,
    #abandonedPlans: _f$abandonedPlans,
    #averageProgressPercentage: _f$averageProgressPercentage,
    #plansByStatus: _f$plansByStatus,
    #plansByTreatmentType: _f$plansByTreatmentType,
    #overdueItemsCount: _f$overdueItemsCount,
  };

  static TreatmentPlanReport _instantiate(DecodingData data) {
    return TreatmentPlanReport(
      totalPlans: data.dec(_f$totalPlans),
      activePlans: data.dec(_f$activePlans),
      completedPlans: data.dec(_f$completedPlans),
      abandonedPlans: data.dec(_f$abandonedPlans),
      averageProgressPercentage: data.dec(_f$averageProgressPercentage),
      plansByStatus: data.dec(_f$plansByStatus),
      plansByTreatmentType: data.dec(_f$plansByTreatmentType),
      overdueItemsCount: data.dec(_f$overdueItemsCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TreatmentPlanReport fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TreatmentPlanReport>(map);
  }

  static TreatmentPlanReport fromJson(String json) {
    return ensureInitialized().decodeJson<TreatmentPlanReport>(json);
  }
}

mixin TreatmentPlanReportMappable {
  String toJson() {
    return TreatmentPlanReportMapper.ensureInitialized()
        .encodeJson<TreatmentPlanReport>(this as TreatmentPlanReport);
  }

  Map<String, dynamic> toMap() {
    return TreatmentPlanReportMapper.ensureInitialized()
        .encodeMap<TreatmentPlanReport>(this as TreatmentPlanReport);
  }

  TreatmentPlanReportCopyWith<
    TreatmentPlanReport,
    TreatmentPlanReport,
    TreatmentPlanReport
  >
  get copyWith =>
      _TreatmentPlanReportCopyWithImpl<
        TreatmentPlanReport,
        TreatmentPlanReport
      >(this as TreatmentPlanReport, $identity, $identity);
  @override
  String toString() {
    return TreatmentPlanReportMapper.ensureInitialized().stringifyValue(
      this as TreatmentPlanReport,
    );
  }

  @override
  bool operator ==(Object other) {
    return TreatmentPlanReportMapper.ensureInitialized().equalsValue(
      this as TreatmentPlanReport,
      other,
    );
  }

  @override
  int get hashCode {
    return TreatmentPlanReportMapper.ensureInitialized().hashValue(
      this as TreatmentPlanReport,
    );
  }
}

extension TreatmentPlanReportValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TreatmentPlanReport, $Out> {
  TreatmentPlanReportCopyWith<$R, TreatmentPlanReport, $Out>
  get $asTreatmentPlanReport => $base.as(
    (v, t, t2) => _TreatmentPlanReportCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class TreatmentPlanReportCopyWith<
  $R,
  $In extends TreatmentPlanReport,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>> get plansByStatus;
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get plansByTreatmentType;
  $R call({
    int? totalPlans,
    int? activePlans,
    int? completedPlans,
    int? abandonedPlans,
    double? averageProgressPercentage,
    Map<String, int>? plansByStatus,
    Map<String, int>? plansByTreatmentType,
    int? overdueItemsCount,
  });
  TreatmentPlanReportCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TreatmentPlanReportCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TreatmentPlanReport, $Out>
    implements TreatmentPlanReportCopyWith<$R, TreatmentPlanReport, $Out> {
  _TreatmentPlanReportCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TreatmentPlanReport> $mapper =
      TreatmentPlanReportMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get plansByStatus => MapCopyWith(
    $value.plansByStatus,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(plansByStatus: v),
  );
  @override
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get plansByTreatmentType => MapCopyWith(
    $value.plansByTreatmentType,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(plansByTreatmentType: v),
  );
  @override
  $R call({
    int? totalPlans,
    int? activePlans,
    int? completedPlans,
    int? abandonedPlans,
    double? averageProgressPercentage,
    Map<String, int>? plansByStatus,
    Map<String, int>? plansByTreatmentType,
    int? overdueItemsCount,
  }) => $apply(
    FieldCopyWithData({
      if (totalPlans != null) #totalPlans: totalPlans,
      if (activePlans != null) #activePlans: activePlans,
      if (completedPlans != null) #completedPlans: completedPlans,
      if (abandonedPlans != null) #abandonedPlans: abandonedPlans,
      if (averageProgressPercentage != null)
        #averageProgressPercentage: averageProgressPercentage,
      if (plansByStatus != null) #plansByStatus: plansByStatus,
      if (plansByTreatmentType != null)
        #plansByTreatmentType: plansByTreatmentType,
      if (overdueItemsCount != null) #overdueItemsCount: overdueItemsCount,
    }),
  );
  @override
  TreatmentPlanReport $make(CopyWithData data) => TreatmentPlanReport(
    totalPlans: data.get(#totalPlans, or: $value.totalPlans),
    activePlans: data.get(#activePlans, or: $value.activePlans),
    completedPlans: data.get(#completedPlans, or: $value.completedPlans),
    abandonedPlans: data.get(#abandonedPlans, or: $value.abandonedPlans),
    averageProgressPercentage: data.get(
      #averageProgressPercentage,
      or: $value.averageProgressPercentage,
    ),
    plansByStatus: data.get(#plansByStatus, or: $value.plansByStatus),
    plansByTreatmentType: data.get(
      #plansByTreatmentType,
      or: $value.plansByTreatmentType,
    ),
    overdueItemsCount: data.get(
      #overdueItemsCount,
      or: $value.overdueItemsCount,
    ),
  );

  @override
  TreatmentPlanReportCopyWith<$R2, TreatmentPlanReport, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _TreatmentPlanReportCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

