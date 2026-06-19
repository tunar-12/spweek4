import 'package:flutter_test/flutter_test.dart';

import 'package:mini_katalog/models/product.dart';
import 'package:mini_katalog/state/cart_model.dart';

void main() {
  group('Product model', () {
    test('fromJson / toJson round-trip', () {
      final json = {
        'id': 1,
        'name': 'iPhone 15 Pro',
        'tagline': 'Titanium.',
        'price': 999,
        'category': 'Phone',
        'imageUrl': '',
        'description': 'desc',
        'specs': {'size': '6.1 inches', 'audio': 'Spatial', 'colors': '4'},
      };

      final product = Product.fromJson(json);
      expect(product.name, 'iPhone 15 Pro');
      expect(product.price, 999.0);
      expect(product.specs.size, '6.1 inches');
      expect(product.toJson()['name'], 'iPhone 15 Pro');
    });

    test('formattedPrice adds thousands separator', () {
      final product = Product.fromJson({
        'id': 2,
        'name': 'MacBook',
        'tagline': '',
        'price': 1599,
        'category': 'Laptop',
        'imageUrl': '',
        'description': '',
        'specs': {},
      });
      expect(product.formattedPrice, r'$1,599');
    });
  });

  group('CartModel', () {
    Product makeProduct(int id, double price) => Product.fromJson({
          'id': id,
          'name': 'P$id',
          'tagline': '',
          'price': price,
          'category': 'Audio',
          'imageUrl': '',
          'description': '',
          'specs': {},
        });

    test('add increments quantity and total', () {
      final cart = CartModel();
      final p = makeProduct(1, 99);

      cart.add(p);
      cart.add(p);

      expect(cart.totalCount, 2);
      expect(cart.totalPrice, 198.0);
      expect(cart.items.length, 1);
    });

    test('decrease removes line when quantity hits zero', () {
      final cart = CartModel();
      final p = makeProduct(1, 99);

      cart.add(p);
      cart.decrease(p);

      expect(cart.isEmpty, true);
      expect(cart.totalCount, 0);
    });

    test('clear empties the cart', () {
      final cart = CartModel();
      cart.add(makeProduct(1, 99));
      cart.add(makeProduct(2, 249));
      cart.clear();
      expect(cart.isEmpty, true);
    });
  });
}
