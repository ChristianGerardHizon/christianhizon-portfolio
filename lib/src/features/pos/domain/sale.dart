import 'package:dart_mappable/dart_mappable.dart';

part 'sale.mapper.dart';

/// Sale domain model.
///
/// Represents a finalized transaction/receipt.
@MappableClass()
class Sale with SaleMappable {
  const Sale({
    required this.id,
    required this.receiptNumber,
    required this.branchId,
    required this.cashierId,
    required this.totalAmount,
    required this.paymentMethod,
    required this.status,
    this.customerId,
    this.paymentRef,
    this.notes,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// Human-readable receipt number.
  final String receiptNumber;

  /// Branch ID where sale occurred.
  final String branchId;

  /// Cashier User ID.
  final String cashierId;

  /// Total amount charged.
  final num totalAmount;

  /// Payment method (cash, card, etc.).
  final String paymentMethod;

  /// Transaction status.
  final String status;

  /// Customer/Patient ID (optional).
  final String? customerId;

  /// External payment reference.
  final String? paymentRef;

  /// Internal notes.
  final String? notes;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;
}
