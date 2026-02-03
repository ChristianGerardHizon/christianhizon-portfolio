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
    this.isPaid = false,
    this.isPickedUp = false,
    this.pickedUpAt,
    this.customerId,
    this.customerName,
    this.paymentRef,
    this.paymentProofUrl,
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

  /// Whether the customer has paid.
  final bool isPaid;

  /// Whether the order has been picked up.
  final bool isPickedUp;

  /// Timestamp when the order was picked up.
  final DateTime? pickedUpAt;

  /// Linked customer ID (optional).
  final String? customerId;

  /// Customer name (for display).
  final String? customerName;

  /// External payment reference.
  final String? paymentRef;

  /// URL of the payment proof image (screenshot of transaction).
  final String? paymentProofUrl;

  /// Internal notes.
  final String? notes;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;

  /// Returns display name for customer.
  String? get customerDisplay => customerName;
}
