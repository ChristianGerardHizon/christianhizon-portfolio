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
  final String? created;
  final String? updated;

  const CartItemDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.cart,
    required this.product,
    required this.quantity,
    this.created,
    this.updated,
  });

  factory CartItemDto.fromRecord(RecordModel record) {
    return CartItemDto(
      id: record.id,
      collectionId: record.collectionId,
      collectionName: record.collectionName,
      cart: record.getStringValue('cart'),
      product: record.getStringValue('product'),
      quantity: record.getDoubleValue('quantity'),
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
      product: productExpanded != null
          ? ProductDto.fromRecord(productExpanded).toEntity()
          : null,
      created: parseToLocal(created),
      updated: parseToLocal(updated),
    );
  }
}
