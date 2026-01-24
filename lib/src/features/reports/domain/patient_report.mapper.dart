// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_report.dart';

class PatientReportMapper extends ClassMapperBase<PatientReport> {
  PatientReportMapper._();

  static PatientReportMapper? _instance;
  static PatientReportMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientReportMapper._());
      DailyCountMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PatientReport';

  static int _$totalPatients(PatientReport v) => v.totalPatients;
  static const Field<PatientReport, int> _f$totalPatients = Field(
    'totalPatients',
    _$totalPatients,
  );
  static int _$newPatientsInPeriod(PatientReport v) => v.newPatientsInPeriod;
  static const Field<PatientReport, int> _f$newPatientsInPeriod = Field(
    'newPatientsInPeriod',
    _$newPatientsInPeriod,
  );
  static Map<String, int> _$patientsBySpecies(PatientReport v) =>
      v.patientsBySpecies;
  static const Field<PatientReport, Map<String, int>> _f$patientsBySpecies =
      Field('patientsBySpecies', _$patientsBySpecies);
  static Map<String, int> _$patientsBySex(PatientReport v) => v.patientsBySex;
  static const Field<PatientReport, Map<String, int>> _f$patientsBySex = Field(
    'patientsBySex',
    _$patientsBySex,
  );
  static List<DailyCount> _$registrationsByDay(PatientReport v) =>
      v.registrationsByDay;
  static const Field<PatientReport, List<DailyCount>> _f$registrationsByDay =
      Field('registrationsByDay', _$registrationsByDay);

  @override
  final MappableFields<PatientReport> fields = const {
    #totalPatients: _f$totalPatients,
    #newPatientsInPeriod: _f$newPatientsInPeriod,
    #patientsBySpecies: _f$patientsBySpecies,
    #patientsBySex: _f$patientsBySex,
    #registrationsByDay: _f$registrationsByDay,
  };

  static PatientReport _instantiate(DecodingData data) {
    return PatientReport(
      totalPatients: data.dec(_f$totalPatients),
      newPatientsInPeriod: data.dec(_f$newPatientsInPeriod),
      patientsBySpecies: data.dec(_f$patientsBySpecies),
      patientsBySex: data.dec(_f$patientsBySex),
      registrationsByDay: data.dec(_f$registrationsByDay),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PatientReport fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientReport>(map);
  }

  static PatientReport fromJson(String json) {
    return ensureInitialized().decodeJson<PatientReport>(json);
  }
}

mixin PatientReportMappable {
  String toJson() {
    return PatientReportMapper.ensureInitialized().encodeJson<PatientReport>(
      this as PatientReport,
    );
  }

  Map<String, dynamic> toMap() {
    return PatientReportMapper.ensureInitialized().encodeMap<PatientReport>(
      this as PatientReport,
    );
  }

  PatientReportCopyWith<PatientReport, PatientReport, PatientReport>
  get copyWith => _PatientReportCopyWithImpl<PatientReport, PatientReport>(
    this as PatientReport,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return PatientReportMapper.ensureInitialized().stringifyValue(
      this as PatientReport,
    );
  }

  @override
  bool operator ==(Object other) {
    return PatientReportMapper.ensureInitialized().equalsValue(
      this as PatientReport,
      other,
    );
  }

  @override
  int get hashCode {
    return PatientReportMapper.ensureInitialized().hashValue(
      this as PatientReport,
    );
  }
}

extension PatientReportValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientReport, $Out> {
  PatientReportCopyWith<$R, PatientReport, $Out> get $asPatientReport =>
      $base.as((v, t, t2) => _PatientReportCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientReportCopyWith<$R, $In extends PatientReport, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get patientsBySpecies;
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>> get patientsBySex;
  ListCopyWith<$R, DailyCount, DailyCountCopyWith<$R, DailyCount, DailyCount>>
  get registrationsByDay;
  $R call({
    int? totalPatients,
    int? newPatientsInPeriod,
    Map<String, int>? patientsBySpecies,
    Map<String, int>? patientsBySex,
    List<DailyCount>? registrationsByDay,
  });
  PatientReportCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PatientReportCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientReport, $Out>
    implements PatientReportCopyWith<$R, PatientReport, $Out> {
  _PatientReportCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientReport> $mapper =
      PatientReportMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get patientsBySpecies => MapCopyWith(
    $value.patientsBySpecies,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(patientsBySpecies: v),
  );
  @override
  MapCopyWith<$R, String, int, ObjectCopyWith<$R, int, int>>
  get patientsBySex => MapCopyWith(
    $value.patientsBySex,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(patientsBySex: v),
  );
  @override
  ListCopyWith<$R, DailyCount, DailyCountCopyWith<$R, DailyCount, DailyCount>>
  get registrationsByDay => ListCopyWith(
    $value.registrationsByDay,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(registrationsByDay: v),
  );
  @override
  $R call({
    int? totalPatients,
    int? newPatientsInPeriod,
    Map<String, int>? patientsBySpecies,
    Map<String, int>? patientsBySex,
    List<DailyCount>? registrationsByDay,
  }) => $apply(
    FieldCopyWithData({
      if (totalPatients != null) #totalPatients: totalPatients,
      if (newPatientsInPeriod != null)
        #newPatientsInPeriod: newPatientsInPeriod,
      if (patientsBySpecies != null) #patientsBySpecies: patientsBySpecies,
      if (patientsBySex != null) #patientsBySex: patientsBySex,
      if (registrationsByDay != null) #registrationsByDay: registrationsByDay,
    }),
  );
  @override
  PatientReport $make(CopyWithData data) => PatientReport(
    totalPatients: data.get(#totalPatients, or: $value.totalPatients),
    newPatientsInPeriod: data.get(
      #newPatientsInPeriod,
      or: $value.newPatientsInPeriod,
    ),
    patientsBySpecies: data.get(
      #patientsBySpecies,
      or: $value.patientsBySpecies,
    ),
    patientsBySex: data.get(#patientsBySex, or: $value.patientsBySex),
    registrationsByDay: data.get(
      #registrationsByDay,
      or: $value.registrationsByDay,
    ),
  );

  @override
  PatientReportCopyWith<$R2, PatientReport, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PatientReportCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DailyCountMapper extends ClassMapperBase<DailyCount> {
  DailyCountMapper._();

  static DailyCountMapper? _instance;
  static DailyCountMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DailyCountMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DailyCount';

  static DateTime _$date(DailyCount v) => v.date;
  static const Field<DailyCount, DateTime> _f$date = Field('date', _$date);
  static int _$count(DailyCount v) => v.count;
  static const Field<DailyCount, int> _f$count = Field('count', _$count);

  @override
  final MappableFields<DailyCount> fields = const {
    #date: _f$date,
    #count: _f$count,
  };

  static DailyCount _instantiate(DecodingData data) {
    return DailyCount(date: data.dec(_f$date), count: data.dec(_f$count));
  }

  @override
  final Function instantiate = _instantiate;

  static DailyCount fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DailyCount>(map);
  }

  static DailyCount fromJson(String json) {
    return ensureInitialized().decodeJson<DailyCount>(json);
  }
}

mixin DailyCountMappable {
  String toJson() {
    return DailyCountMapper.ensureInitialized().encodeJson<DailyCount>(
      this as DailyCount,
    );
  }

  Map<String, dynamic> toMap() {
    return DailyCountMapper.ensureInitialized().encodeMap<DailyCount>(
      this as DailyCount,
    );
  }

  DailyCountCopyWith<DailyCount, DailyCount, DailyCount> get copyWith =>
      _DailyCountCopyWithImpl<DailyCount, DailyCount>(
        this as DailyCount,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DailyCountMapper.ensureInitialized().stringifyValue(
      this as DailyCount,
    );
  }

  @override
  bool operator ==(Object other) {
    return DailyCountMapper.ensureInitialized().equalsValue(
      this as DailyCount,
      other,
    );
  }

  @override
  int get hashCode {
    return DailyCountMapper.ensureInitialized().hashValue(this as DailyCount);
  }
}

extension DailyCountValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DailyCount, $Out> {
  DailyCountCopyWith<$R, DailyCount, $Out> get $asDailyCount =>
      $base.as((v, t, t2) => _DailyCountCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DailyCountCopyWith<$R, $In extends DailyCount, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({DateTime? date, int? count});
  DailyCountCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DailyCountCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DailyCount, $Out>
    implements DailyCountCopyWith<$R, DailyCount, $Out> {
  _DailyCountCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DailyCount> $mapper =
      DailyCountMapper.ensureInitialized();
  @override
  $R call({DateTime? date, int? count}) => $apply(
    FieldCopyWithData({
      if (date != null) #date: date,
      if (count != null) #count: count,
    }),
  );
  @override
  DailyCount $make(CopyWithData data) => DailyCount(
    date: data.get(#date, or: $value.date),
    count: data.get(#count, or: $value.count),
  );

  @override
  DailyCountCopyWith<$R2, DailyCount, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DailyCountCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

