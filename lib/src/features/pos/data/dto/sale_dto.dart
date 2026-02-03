import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../../core/utils/date_utils.dart';
import '../../domain/sale.dart';

part 'sale_dto.mapper.dart';

@MappableClass()
class SaleDto with SaleDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String receiptNumber;
  final String branch;
  final String cashier;
  final num totalAmount;
  final String paymentMethod;
  final String status;
  final bool isPaid;
  final bool isPickedUp;
  final String? pickedUpAt;
  final String? customer;
  final String? customerName;
  final String? paymentRef;
  final String? paymentProof;
  final String? notes;
  final String? created;
  final String? updated;

  const SaleDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.receiptNumber,
    required this.branch,
    required this.cashier,
    required this.totalAmount,
    required this.paymentMethod,
    required this.status,
    this.isPaid = false,
    this.isPickedUp = false,
    this.pickedUpAt,
    this.customer,
    this.customerName,
    this.paymentRef,
    this.paymentProof,
    this.notes,
    this.created,
    this.updated,
  });

  factory SaleDto.fromRecord(RecordModel record) {
    return SaleDto(
      id: record.id,
      collectionId: record.collectionId,
      collectionName: record.collectionName,
      receiptNumber: record.getStringValue('receiptNumber'),
      branch: record.getStringValue('branch'),
      cashier: record.getStringValue('cashier'),
      totalAmount: record.getDoubleValue('totalAmount'),
      paymentMethod: record.getStringValue('paymentMethod'),
      status: record.getStringValue('status'),
      isPaid: record.getBoolValue('isPaid'),
      isPickedUp: record.getBoolValue('isPickedUp'),
      pickedUpAt: record.get<String>('pickedUpAt'),
      customer: record.getStringValue('customer'),
      customerName: record.getStringValue('customerName'),
      paymentRef: record.getStringValue('paymentRef'),
      paymentProof: record.getStringValue('paymentProof'),
      notes: record.getStringValue('notes'),
      created: record.get<String>('created'),
      updated: record.get<String>('updated'),
    );
  }

  Sale toEntity({String? baseUrl}) {
    return Sale(
      id: id,
      receiptNumber: receiptNumber,
      branchId: branch,
      cashierId: cashier,
      totalAmount: totalAmount,
      paymentMethod: paymentMethod,
      status: status,
      isPaid: isPaid,
      isPickedUp: isPickedUp,
      pickedUpAt: parseToLocal(pickedUpAt),
      customerId: customer != null && customer!.isNotEmpty ? customer : null,
      customerName: customerName != null && customerName!.isNotEmpty ? customerName : null,
      paymentRef: paymentRef,
      paymentProofUrl: _buildPaymentProofUrl(baseUrl),
      notes: notes,
      created: parseToLocal(created),
      updated: parseToLocal(updated),
    );
  }

  String? _buildPaymentProofUrl(String? baseUrl) {
    if (paymentProof == null || paymentProof!.isEmpty || baseUrl == null) {
      return null;
    }
    return '$baseUrl/api/files/$collectionName/$id/$paymentProof';
  }
}
