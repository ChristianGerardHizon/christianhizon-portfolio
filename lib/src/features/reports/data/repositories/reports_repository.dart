import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../../../core/utils/date_utils.dart';
import '../../domain/appointment_report.dart';
import '../../domain/inventory_report.dart';
import '../../domain/patient_report.dart';
import '../../domain/sales_report.dart';
import '../../domain/treatment_plan_report.dart';

part 'reports_repository.g.dart';

/// Repository for fetching and aggregating report data.
abstract class ReportsRepository {
  FutureEither<SalesReport> getSalesReport({
    required DateTime startDate,
    required DateTime endDate,
  });

  FutureEither<PatientReport> getPatientReport({
    required DateTime startDate,
    required DateTime endDate,
  });

  FutureEither<AppointmentReport> getAppointmentReport({
    required DateTime startDate,
    required DateTime endDate,
  });

  FutureEither<InventoryReport> getInventoryReport();

  FutureEither<TreatmentPlanReport> getTreatmentPlanReport({
    required DateTime startDate,
    required DateTime endDate,
  });
}

@Riverpod(keepAlive: true)
ReportsRepository reportsRepository(Ref ref) {
  return ReportsRepositoryImpl(ref.watch(pocketbaseProvider));
}

class ReportsRepositoryImpl implements ReportsRepository {
  final PocketBase _pb;

  ReportsRepositoryImpl(this._pb);

  RecordService get _sales => _pb.collection(PocketBaseCollections.sales);
  RecordService get _saleItems =>
      _pb.collection(PocketBaseCollections.saleItems);
  RecordService get _patients => _pb.collection(PocketBaseCollections.patients);
  RecordService get _appointments =>
      _pb.collection(PocketBaseCollections.appointments);
  RecordService get _products => _pb.collection(PocketBaseCollections.products);
  RecordService get _treatmentPlans =>
      _pb.collection(PocketBaseCollections.treatmentPlans);
  RecordService get _treatmentPlanItems =>
      _pb.collection(PocketBaseCollections.treatmentPlanItems);

  String _dateRangeFilter(DateTime startDate, DateTime endDate) {
    return 'created >= "${startDate.toPocketBaseUtc()}" && created < "${endDate.toPocketBaseUtc()}"';
  }

  @override
  FutureEither<SalesReport> getSalesReport({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return TaskEither.tryCatch(
      () async {
        final filter = _dateRangeFilter(startDate, endDate);

        // Fetch sales within date range
        final sales = await _sales.getFullList(
          filter: filter,
          sort: 'created',
        );

        if (sales.isEmpty) {
          return SalesReport.empty;
        }

        // Fetch all sale items for these sales
        final saleIds = sales.map((s) => s.id).toList();
        final saleItemsFilter =
            saleIds.map((id) => 'sale = "$id"').join(' || ');
        final saleItems = await _saleItems.getFullList(
          filter: saleItemsFilter,
        );

        return _aggregateSalesReport(sales, saleItems);
      },
      Failure.handle,
    ).run();
  }

  SalesReport _aggregateSalesReport(
    List<RecordModel> sales,
    List<RecordModel> saleItems,
  ) {
    // Calculate totals
    final totalRevenue = sales.fold<num>(
      0,
      (sum, s) => sum + (s.getDoubleValue('totalAmount')),
    );
    final transactionCount = sales.length;
    final avgValue = transactionCount > 0 ? totalRevenue / transactionCount : 0;

    // Group by day
    final revenueByDay = <DateTime, num>{};
    for (final sale in sales) {
      final createdStr = sale.getStringValue('created');
      final created = DateTime.tryParse(createdStr)?.toLocal();
      if (created != null) {
        final day = DateTime(created.year, created.month, created.day);
        revenueByDay[day] =
            (revenueByDay[day] ?? 0) + sale.getDoubleValue('totalAmount');
      }
    }

    // Group by payment method
    final revenueByPaymentMethod = <String, num>{};
    for (final sale in sales) {
      final method = sale.getStringValue('paymentMethod');
      if (method.isNotEmpty) {
        revenueByPaymentMethod[method] = (revenueByPaymentMethod[method] ?? 0) +
            sale.getDoubleValue('totalAmount');
      }
    }

    // Top selling products
    final productSales = <String, ({num quantity, num revenue})>{};
    for (final item in saleItems) {
      final name = item.getStringValue('productName');
      if (name.isEmpty) continue;
      final qty = item.getDoubleValue('quantity');
      final subtotal = item.getDoubleValue('subtotal');
      final existing = productSales[name];
      if (existing != null) {
        productSales[name] = (
          quantity: existing.quantity + qty,
          revenue: existing.revenue + subtotal,
        );
      } else {
        productSales[name] = (quantity: qty, revenue: subtotal);
      }
    }

    final topProducts = productSales.entries
        .map((e) => ProductSalesSummary(
              productName: e.key,
              quantity: e.value.quantity,
              revenue: e.value.revenue,
            ))
        .toList()
      ..sort((a, b) => b.revenue.compareTo(a.revenue));

    return SalesReport(
      totalRevenue: totalRevenue,
      transactionCount: transactionCount,
      averageTransactionValue: avgValue,
      revenueByDay: revenueByDay.entries
          .map((e) => DailyRevenue(date: e.key, amount: e.value))
          .toList()
        ..sort((a, b) => a.date.compareTo(b.date)),
      revenueByPaymentMethod: revenueByPaymentMethod,
      topSellingProducts: topProducts.take(10).toList(),
    );
  }

  @override
  FutureEither<PatientReport> getPatientReport({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return TaskEither.tryCatch(
      () async {
        // Fetch all active patients
        final allPatients = await _patients.getFullList(
          filter: 'isDeleted = false',
          expand: 'species',
        );

        // Filter new patients in period
        final newPatientsFilter = _dateRangeFilter(startDate, endDate);
        final newPatients = await _patients.getFullList(
          filter: '$newPatientsFilter && isDeleted = false',
          expand: 'species',
        );

        return _aggregatePatientReport(allPatients, newPatients);
      },
      Failure.handle,
    ).run();
  }

  PatientReport _aggregatePatientReport(
    List<RecordModel> allPatients,
    List<RecordModel> newPatients,
  ) {
    // By species
    final bySpecies = <String, int>{};
    for (final patient in allPatients) {
      final speciesExpanded = patient.get<RecordModel?>('expand.species');
      final speciesName =
          speciesExpanded?.getStringValue('name') ?? 'Unknown';
      bySpecies[speciesName] = (bySpecies[speciesName] ?? 0) + 1;
    }

    // By sex
    final bySex = <String, int>{};
    for (final patient in allPatients) {
      final sex = patient.getStringValue('sex');
      final sexLabel = sex.isEmpty ? 'Unknown' : sex;
      bySex[sexLabel] = (bySex[sexLabel] ?? 0) + 1;
    }

    // Registrations by day
    final registrationsByDay = <DateTime, int>{};
    for (final patient in newPatients) {
      final createdStr = patient.getStringValue('created');
      final created = DateTime.tryParse(createdStr)?.toLocal();
      if (created != null) {
        final day = DateTime(created.year, created.month, created.day);
        registrationsByDay[day] = (registrationsByDay[day] ?? 0) + 1;
      }
    }

    return PatientReport(
      totalPatients: allPatients.length,
      newPatientsInPeriod: newPatients.length,
      patientsBySpecies: bySpecies,
      patientsBySex: bySex,
      registrationsByDay: registrationsByDay.entries
          .map((e) => DailyCount(date: e.key, count: e.value))
          .toList()
        ..sort((a, b) => a.date.compareTo(b.date)),
    );
  }

  @override
  FutureEither<AppointmentReport> getAppointmentReport({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return TaskEither.tryCatch(
      () async {
        // Filter appointments by date field, not created
        final filter =
            'date >= "${startDate.toPocketBaseUtc()}" && date < "${endDate.toPocketBaseUtc()}"';

        final appointments = await _appointments.getFullList(
          filter: filter,
          sort: 'date',
        );

        return _aggregateAppointmentReport(appointments);
      },
      Failure.handle,
    ).run();
  }

  AppointmentReport _aggregateAppointmentReport(List<RecordModel> appointments) {
    var completedCount = 0;
    var scheduledCount = 0;
    var missedCount = 0;
    var cancelledCount = 0;

    final byStatus = <String, int>{};
    final byDay = <DateTime, int>{};
    final byPurpose = <String, int>{};

    for (final apt in appointments) {
      final status = apt.getStringValue('status');

      // Count by status
      switch (status.toLowerCase()) {
        case 'completed':
          completedCount++;
          break;
        case 'scheduled':
          scheduledCount++;
          break;
        case 'missed':
          missedCount++;
          break;
        case 'cancelled':
          cancelledCount++;
          break;
      }

      // By status for pie chart
      if (status.isNotEmpty) {
        byStatus[status] = (byStatus[status] ?? 0) + 1;
      }

      // By day
      final dateStr = apt.getStringValue('date');
      final date = DateTime.tryParse(dateStr)?.toLocal();
      if (date != null) {
        final day = DateTime(date.year, date.month, date.day);
        byDay[day] = (byDay[day] ?? 0) + 1;
      }

      // By purpose
      final purpose = apt.getStringValue('purpose');
      if (purpose.isNotEmpty) {
        byPurpose[purpose] = (byPurpose[purpose] ?? 0) + 1;
      }
    }

    return AppointmentReport(
      totalAppointments: appointments.length,
      completedCount: completedCount,
      scheduledCount: scheduledCount,
      missedCount: missedCount,
      cancelledCount: cancelledCount,
      appointmentsByStatus: byStatus,
      appointmentsByDay: byDay.entries
          .map((e) => DailyCount(date: e.key, count: e.value))
          .toList()
        ..sort((a, b) => a.date.compareTo(b.date)),
      appointmentsByPurpose: byPurpose,
    );
  }

  @override
  FutureEither<InventoryReport> getInventoryReport() async {
    return TaskEither.tryCatch(
      () async {
        final products = await _products.getFullList(
          expand: 'category',
        );

        return _aggregateInventoryReport(products);
      },
      Failure.handle,
    ).run();
  }

  InventoryReport _aggregateInventoryReport(List<RecordModel> products) {
    var inStockCount = 0;
    var lowStockCount = 0;
    var outOfStockCount = 0;
    var expiredCount = 0;
    var nearExpirationCount = 0;
    num totalValue = 0;

    final byCategory = <String, int>{};
    final stockStatus = <String, int>{};
    final lowStockItems = <LowStockItem>[];

    final now = DateTime.now();
    final thirtyDaysFromNow = now.add(const Duration(days: 30));

    for (final product in products) {
      final quantity = product.getDoubleValue('quantity');
      final threshold = product.getDoubleValue('stockThreshold');
      final price = product.getDoubleValue('price');
      final expirationStr = product.getStringValue('expiration');
      final expiration =
          expirationStr.isNotEmpty ? DateTime.tryParse(expirationStr) : null;

      // Calculate inventory value
      totalValue += quantity * price;

      // Stock status
      if (quantity <= 0) {
        outOfStockCount++;
        stockStatus['Out of Stock'] = (stockStatus['Out of Stock'] ?? 0) + 1;
      } else if (threshold > 0 && quantity <= threshold) {
        lowStockCount++;
        stockStatus['Low Stock'] = (stockStatus['Low Stock'] ?? 0) + 1;

        // Add to low stock items list
        final categoryExpanded = product.get<RecordModel?>('expand.category');
        lowStockItems.add(LowStockItem(
          productName: product.getStringValue('name'),
          categoryName: categoryExpanded?.getStringValue('name') ?? 'Uncategorized',
          currentStock: quantity,
          threshold: threshold,
          expirationDate: expiration?.toLocal(),
        ));
      } else {
        inStockCount++;
        stockStatus['In Stock'] = (stockStatus['In Stock'] ?? 0) + 1;
      }

      // Expiration check
      if (expiration != null) {
        if (expiration.isBefore(now)) {
          expiredCount++;
        } else if (expiration.isBefore(thirtyDaysFromNow)) {
          nearExpirationCount++;
        }
      }

      // By category
      final categoryExpanded = product.get<RecordModel?>('expand.category');
      final categoryName =
          categoryExpanded?.getStringValue('name') ?? 'Uncategorized';
      byCategory[categoryName] = (byCategory[categoryName] ?? 0) + 1;
    }

    return InventoryReport(
      totalProducts: products.length,
      inStockCount: inStockCount,
      lowStockCount: lowStockCount,
      outOfStockCount: outOfStockCount,
      expiredCount: expiredCount,
      nearExpirationCount: nearExpirationCount,
      totalInventoryValue: totalValue,
      productsByCategory: byCategory,
      stockStatusBreakdown: stockStatus,
      lowStockItems: lowStockItems,
    );
  }

  @override
  FutureEither<TreatmentPlanReport> getTreatmentPlanReport({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return TaskEither.tryCatch(
      () async {
        final filter = _dateRangeFilter(startDate, endDate);

        final plans = await _treatmentPlans.getFullList(
          filter: filter,
          expand: 'treatment',
        );

        // Get items for overdue count
        final planItems = await _treatmentPlanItems.getFullList();

        return _aggregateTreatmentPlanReport(plans, planItems);
      },
      Failure.handle,
    ).run();
  }

  TreatmentPlanReport _aggregateTreatmentPlanReport(
    List<RecordModel> plans,
    List<RecordModel> planItems,
  ) {
    var activePlans = 0;
    var completedPlans = 0;
    var abandonedPlans = 0;
    double totalProgress = 0;

    final byStatus = <String, int>{};
    final byTreatmentType = <String, int>{};

    for (final plan in plans) {
      final status = plan.getStringValue('status');

      switch (status.toLowerCase()) {
        case 'active':
          activePlans++;
          break;
        case 'completed':
          completedPlans++;
          break;
        case 'abandoned':
          abandonedPlans++;
          break;
      }

      // By status
      if (status.isNotEmpty) {
        byStatus[status] = (byStatus[status] ?? 0) + 1;
      }

      // By treatment type
      final treatmentExpanded = plan.get<RecordModel?>('expand.treatment');
      final treatmentName =
          treatmentExpanded?.getStringValue('name') ?? 'Unknown';
      byTreatmentType[treatmentName] =
          (byTreatmentType[treatmentName] ?? 0) + 1;
    }

    // Calculate average progress for active plans
    if (activePlans > 0) {
      // This is a simplified calculation - ideally we'd calculate from items
      totalProgress = (completedPlans / plans.length) * 100;
    }

    // Count overdue items
    final now = DateTime.now();
    var overdueCount = 0;
    for (final item in planItems) {
      final status = item.getStringValue('status');
      final expectedDateStr = item.getStringValue('expectedDate');
      final expectedDate = DateTime.tryParse(expectedDateStr);

      if (expectedDate != null &&
          expectedDate.isBefore(now) &&
          (status.toLowerCase() == 'scheduled' ||
              status.toLowerCase() == 'booked')) {
        overdueCount++;
      }
    }

    return TreatmentPlanReport(
      totalPlans: plans.length,
      activePlans: activePlans,
      completedPlans: completedPlans,
      abandonedPlans: abandonedPlans,
      averageProgressPercentage: totalProgress,
      plansByStatus: byStatus,
      plansByTreatmentType: byTreatmentType,
      overdueItemsCount: overdueCount,
    );
  }
}
