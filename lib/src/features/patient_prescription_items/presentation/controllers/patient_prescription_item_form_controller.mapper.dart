// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient_prescription_item_form_controller.dart';

class PatientPrescriptionItemFormStateMapper
    extends ClassMapperBase<PatientPrescriptionItemFormState> {
  PatientPrescriptionItemFormStateMapper._();

  static PatientPrescriptionItemFormStateMapper? _instance;
  static PatientPrescriptionItemFormStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = PatientPrescriptionItemFormStateMapper._());
      PatientPrescriptionItemMapper.ensureInitialized();
      PatientRecordMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PatientPrescriptionItemFormState';

  static PatientPrescriptionItem? _$patientPrescriptionItem(
          PatientPrescriptionItemFormState v) =>
      v.patientPrescriptionItem;
  static const Field<PatientPrescriptionItemFormState, PatientPrescriptionItem>
      _f$patientPrescriptionItem =
      Field('patientPrescriptionItem', _$patientPrescriptionItem, opt: true);
  static PatientRecord _$patientRecord(PatientPrescriptionItemFormState v) =>
      v.patientRecord;
  static const Field<PatientPrescriptionItemFormState, PatientRecord>
      _f$patientRecord = Field('patientRecord', _$patientRecord);

  @override
  final MappableFields<PatientPrescriptionItemFormState> fields = const {
    #patientPrescriptionItem: _f$patientPrescriptionItem,
    #patientRecord: _f$patientRecord,
  };

  static PatientPrescriptionItemFormState _instantiate(DecodingData data) {
    return PatientPrescriptionItemFormState(
        patientPrescriptionItem: data.dec(_f$patientPrescriptionItem),
        patientRecord: data.dec(_f$patientRecord));
  }

  @override
  final Function instantiate = _instantiate;

  static PatientPrescriptionItemFormState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PatientPrescriptionItemFormState>(map);
  }

  static PatientPrescriptionItemFormState fromJson(String json) {
    return ensureInitialized()
        .decodeJson<PatientPrescriptionItemFormState>(json);
  }
}

mixin PatientPrescriptionItemFormStateMappable {
  String toJson() {
    return PatientPrescriptionItemFormStateMapper.ensureInitialized()
        .encodeJson<PatientPrescriptionItemFormState>(
            this as PatientPrescriptionItemFormState);
  }

  Map<String, dynamic> toMap() {
    return PatientPrescriptionItemFormStateMapper.ensureInitialized()
        .encodeMap<PatientPrescriptionItemFormState>(
            this as PatientPrescriptionItemFormState);
  }

  PatientPrescriptionItemFormStateCopyWith<PatientPrescriptionItemFormState,
          PatientPrescriptionItemFormState, PatientPrescriptionItemFormState>
      get copyWith => _PatientPrescriptionItemFormStateCopyWithImpl<
              PatientPrescriptionItemFormState,
              PatientPrescriptionItemFormState>(
          this as PatientPrescriptionItemFormState, $identity, $identity);
  @override
  String toString() {
    return PatientPrescriptionItemFormStateMapper.ensureInitialized()
        .stringifyValue(this as PatientPrescriptionItemFormState);
  }

  @override
  bool operator ==(Object other) {
    return PatientPrescriptionItemFormStateMapper.ensureInitialized()
        .equalsValue(this as PatientPrescriptionItemFormState, other);
  }

  @override
  int get hashCode {
    return PatientPrescriptionItemFormStateMapper.ensureInitialized()
        .hashValue(this as PatientPrescriptionItemFormState);
  }
}

extension PatientPrescriptionItemFormStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PatientPrescriptionItemFormState, $Out> {
  PatientPrescriptionItemFormStateCopyWith<$R, PatientPrescriptionItemFormState,
          $Out>
      get $asPatientPrescriptionItemFormState => $base.as((v, t, t2) =>
          _PatientPrescriptionItemFormStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientPrescriptionItemFormStateCopyWith<
    $R,
    $In extends PatientPrescriptionItemFormState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  PatientPrescriptionItemCopyWith<$R, PatientPrescriptionItem,
      PatientPrescriptionItem>? get patientPrescriptionItem;
  PatientRecordCopyWith<$R, PatientRecord, PatientRecord> get patientRecord;
  $R call(
      {PatientPrescriptionItem? patientPrescriptionItem,
      PatientRecord? patientRecord});
  PatientPrescriptionItemFormStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PatientPrescriptionItemFormStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PatientPrescriptionItemFormState, $Out>
    implements
        PatientPrescriptionItemFormStateCopyWith<$R,
            PatientPrescriptionItemFormState, $Out> {
  _PatientPrescriptionItemFormStateCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PatientPrescriptionItemFormState> $mapper =
      PatientPrescriptionItemFormStateMapper.ensureInitialized();
  @override
  PatientPrescriptionItemCopyWith<$R, PatientPrescriptionItem,
          PatientPrescriptionItem>?
      get patientPrescriptionItem => $value.patientPrescriptionItem?.copyWith
          .$chain((v) => call(patientPrescriptionItem: v));
  @override
  PatientRecordCopyWith<$R, PatientRecord, PatientRecord> get patientRecord =>
      $value.patientRecord.copyWith.$chain((v) => call(patientRecord: v));
  @override
  $R call(
          {Object? patientPrescriptionItem = $none,
          PatientRecord? patientRecord}) =>
      $apply(FieldCopyWithData({
        if (patientPrescriptionItem != $none)
          #patientPrescriptionItem: patientPrescriptionItem,
        if (patientRecord != null) #patientRecord: patientRecord
      }));
  @override
  PatientPrescriptionItemFormState $make(CopyWithData data) =>
      PatientPrescriptionItemFormState(
          patientPrescriptionItem: data.get(#patientPrescriptionItem,
              or: $value.patientPrescriptionItem),
          patientRecord: data.get(#patientRecord, or: $value.patientRecord));

  @override
  PatientPrescriptionItemFormStateCopyWith<$R2,
      PatientPrescriptionItemFormState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PatientPrescriptionItemFormStateCopyWithImpl<$R2, $Out2>(
          $value, $cast, t);
}
