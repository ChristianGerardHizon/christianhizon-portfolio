// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'treatment_plan_item_status.dart';

class TreatmentPlanItemStatusMapper
    extends EnumMapper<TreatmentPlanItemStatus> {
  TreatmentPlanItemStatusMapper._();

  static TreatmentPlanItemStatusMapper? _instance;
  static TreatmentPlanItemStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = TreatmentPlanItemStatusMapper._(),
      );
    }
    return _instance!;
  }

  static TreatmentPlanItemStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  TreatmentPlanItemStatus decode(dynamic value) {
    switch (value) {
      case r'scheduled':
        return TreatmentPlanItemStatus.scheduled;
      case r'booked':
        return TreatmentPlanItemStatus.booked;
      case r'completed':
        return TreatmentPlanItemStatus.completed;
      case r'missed':
        return TreatmentPlanItemStatus.missed;
      case r'skipped':
        return TreatmentPlanItemStatus.skipped;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(TreatmentPlanItemStatus self) {
    switch (self) {
      case TreatmentPlanItemStatus.scheduled:
        return r'scheduled';
      case TreatmentPlanItemStatus.booked:
        return r'booked';
      case TreatmentPlanItemStatus.completed:
        return r'completed';
      case TreatmentPlanItemStatus.missed:
        return r'missed';
      case TreatmentPlanItemStatus.skipped:
        return r'skipped';
    }
  }
}

extension TreatmentPlanItemStatusMapperExtension on TreatmentPlanItemStatus {
  String toValue() {
    TreatmentPlanItemStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<TreatmentPlanItemStatus>(this)
        as String;
  }
}

