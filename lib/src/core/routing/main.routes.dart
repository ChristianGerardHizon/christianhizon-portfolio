import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sannjosevet/src/core/pages/more_page.dart';
import 'package:sannjosevet/src/core/pages/not_found_page.dart';
import 'package:sannjosevet/src/core/pages/splash_page.dart';
import 'package:sannjosevet/src/core/pages/app_root.dart';

import 'package:sannjosevet/src/core/pages/work_in_progress_page.dart';
import 'package:sannjosevet/src/core/routing/routes/_root.routes.dart';
import 'package:sannjosevet/src/core/routing/router.dart'
    show TypeRouteData, rootKey;
import 'package:sannjosevet/src/features/organization/admins/presentation/pages/admin_page.dart';
import 'package:sannjosevet/src/features/organization/admins/presentation/pages/admin_form_page.dart';
import 'package:sannjosevet/src/features/organization/admins/presentation/pages/admins_page.dart';
import 'package:sannjosevet/src/features/appointments/schedules/presentation/pages/appointment_schedule_calendar_page.dart';
import 'package:sannjosevet/src/features/appointments/schedules/presentation/pages/appointment_schedule_form_page.dart';
import 'package:sannjosevet/src/features/appointments/schedules/presentation/pages/appointment_schedule_page.dart';
import 'package:sannjosevet/src/features/appointments/schedules/presentation/pages/appointment_schedules_page.dart';
import 'package:sannjosevet/src/features/appointments/schedules/presentation/pages/appointment_schedules_by_date_page.dart'
    show AppointmentSchedulesByDatePage;
import 'package:sannjosevet/src/features/system/authentication/presentation/controllers/auth_controller.dart';
import 'package:sannjosevet/src/features/system/authentication/presentation/pages/account_page.dart';
import 'package:sannjosevet/src/features/system/authentication/presentation/pages/account_recovery_page.dart';
import 'package:sannjosevet/src/features/system/authentication/presentation/pages/admin_login_page.dart';
import 'package:sannjosevet/src/features/system/authentication/presentation/pages/email_validation_page.dart';
import 'package:sannjosevet/src/features/system/authentication/presentation/pages/user_login_page.dart';
import 'package:sannjosevet/src/features/organization/branches/presentation/pages/branch_form_page.dart';
import 'package:sannjosevet/src/features/organization/branches/presentation/pages/branch_page.dart';
import 'package:sannjosevet/src/features/organization/branches/presentation/pages/branches_page.dart';
import 'package:sannjosevet/src/features/system/change_logs/presentation/pages/change_log_form_page.dart';
import 'package:sannjosevet/src/features/system/change_logs/presentation/pages/change_log_page.dart';
import 'package:sannjosevet/src/features/system/change_logs/presentation/pages/change_logs_page.dart';
import 'package:sannjosevet/src/features/system/dashboard/presentation/pages/dashboard_page.dart';
import 'package:sannjosevet/src/features/patients/breeds/presentation/pages/patient_breed_form_page.dart';
import 'package:sannjosevet/src/features/patients/files/presentation/pages/patient_file_form_page.dart';
import 'package:sannjosevet/src/features/patients/prescriptions/presentation/pages/patient_prescription_item_form_page.dart';
import 'package:sannjosevet/src/features/patients/records/presentation/pages/patient_record_form_page.dart';
import 'package:sannjosevet/src/features/patients/records/presentation/pages/patient_record_page.dart';
import 'package:sannjosevet/src/features/patients/species/presentation/pages/patient_species_form_page.dart';
import 'package:sannjosevet/src/features/patients/species/presentation/pages/patient_species_list_page.dart';
import 'package:sannjosevet/src/features/patients/species/presentation/pages/patient_species_page.dart';
import 'package:sannjosevet/src/features/patients/treatment_records/presentation/pages/patient_treatment_record_form_page.dart';
import 'package:sannjosevet/src/features/patients/treatment_records/presentation/pages/patient_treatment_record_page.dart';
import 'package:sannjosevet/src/features/patients/treatment_records/presentation/pages/patient_treatment_records_page.dart';
import 'package:sannjosevet/src/features/patients/treatments/presentation/pages/patient_treatment_form_page.dart';
import 'package:sannjosevet/src/features/patients/treatments/presentation/pages/patient_treatments_page.dart';
import 'package:sannjosevet/src/features/patients/core/presentation/pages/patient_form_page.dart';
import 'package:sannjosevet/src/features/patients/core/presentation/pages/patient_page.dart';
import 'package:sannjosevet/src/features/patients/core/presentation/pages/patients_page.dart';
import 'package:sannjosevet/src/features/products/adjustments/presentation/pages/product_adjustments_page.dart';
import 'package:sannjosevet/src/features/products/categories/presentation/pages/product_categories_page.dart';
import 'package:sannjosevet/src/features/products/categories/presentation/pages/product_category_form_page.dart';
import 'package:sannjosevet/src/features/products/categories/presentation/pages/product_category_page.dart';
import 'package:sannjosevet/src/features/products/adjustments/presentation/pages/product_adjustment_form_page.dart';
import 'package:sannjosevet/src/features/products/core/presentation/pages/product_page.dart';
import 'package:sannjosevet/src/features/products/core/presentation/pages/products_page.dart';
import 'package:sannjosevet/src/features/products/core/presentation/pages/product_form_page.dart';
import 'package:sannjosevet/src/features/products/inventories/presentation/pages/product_inventories_page.dart';
import 'package:sannjosevet/src/features/products/stocks/presentation/pages/product_stock_form_page.dart';
import 'package:sannjosevet/src/features/products/stocks/presentation/pages/product_stock_page.dart';
import 'package:sannjosevet/src/features/system/settings/presentation/pages/domain_page.dart';
import 'package:sannjosevet/src/features/system/settings/presentation/pages/settings_page.dart';
import 'package:sannjosevet/src/features/organization/users/presentation/pages/user_form_page.dart';
import 'package:sannjosevet/src/features/organization/users/presentation/pages/user_page.dart';
import 'package:sannjosevet/src/features/organization/users/presentation/pages/users_page.dart';
import 'package:sannjosevet/src/features/system/authentication/presentation/pages/your_account_page.dart';

part 'main.routes.g.dart';

// Core routes
part 'routes/common.routes.dart';
part 'routes/dashboard.routes.dart';
part 'routes/others.routes.dart';
part 'routes/sales.routes.dart';

// Consolidated domain routes
part 'routes/organization/organization.routes.dart';
part 'routes/system/system.routes.dart';
part 'routes/appointments/appointments.routes.dart';

// Patients routes
part 'routes/patients/patients.routes.dart';
part 'routes/patients/patient_config.routes.dart';

// Products routes
part 'routes/products/products.routes.dart';
