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
  static const String printerConfigs = 'printerConfigs';

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
  static const String productAdjustments = 'productAdjustments';

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
  static const String messageTemplates = 'messageTemplates';

  // Treatment Plans
  static const String treatmentTemplates = 'treatmentTemplates';
  static const String treatmentPlans = 'treatmentPlans';
  static const String treatmentPlanItems = 'treatmentPlanItems';

  // View Collections (SQL Views for optimized queries)
  static const String vwInventoryStatus = 'vw_inventory_status';
  static const String vwSalesDailySummary = 'vw_sales_daily_summary';
  static const String vwTopSellingProducts = 'vw_top_selling_products';
  static const String vwTodaysAppointments = 'vw_todays_appointments';
  static const String vwTodaysSales = 'vw_todays_sales';
  static const String vwActivePatientsCount = 'vw_active_patients_count';
  static const String vwPatientStatistics = 'vw_patient_statistics';
  static const String vwNewPatientsByDate = 'vw_new_patients_by_date';
  static const String vwAppointmentSummary = 'vw_appointment_summary';
  static const String vwLotQuantityTotals = 'vw_lot_quantity_totals';
  static const String vwTreatmentPlanSummary = 'vw_treatment_plan_summary';
  static const String vwOverdueTreatmentItems = 'vw_overdue_treatment_items';
  static const String vwLowStockProducts = 'vw_low_stock_products';
  static const String vwLowStockLotProducts = 'vw_low_stock_lot_products';
  static const String vwExpiredLots = 'vw_expired_lots';
  static const String vwNearExpirationLots = 'vw_near_expiration_lots';
  static const String vwMessagesPending = 'vw_messages_pending';
}
