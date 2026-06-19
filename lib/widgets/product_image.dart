import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/app_theme.dart';

class ProductImage extends StatelessWidget {
  final Product product;
  final double iconSize;

  const ProductImage({
    super.key,
    required this.product,
    this.iconSize = 48,
  });

  IconData get _fallbackIcon {
    switch (product.category) {
      case 'Phone':
        return Icons.smartphone;
      case 'Laptop':
        return Icons.laptop_mac;
      case 'Tablet':
        return Icons.tablet_mac;
      case 'Audio':
        return Icons.speaker;
      default:
        return Icons.devices_other;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (product.imageUrl.isEmpty) {
      return _placeholder();
    }
    return Image.asset(
      product.imageUrl,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => _placeholder(),
    );
  }

  Widget _placeholder() {
    return Center(
      child: Icon(_fallbackIcon, size: iconSize, color: AppTheme.muted),
    );
  }
}
