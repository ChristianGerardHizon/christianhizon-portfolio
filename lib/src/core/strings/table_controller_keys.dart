import 'package:fpdart/fpdart.dart';

class TableControllerKeys {
  static String patientTreatment = 'PATIENT_TREATMENT';
  static String product = 'PRODUCT';
  static String productInventory = 'PRODUCT_INVENTORY';
  static String productStock = 'PRODUCT_STOCK';
  static String productStockProduct(String x) => '${productStock}_${x}';
  static String patient = 'PATIENT';
  static String patientRecord = 'PATIENT_RECORD';
  static String patientRecordPatient(String? x) {
    if (x == null) return patientRecord;
    return '${patientRecord}_${x}';
  }

  static String patientTreatmentRecord = 'PATIENT_TREATMENT_RECORD';
  static String patientTreatmentRecordPatient(String x) =>
      '${patientTreatmentRecord}_${x}';
  static String branch = 'BRANCH';
  static String admin = 'ADMIN';
  static String user = 'USER';
  static String changeLog = 'CHANGE_LOG';
  static String productCategory = 'PRODUCT_CATEGORY';
  static String patientBreed = 'PATIENT_BREED';
  static String patientSpecies = 'PATIENT_SPECIES';
  static String appointmentSchedule = 'APPOINTMENT_SCHEDULE';
  static String appointmentScheduleToday = 'APPOINTMENT_SCHEDULE_TODAY';

  static String appointmentSchedulePatient({String? id, DateTime? date}) {
    return Option.of(appointmentSchedule)
            // 1. append id if not null  sample. APPOINTMENT_SCHEDULE_123
            .map((f) => _combineString(f, id))
            // 2. append date if not null sample. APPOINTMENT_SCHEDULE_123_2025-05-15
            .map((f) => _combineDate(f, date))
            // 3. convert to nullable
            .toNullable() ??
        '';
  }

  static String patientFile = 'PATIENT_FILE';
  static String patientFilePatient(String x) => '${patientFile}_${x}';
}

String _combineString(String parent, String? optional) {
  if (optional == null) return parent;
  return '${parent}_${optional}';
}

String _combineDate(String parent, DateTime? optional) {
  if (optional == null) return parent;
  return '${parent}_${optional.year}-${optional.month}-${optional.day}';
}
