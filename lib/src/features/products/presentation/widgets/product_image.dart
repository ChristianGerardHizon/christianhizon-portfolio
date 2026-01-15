import 'package:flutter/material.dart';

import '../../../../core/widgets/cached_avatar.dart';
import '../../domain/product.dart';

/// Avatar widget for displaying a product's image.
///
/// Uses [CachedAvatar] with an inventory placeholder icon.
class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.product,
    this.radius = 20,
    this.onTap,
  });

  final Product product;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CachedAvatar(
      imageUrl: product.hasImage ? product.image : null,
      radius: radius,
      placeholderIcon: Icons.inventory_2_outlined,
      onTap: onTap,
    );
  }
}
