import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../../core/utils/date_utils.dart';
import '../../../products/data/dto/product_dto.dart';
import '../../domain/cart_item.dart';

part 'cart_item_dto.mapper.dart';

@MappableClass()
class CartItemDto with CartItemDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String cart;
  final String product;
  final num quantity;
  final String? productLot;
  final String? lotNumber;
  final String? created;
  final String? updated;

  const CartItemDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.cart,
    required this.product,
    required this.quantity,
    this.productLot,
    this.lotNumber,
    this.created,
    this.updated,
  });

  factory CartItemDto.fromRecord(RecordModel record) {
    // Handle lotNumber which might be stored as string or number
    final rawLotNumber = record.data['lotNumber'];
    String? lotNumber;
    if (rawLotNumber != null && rawLotNumber.toString().isNotEmpty) {
      lotNumber = rawLotNumber.toString();
      // Filter out "0" or empty values that indicate no lot
      if (lotNumber == '0' || lotNumber.isEmpty) {
        lotNumber = null;
      }
    }

    return CartItemDto(
      id: record.id,
      collectionId: record.collectionId,
      collectionName: record.collectionName,
      cart: record.getStringValue('cart'),
      product: record.getStringValue('product'),
      quantity: record.getDoubleValue('quantity'),
      productLot: record.getStringValue('productLot'),
      lotNumber: lotNumber,
      created: record.get<String>('created'),
      updated: record.get<String>('updated'),
    );
  }

  CartItem toEntity({RecordModel? productExpanded}) {
    return CartItem(
      id: id,
      cartId: cart,
      productId: product,
      quantity: quantity,
      productLotId: productLot,
      lotNumber: lotNumber,
      product: productExpanded != null
          ? ProductDto.fromRecord(productExpanded).toEntity()
          : null,
      created: parseToLocal(created),
      updated: parseToLocal(updated),
    );
  }
}
