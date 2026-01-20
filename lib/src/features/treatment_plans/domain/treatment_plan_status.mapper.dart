// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'treatment_plan_status.dart';

class TreatmentPlanStatusMapper extends EnumMapper<TreatmentPlanStatus> {
  TreatmentPlanStatusMapper._();

  static TreatmentPlanStatusMapper? _instance;
  static TreatmentPlanStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TreatmentPlanStatusMapper._());
    }
    return _instance!;
  }

  static TreatmentPlanStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  TreatmentPlanStatus decode(dynamic value) {
    switch (value) {
      case r'active':
        return TreatmentPlanStatus.active;
      case r'completed':
        return TreatmentPlanStatus.completed;
      case r'cancelled':
        return TreatmentPlanStatus.cancelled;
      case r'onHold':
        return TreatmentPlanStatus.onHold;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(TreatmentPlanStatus self) {
    switch (self) {
      case TreatmentPlanStatus.active:
        return r'active';
      case TreatmentPlanStatus.completed:
        return r'completed';
      case TreatmentPlanStatus.cancelled:
        return r'cancelled';
      case TreatmentPlanStatus.onHold:
        return r'onHold';
    }
  }
}

extension TreatmentPlanStatusMapperExtension on TreatmentPlanStatus {
  String toValue() {
    TreatmentPlanStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<TreatmentPlanStatus>(this) as String;
  }
}

