import 'package:dart_mappable/dart_mappable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/presentation/controllers/auth_controller.dart';
import '../../products/domain/product.dart';
import '../data/repositories/cart_repository.dart';
import '../domain/cart.dart';
import '../domain/cart_item.dart';

part 'cart_controller.g.dart';
part 'cart_controller.mapper.dart';

/// State for the shopping cart.
@MappableClass()
class CartState with CartStateMappable {
  const CartState({
    this.cartId,
    this.items = const [],
    this.isSyncing = false,
  });

  /// PocketBase cart record ID (null if not yet persisted).
  final String? cartId;

  /// Items in the cart.
  final List<CartItem> items;

  /// Whether a sync operation is in progress.
  final bool isSyncing;

  /// Total price of all items.
  double get total => items.fold(0, (sum, item) => sum + item.total);

  /// Whether the cart is empty.
  bool get isEmpty => items.isEmpty;

  /// Whether the cart is not empty.
  bool get isNotEmpty => items.isNotEmpty;
}

@Riverpod(keepAlive: true)
class CartController extends _$CartController {
  CartRepository get _cartRepo => ref.read(cartRepositoryProvider);

  @override
  Future<CartState> build() async {
    // Try to load existing active cart for current user's branch
    final auth = ref.read(currentAuthProvider);
    final branchId = auth?.user.branch;

    if (branchId == null) {
      return const CartState();
    }

    // Check for existing active cart
    final result = await _cartRepo.getActiveCarts(branchId);
    return result.fold(
      (failure) => const CartState(),
      (carts) async {
        if (carts.isEmpty) {
          return const CartState();
        }

        // Load items from the most recent active cart
        final cart = carts.first;
        final itemsResult = await _cartRepo.getCartItems(cart.id);
        return itemsResult.fold(
          (failure) => CartState(cartId: cart.id),
          (items) => CartState(cartId: cart.id, items: items),
        );
      },
    );
  }

  /// Creates a new cart in the backend if one doesn't exist.
  Future<String?> _ensureCart() async {
    final currentState = state.value;
    if (currentState?.cartId != null) {
      return currentState!.cartId;
    }

    final auth = ref.read(currentAuthProvider);
    final branchId = auth?.user.branch;
    final userId = auth?.user.id;

    if (branchId == null) return null;

    final cart = Cart(
      id: '',
      branchId: branchId,
      status: 'active',
      userId: userId,
    );

    final result = await _cartRepo.createCart(cart);
    return result.fold(
      (failure) => null,
      (createdCart) {
        state = AsyncData(CartState(
          cartId: createdCart.id,
          items: currentState?.items ?? [],
        ));
        return createdCart.id;
      },
    );
  }

  /// Adds a product to the cart.
  Future<void> addToCart(Product product) async {
    final currentState = state.value;
    if (currentState == null) return;

    // Check if product already exists
    final existingIndex =
        currentState.items.indexWhere((item) => item.productId == product.id);

    if (existingIndex >= 0) {
      // Update quantity of existing item
      final existingItem = currentState.items[existingIndex];
      final newQuantity = existingItem.quantity + 1;
      await updateQuantity(product, newQuantity.toInt());
    } else {
      // Add new item
      state = AsyncData(currentState.copyWith(isSyncing: true));

      // Ensure cart exists in backend
      final cartId = await _ensureCart();
      if (cartId == null) {
        state = AsyncData(currentState.copyWith(isSyncing: false));
        return;
      }

      // Create cart item in backend
      final cartItem = CartItem(
        cartId: cartId,
        productId: product.id,
        product: product,
        quantity: 1,
      );

      final result = await _cartRepo.addCartItem(cartItem);
      result.fold(
        (failure) {
          // Rollback on failure - keep local state but mark sync failed
          state = AsyncData(currentState.copyWith(isSyncing: false));
        },
        (createdItem) {
          final newItems = <CartItem>[...currentState.items, createdItem];
          state = AsyncData(CartState(
            cartId: cartId,
            items: newItems,
            isSyncing: false,
          ));
        },
      );
    }
  }

  /// Removes a product from the cart.
  Future<void> removeFromCart(Product product) async {
    final currentState = state.value;
    if (currentState == null) return;

    final item = currentState.items.firstWhere(
      (item) => item.productId == product.id,
      orElse: () => const CartItem(),
    );

    if (item.id.isEmpty) return;

    state = AsyncData(currentState.copyWith(isSyncing: true));

    // Delete from backend
    final result = await _cartRepo.deleteCartItem(item.id);
    result.fold(
      (failure) {
        state = AsyncData(currentState.copyWith(isSyncing: false));
      },
      (_) {
        final newItems = currentState.items
            .where((i) => i.productId != product.id)
            .toList();
        state = AsyncData(currentState.copyWith(
          items: newItems,
          isSyncing: false,
        ));
      },
    );
  }

  /// Updates the quantity of a product in the cart.
  Future<void> updateQuantity(Product product, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(product);
      return;
    }

    final currentState = state.value;
    if (currentState == null) return;

    final index =
        currentState.items.indexWhere((item) => item.productId == product.id);
    if (index < 0) return;

    final item = currentState.items[index];
    state = AsyncData(currentState.copyWith(isSyncing: true));

    // Update in backend
    final updatedItem = item.copyWith(quantity: quantity);
    final result = await _cartRepo.updateCartItem(updatedItem);

    result.fold(
      (failure) {
        state = AsyncData(currentState.copyWith(isSyncing: false));
      },
      (syncedItem) {
        final newItems = [...currentState.items];
        newItems[index] = syncedItem;
        state = AsyncData(currentState.copyWith(
          items: newItems,
          isSyncing: false,
        ));
      },
    );
  }

  /// Clears all items from the cart.
  Future<void> clearCart() async {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncData(currentState.copyWith(isSyncing: true));

    // Delete all items from backend
    for (final item in currentState.items) {
      if (item.id.isNotEmpty) {
        await _cartRepo.deleteCartItem(item.id);
      }
    }

    // Update cart status to abandoned if it exists
    if (currentState.cartId != null) {
      final cart = Cart(
        id: currentState.cartId!,
        branchId: '',
        status: 'abandoned',
      );
      await _cartRepo.updateCart(cart);
    }

    state = const AsyncData(CartState());
  }

  /// Marks the cart as converted after successful checkout.
  Future<void> markAsConverted() async {
    final currentState = state.value;
    if (currentState?.cartId == null) return;

    final cart = Cart(
      id: currentState!.cartId!,
      branchId: '',
      status: 'converted',
    );
    await _cartRepo.updateCart(cart);

    state = const AsyncData(CartState());
  }
}

/// Provider for cart total.
@Riverpod(keepAlive: true)
double cartTotal(Ref ref) {
  final cartState = ref.watch(cartControllerProvider);
  return cartState.value?.total ?? 0;
}

/// Provider for cart items.
@Riverpod(keepAlive: true)
List<CartItem> cartItems(Ref ref) {
  final cartState = ref.watch(cartControllerProvider);
  return cartState.value?.items ?? [];
}
