
class Product {
  final int id;
  final String name;
  final String tagline;
  final double price;
  final String category;
  final String imageUrl;
  final String description;
  final ProductSpecs specs;

  const Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.specs,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      tagline: (json['tagline'] ?? '') as String,
      // price int veya double gelebilir; güvenli dönüşüm.
      price: (json['price'] as num).toDouble(),
      category: (json['category'] ?? 'Other') as String,
      imageUrl: (json['imageUrl'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      specs: ProductSpecs.fromJson(
        (json['specs'] as Map<String, dynamic>?) ?? const {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'description': description,
      'specs': specs.toJson(),
    };
  }

  String get formattedPrice {
    final hasFraction = price != price.roundToDouble();
    final value = hasFraction ? price.toStringAsFixed(2) : price.toStringAsFixed(0);
    // Binlik ayracı ekle.
    final parts = value.split('.');
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (m) => '${m[1]},',
    );
    return parts.length > 1 ? '\$$intPart.${parts[1]}' : '\$$intPart';
  }
}

class ProductSpecs {
  final String size;
  final String audio;
  final String colors;

  const ProductSpecs({
    required this.size,
    required this.audio,
    required this.colors,
  });

  factory ProductSpecs.fromJson(Map<String, dynamic> json) {
    return ProductSpecs(
      size: (json['size'] ?? '-') as String,
      audio: (json['audio'] ?? '-') as String,
      colors: (json['colors'] ?? '-') as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'size': size,
        'audio': audio,
        'colors': colors,
      };
}
