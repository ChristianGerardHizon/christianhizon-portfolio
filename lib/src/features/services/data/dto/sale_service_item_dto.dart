import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../../core/utils/date_utils.dart';
import '../../domain/sale_service_item.dart';
import 'service_dto.dart';

part 'sale_service_item_dto.mapper.dart';

@MappableClass()
class SaleServiceItemDto with SaleServiceItemDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String sale;
  final String service;
  final String serviceName;
  final num quantity;
  final num unitPrice;
  final num subtotal;
  final String? created;
  final String? updated;

  const SaleServiceItemDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.sale,
    required this.service,
    required this.serviceName,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
    this.created,
    this.updated,
  });

  factory SaleServiceItemDto.fromRecord(RecordModel record) {
    return SaleServiceItemDto(
      id: record.id,
      collectionId: record.collectionId,
      collectionName: record.collectionName,
      sale: record.getStringValue('sale'),
      service: record.getStringValue('service'),
      serviceName: record.getStringValue('serviceName'),
      quantity: record.getDoubleValue('quantity'),
      unitPrice: record.getDoubleValue('unitPrice'),
      subtotal: record.getDoubleValue('subtotal'),
      created: record.get<String>('created'),
      updated: record.get<String>('updated'),
    );
  }

  SaleServiceItem toEntity({RecordModel? serviceExpanded}) {
    return SaleServiceItem(
      id: id,
      saleId: sale,
      serviceId: service,
      serviceName: serviceName,
      quantity: quantity,
      unitPrice: unitPrice,
      subtotal: subtotal,
      service: serviceExpanded != null
          ? ServiceDto.fromRecord(serviceExpanded).toEntity()
          : null,
      created: parseToLocal(created),
      updated: parseToLocal(updated),
    );
  }
}
