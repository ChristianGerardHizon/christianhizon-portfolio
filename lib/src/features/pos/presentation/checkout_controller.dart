import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/foundation/failure.dart';
import '../../auth/presentation/controllers/auth_controller.dart';
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

    // Convert cart items to sale items
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
      paymentRef: paymentRef,
      notes: notes,
    );

    // Get references before async operation to avoid disposed ref issues
    final salesRepo = ref.read(salesRepositoryProvider);
    final cartNotifier = ref.read(cartControllerProvider.notifier);

    // Save to backend
    final result = await salesRepo.createSale(sale, saleItems);

    return result.fold(
      (failure) => left(failure),
      (createdSale) async {
        // Mark cart as converted and clear it
        await cartNotifier.markAsConverted();
        return right(createdSale);
      },
    );
  }

  /// Generates a receipt number in format: YYYYMMDD-HHMMSS-XXXX
  String _generateReceiptNumber(String branchId) {
    final now = DateTime.now();
    final datePart =
        '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final timePart =
        '${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';

    // Use last 4 chars of branch ID as prefix
    final branchPrefix =
        branchId.length > 4 ? branchId.substring(branchId.length - 4) : branchId;

    return '$branchPrefix-$datePart-$timePart';
  }
}
