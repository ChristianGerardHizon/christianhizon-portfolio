import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../products/domain/product.dart';
import '../domain/cart_item.dart';

part 'cart_controller.g.dart';

@Riverpod(keepAlive: true)
class CartController extends _$CartController {
  @override
  List<CartItem> build() {
    return [];
  }

  void addToCart(Product product) {
    // Check if product already exists
    final existingIndex =
        state.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      // Update quantity
      final existingItem = state[existingIndex];
      final newQuantity = existingItem.quantity + 1;

      final updatedItem = existingItem.copyWith(quantity: newQuantity);

      final newState = [...state];
      newState[existingIndex] = updatedItem;
      state = newState;
    } else {
      // Add new item
      state = [...state, CartItem(product: product)];
    }
  }

  void removeFromCart(Product product) {
    state = state.where((item) => item.product.id != product.id).toList();
  }

  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      removeFromCart(product);
      return;
    }

    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      final updatedItem = state[index].copyWith(quantity: quantity);
      final newState = [...state];
      newState[index] = updatedItem;
      state = newState;
    }
  }

  void clearCart() {
    state = [];
  }
}

@Riverpod(keepAlive: true)
double cartTotal(Ref ref) {
  final cartItems = ref.watch(cartControllerProvider);
  return cartItems.fold(0, (sum, item) => sum + item.total);
}
