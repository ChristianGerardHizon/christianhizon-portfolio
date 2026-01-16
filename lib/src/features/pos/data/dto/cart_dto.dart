import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../domain/cart.dart';

part 'cart_dto.mapper.dart';

@MappableClass()
class CartDto with CartDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String branch;
  final String status;
  final String? user;
  final num? totalAmount;
  final String? created;
  final String? updated;

  const CartDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.branch,
    required this.status,
    this.user,
    this.totalAmount,
    this.created,
    this.updated,
  });

  factory CartDto.fromRecord(RecordModel record) {
    return CartDto(
      id: record.id,
      collectionId: record.collectionId,
      collectionName: record.collectionName,
      branch: record.getStringValue('branch'),
      status: record.getStringValue('status'),
      user: record.getStringValue('user'),
      totalAmount: record.getDoubleValue('totalAmount'),
      created: record.get<String>('created'),
      updated: record.get<String>('updated'),
    );
  }

  Cart toEntity() {
    return Cart(
      id: id,
      branchId: branch,
      status: status,
      userId: user != null && user!.isNotEmpty ? user : null,
      totalAmount: totalAmount,
      created: created != null ? DateTime.tryParse(created!) : null,
      updated: updated != null ? DateTime.tryParse(updated!) : null,
    );
  }
}
