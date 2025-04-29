import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';

class PatientSexHook extends MappingHook {
  const PatientSexHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is String) {
      if (value.isEmpty) return null;
      return PatientSexMapper.fromValue(value);
    }
    return value;
  }
}
