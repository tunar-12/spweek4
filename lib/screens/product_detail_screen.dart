import 'package:flutter/material.dart';

import '../models/product.dart';
import '../state/cart_model.dart';
import '../theme/app_theme.dart';
import '../widgets/product_image.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/detail';

  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final cart = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Back', style: TextStyle(fontSize: 16)),
        actions: [
          AnimatedBuilder(
            animation: cart,
            builder: (context, _) => IconButton(
              icon: const Icon(Icons.shopping_bag_outlined),
              onPressed: () =>
                  Navigator.pushNamed(context, CartScreen.routeName),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Center(
            child: Hero(
              tag: 'product-${product.id}',
              child: SizedBox(
                height: 240,
                child: ProductImage(product: product, iconSize: 96),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            product.name,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            product.tagline,
            style: const TextStyle(color: AppTheme.muted, fontSize: 15),
          ),
          const SizedBox(height: 12),
          Text(
            product.formattedPrice,
            style: const TextStyle(
              color: AppTheme.priceColor,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),
          const _SectionTitle('Description'),
          const SizedBox(height: 8),
          Text(
            product.description,
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 24),
          const _SectionTitle('Specifications'),
          const SizedBox(height: 12),
          _SpecsRow(specs: product.specs),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                cart.add(product);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('${product.name} sepete eklendi'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
              },
              child: const Text(
                'Add to Cart',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
    );
  }
}

class _SpecsRow extends StatelessWidget {
  final ProductSpecs specs;
  const _SpecsRow({required this.specs});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _SpecCell(label: 'SIZE', value: specs.size),
          _divider(),
          _SpecCell(label: 'AUDIO', value: specs.audio),
          _divider(),
          _SpecCell(label: 'COLORS', value: specs.colors),
        ],
      ),
    );
  }

  Widget _divider() => Container(
        width: 1,
        height: 36,
        color: const Color(0xFFE5E5EA),
      );
}

class _SpecCell extends StatelessWidget {
  final String label;
  final String value;
  const _SpecCell({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.muted,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
