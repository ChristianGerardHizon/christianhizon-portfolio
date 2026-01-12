/// PocketBase collection names used throughout the application.
///
/// Centralizes collection name constants to avoid typos and
/// make refactoring easier.
abstract class PocketBaseCollections {
  // Authentication
  static const String users = 'users';
  static const String userRoles = 'user_roles';

  // Organization
  static const String branches = 'branches';

  // Patients
  static const String patients = 'patients';
  static const String patientSpecies = 'patient_species';
  static const String patientBreeds = 'patient_breeds';
  static const String patientRecords = 'patient_records';
  static const String patientFiles = 'patient_files';
  static const String patientTreatments = 'patient_treatments';
  static const String patientTreatmentRecords = 'patient_treatment_records';
  static const String patientPrescriptionItems = 'patient_prescription_items';

  // Products
  static const String products = 'products';
  static const String productCategories = 'productCategories';
  static const String productStocks = 'productStocks';

  // Appointments
  static const String appointments = 'appointments';

  // Sales
  static const String sales = 'sales';
  static const String saleItems = 'saleItems';
}
