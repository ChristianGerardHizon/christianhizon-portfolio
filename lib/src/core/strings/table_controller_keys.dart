class TableControllerKeys {
  static String patientTreatment = 'PATIENT_TREATMENT';
  static String product = 'PRODUCT';
  static String productInventory = 'PRODUCT_INVENTORY';
  static String productStock = 'PRODUCT_STOCK';
  static String productStockProduct(String x) => '${productStock}_${x}';
  static String patient = 'PATIENT';
  static String patientRecord = 'PATIENT_RECORD';
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
  static String appointmentSchedulePatient(String x) =>
      '${appointmentSchedule}_${x}';
  static String patientFile = 'PATIENT_FILE';
  static String patientFilePatient(String x) => '${patientFile}_${x}';
}
