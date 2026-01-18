/// PocketBase collection names used throughout the application.
///
/// Centralizes collection name constants to avoid typos and
/// make refactoring easier.
abstract class PocketBaseCollections {
  // Authentication
  static const String users = 'users';
  static const String userRoles = 'userRoles';

  // Organization
  static const String branches = 'branches';

  // Patients
  static const String patients = 'patients';
  static const String patientSpecies = 'patientSpecies';
  static const String patientBreeds = 'patientBreeds';
  static const String patientRecords = 'patientRecords';
  static const String patientFiles = 'patientFiles';
  static const String patientTreatments = 'patientTreatments';
  static const String patientTreatmentRecords = 'patientTreatmentRecords';
  static const String patientPrescriptionItems = 'patientPrescriptionItems';

  // Products
  static const String products = 'products';
  static const String productCategories = 'productCategories';
  static const String productStocks = 'productStocks';
  static const String productLots = 'productLots';

  // Appointments
  static const String appointments = 'appointmentSchedules';

  // Carts
  static const String carts = 'carts';
  static const String cartItems = 'cartItems';

  // Sales
  static const String sales = 'sales';
  static const String saleItems = 'saleItems';

  // Messages
  static const String messages = 'messages';
}
