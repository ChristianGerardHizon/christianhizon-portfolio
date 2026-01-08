// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_treatment_record_form_controller.dart';

class PatientTreatmentRecordFormStateMapper
    extends ClassMapperBase<PatientTreatmentRecordFormState> {
  PatientTreatmentRecordFormStateMapper._();

  static PatientTreatmentRecordFormStateMapper? _instance;
  static PatientTreatmentRecordFormStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = PatientTreatmentRecordFormStateMapper._(),
      );
      PatientTreatmentRecordMapper.ensureInitialized();
      PatientMapper.ensureInitialized();
      BranchMapper.ensureInitialized();
      PatientTreatmentMapper.ensureInitialized();
      AuthDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PatientTreatmentRecordFormState';

  static PatientTreatmentRecord? _$patientTreatmentRecord(
    PatientTreatmentRecordFormState v,
  ) => v.patientTreatmentRecord;
  static const Field<PatientTreatmentRecordFormState, PatientTreatmentRecord>
  _f$patientTreatmentRecord = Field(
    'patientTreatmentRecord',
    _$patientTreatmentRecord,
  );
  static Patient _$patient(PatientTreatmentRecordFormState v) => v.patient;
  static const Field<PatientTreatmentRecordFormState, Patient> _f$patient =
      Field('patient', _$patient);
  static List<Branch> _$branches(PatientTreatmentRecordFormState v) =>
      v.branches;
  static const Field<PatientTreatmentRecordFormState, List<Branch>>
  _f$branches = Field('branches', _$branches, opt: true, def: const []);
  static List<PatientTreatment> _$patientTreatments(
    PatientTreatmentRecordFormState v,
  ) => v.patientTreatments;
  static const Field<PatientTreatmentRecordFormState, List<PatientTreatment>>
  _f$patientTreatments = Field(
    'patientTreatments',
    _$patientTreatments,
    opt: true,
    def: const [],
  );
  static AuthData _$auth(PatientTreatmentRecordFormState v) => v.auth;
  static const Field<PatientTreatmentRecordFormState, AuthData> _f$auth = Field(
    'auth',
    _$auth,
  );

  @override
  final MappableFields<PatientTreatmentRecordFormState> fields = const {
    #patientTreatmentRecord: _f$patientTreatmentRecord,
    #patient: _f$patient,
    #branches: _f$branches,
    #patientTreatments: _f$patientTreatments,
    #auth: _f$auth,
  };

  static PatientTreatmentRecordFormState _instantiate(DecodingData data) {
    return PatientTreatmentRecordFormState(
      patientTreatmentRecord: data.dec(_f$patientTreatmentRecord),
      patient: data.dec(_f$patient),
      branches: data.dec(_f$branches),
      patientTreatments: data.dec(_f$patientTreatments),
      auth: data.dec(_f$auth),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PatientTreatmentRecordFormState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientTreatmentRecordFormState>(map);
  }

  static PatientTreatmentRecordFormState fromJson(String json) {
    return ensureInitialized().decodeJson<PatientTreatmentRecordFormState>(
      json,
    );
  }
}

mixin PatientTreatmentRecordFormStateMappable {
  String toJson() {
    return PatientTreatmentRecordFormStateMapper.ensureInitialized()
        .encodeJson<PatientTreatmentRecordFormState>(
          this as PatientTreatmentRecordFormState,
        );
  }

  Map<String, dynamic> toMap() {
    return PatientTreatmentRecordFormStateMapper.ensureInitialized()
        .encodeMap<PatientTreatmentRecordFormState>(
          this as PatientTreatmentRecordFormState,
        );
  }

  PatientTreatmentRecordFormStateCopyWith<
    PatientTreatmentRecordFormState,
    PatientTreatmentRecordFormState,
    PatientTreatmentRecordFormState
  >
  get copyWith =>
      _PatientTreatmentRecordFormStateCopyWithImpl<
        PatientTreatmentRecordFormState,
        PatientTreatmentRecordFormState
      >(this as PatientTreatmentRecordFormState, $identity, $identity);
  @override
  String toString() {
    return PatientTreatmentRecordFormStateMapper.ensureInitialized()
        .stringifyValue(this as PatientTreatmentRecordFormState);
  }

  @override
  bool operator ==(Object other) {
    return PatientTreatmentRecordFormStateMapper.ensureInitialized()
        .equalsValue(this as PatientTreatmentRecordFormState, other);
  }

  @override
  int get hashCode {
    return PatientTreatmentRecordFormStateMapper.ensureInitialized().hashValue(
      this as PatientTreatmentRecordFormState,
    );
  }
}

extension PatientTreatmentRecordFormStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientTreatmentRecordFormState, $Out> {
  PatientTreatmentRecordFormStateCopyWith<
    $R,
    PatientTreatmentRecordFormState,
    $Out
  >
  get $asPatientTreatmentRecordFormState => $base.as(
    (v, t, t2) =>
        _PatientTreatmentRecordFormStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PatientTreatmentRecordFormStateCopyWith<
  $R,
  $In extends PatientTreatmentRecordFormState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  PatientTreatmentRecordCopyWith<
    $R,
    PatientTreatmentRecord,
    PatientTreatmentRecord
  >?
  get patientTreatmentRecord;
  PatientCopyWith<$R, Patient, Patient> get patient;
  ListCopyWith<$R, Branch, BranchCopyWith<$R, Branch, Branch>> get branches;
  ListCopyWith<
    $R,
    PatientTreatment,
    PatientTreatmentCopyWith<$R, PatientTreatment, PatientTreatment>
  >
  get patientTreatments;
  $R call({
    PatientTreatmentRecord? patientTreatmentRecord,
    Patient? patient,
    List<Branch>? branches,
    List<PatientTreatment>? patientTreatments,
    AuthData? auth,
  });
  PatientTreatmentRecordFormStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PatientTreatmentRecordFormStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientTreatmentRecordFormState, $Out>
    implements
        PatientTreatmentRecordFormStateCopyWith<
          $R,
          PatientTreatmentRecordFormState,
          $Out
        > {
  _PatientTreatmentRecordFormStateCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<PatientTreatmentRecordFormState> $mapper =
      PatientTreatmentRecordFormStateMapper.ensureInitialized();
  @override
  PatientTreatmentRecordCopyWith<
    $R,
    PatientTreatmentRecord,
    PatientTreatmentRecord
  >?
  get patientTreatmentRecord => $value.patientTreatmentRecord?.copyWith.$chain(
    (v) => call(patientTreatmentRecord: v),
  );
  @override
  PatientCopyWith<$R, Patient, Patient> get patient =>
      $value.patient.copyWith.$chain((v) => call(patient: v));
  @override
  ListCopyWith<$R, Branch, BranchCopyWith<$R, Branch, Branch>> get branches =>
      ListCopyWith(
        $value.branches,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(branches: v),
      );
  @override
  ListCopyWith<
    $R,
    PatientTreatment,
    PatientTreatmentCopyWith<$R, PatientTreatment, PatientTreatment>
  >
  get patientTreatments => ListCopyWith(
    $value.patientTreatments,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(patientTreatments: v),
  );
  @override
  $R call({
    Object? patientTreatmentRecord = $none,
    Patient? patient,
    List<Branch>? branches,
    List<PatientTreatment>? patientTreatments,
    AuthData? auth,
  }) => $apply(
    FieldCopyWithData({
      if (patientTreatmentRecord != $none)
        #patientTreatmentRecord: patientTreatmentRecord,
      if (patient != null) #patient: patient,
      if (branches != null) #branches: branches,
      if (patientTreatments != null) #patientTreatments: patientTreatments,
      if (auth != null) #auth: auth,
    }),
  );
  @override
  PatientTreatmentRecordFormState $make(CopyWithData data) =>
      PatientTreatmentRecordFormState(
        patientTreatmentRecord: data.get(
          #patientTreatmentRecord,
          or: $value.patientTreatmentRecord,
        ),
        patient: data.get(#patient, or: $value.patient),
        branches: data.get(#branches, or: $value.branches),
        patientTreatments: data.get(
          #patientTreatments,
          or: $value.patientTreatments,
        ),
        auth: data.get(#auth, or: $value.auth),
      );

  @override
  PatientTreatmentRecordFormStateCopyWith<
    $R2,
    PatientTreatmentRecordFormState,
    $Out2
  >
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PatientTreatmentRecordFormStateCopyWithImpl<$R2, $Out2>(
        $value,
        $cast,
        t,
      );
}

