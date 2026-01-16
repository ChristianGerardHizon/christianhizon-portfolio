import 'package:dart_mappable/dart_mappable.dart';
import '../../products/domain/product.dart';

part 'cart_item.mapper.dart';

@MappableClass()
class CartItem with CartItemMappable {
  const CartItem({
    required this.product,
    this.quantity = 1,
  });

  final Product product;
  final int quantity;

  double get total => product.price.toDouble() * quantity;
}
