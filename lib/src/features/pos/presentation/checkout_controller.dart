import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/foundation/failure.dart';
import '../../auth/presentation/controllers/auth_controller.dart';
import '../../products/data/repositories/product_lot_repository.dart';
import '../../products/data/repositories/product_repository.dart';
import '../data/repositories/sales_repository.dart';
import '../domain/payment_method.dart';
import '../domain/sale.dart';
import '../domain/sale_item.dart';
import 'cart_controller.dart';

part 'checkout_controller.g.dart';

@riverpod
class CheckoutController extends _$CheckoutController {
  @override
  FutureOr<void> build() {
    // No initial state needed
  }

  /// Processes checkout and creates a sale from the current cart.
  Future<Either<Failure, Sale>> processCheckout({
    required PaymentMethod paymentMethod,
    String? paymentRef,
    String? notes,
    double? amountTendered,
    String? customerId,
    String? customerName,
  }) async {
    final cartState = ref.read(cartControllerProvider).value;
    if (cartState == null || cartState.isEmpty) {
      return left(const GenericFailure('Cart is empty'));
    }

    final auth = ref.read(currentAuthProvider);
    if (auth == null) {
      return left(const GenericFailure('Not authenticated'));
    }

    final branchId = auth.user.branch;
    if (branchId == null) {
      return left(const GenericFailure('No branch assigned'));
    }

    final cashierId = auth.user.id;

    // Generate receipt number: BRANCH-YYYYMMDD-RANDOM
    final receiptNumber = _generateReceiptNumber(branchId);

    // Convert cart items to sale items (including lot info if present)
    final saleItems = cartState.items.map((cartItem) {
      final product = cartItem.product;
      return SaleItem(
        id: '', // Will be assigned by backend
        saleId: '', // Will be linked by backend
        productId: cartItem.productId,
        productName: product?.name ?? 'Unknown Product',
        quantity: cartItem.quantity,
        unitPrice: product?.price ?? 0,
        subtotal: cartItem.total,
        productLotId: cartItem.productLotId,
        lotNumber: cartItem.lotNumber,
      );
    }).toList();

    // Create the sale
    final sale = Sale(
      id: '', // Will be assigned by backend
      receiptNumber: receiptNumber,
      branchId: branchId,
      cashierId: cashierId,
      totalAmount: cartState.total,
      paymentMethod: paymentMethod.name,
      status: 'completed',
      patient: customerId,
      customerName: customerName,
      paymentRef: paymentRef,
      notes: notes,
    );

    // Get references before async operation to avoid disposed ref issues
    final salesRepo = ref.read(salesRepositoryProvider);
    final cartNotifier = ref.read(cartControllerProvider.notifier);
    final lotRepo = ref.read(productLotRepositoryProvider);
    final productRepo = ref.read(productRepositoryProvider);

    // Save to backend
    final result = await salesRepo.createSale(sale, saleItems);

    return result.fold(
      (failure) => left(failure),
      (createdSale) async {
        // Track products that need quantity sync
        final productIdsToSync = <String>{};

        // Decrement lot quantities for lot-tracked items
        for (final item in saleItems) {
          if (item.productLotId != null && item.productLotId!.isNotEmpty) {
            await lotRepo.decrementQuantity(item.productLotId!, item.quantity);
            productIdsToSync.add(item.productId);
          }
        }

        // Sync product quantities with their lot totals
        for (final productId in productIdsToSync) {
          final totalResult = await lotRepo.calculateTotalQuantity(productId);
          await totalResult.fold(
            (failure) async {},
            (total) async {
              await productRepo.updateQuantity(productId, total);
            },
          );
        }

        // Mark cart as converted and clear it
        await cartNotifier.markAsConverted();
        return right(createdSale);
      },
    );
  }

  /// Generates a receipt number in format: S-YYMMDD-XXXX
  /// Uses random alphanumeric suffix to avoid race conditions.
  String _generateReceiptNumber(String branchId) {
    final now = DateTime.now();
    final year = (now.year % 100).toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    final datePart = '$year$month$day';

    // Generate random 4-character alphanumeric suffix
    final random = Random();
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; // Excluded I,O,0,1 for clarity
    final suffix = List.generate(4, (_) => chars[random.nextInt(chars.length)]).join();

    return 'S-$datePart-$suffix';
  }
}
