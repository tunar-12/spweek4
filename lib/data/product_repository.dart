import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/banner_info.dart';
import '../models/product.dart';

class ProductRepository {
  const ProductRepository();

  static const String _assetPath = 'assets/products.json';

  Future<CatalogData> loadCatalog() async {
    final raw = await rootBundle.loadString(_assetPath);
    final Map<String, dynamic> decoded = json.decode(raw) as Map<String, dynamic>;

    final banner = BannerInfo.fromJson(
      (decoded['banner'] as Map<String, dynamic>?) ?? const {},
    );

    final products = (decoded['products'] as List<dynamic>)
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();

    return CatalogData(banner: banner, products: products);
  }
}

class CatalogData {
  final BannerInfo banner;
  final List<Product> products;

  const CatalogData({required this.banner, required this.products});
}
