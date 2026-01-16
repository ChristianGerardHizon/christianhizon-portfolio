import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

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
  final String? customer;
  final String? paymentRef;
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
    this.customer,
    this.paymentRef,
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
      customer: record.getStringValue('customer'),
      paymentRef: record.getStringValue('paymentRef'),
      notes: record.getStringValue('notes'),
      created: record.get<String>('created'),
      updated: record.get<String>('updated'),
    );
  }

  Sale toEntity() {
    return Sale(
      id: id,
      receiptNumber: receiptNumber,
      branchId: branch,
      cashierId: cashier,
      totalAmount: totalAmount,
      paymentMethod: paymentMethod,
      status: status,
      customerId: customer != null && customer!.isNotEmpty ? customer : null,
      paymentRef: paymentRef,
      notes: notes,
      created: created != null ? DateTime.tryParse(created!) : null,
      updated: updated != null ? DateTime.tryParse(updated!) : null,
    );
  }
}
