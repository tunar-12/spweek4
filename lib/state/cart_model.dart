import 'package:flutter/widgets.dart';

import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get lineTotal => product.price * quantity;
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  int get totalCount => _items.fold(0, (sum, i) => sum + i.quantity);

  double get totalPrice => _items.fold(0.0, (sum, i) => sum + i.lineTotal);

  bool contains(Product product) =>
      _items.any((i) => i.product.id == product.id);

  void add(Product product) {
    final index = _items.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void decrease(Product product) {
    final index = _items.indexWhere((i) => i.product.id == product.id);
    if (index < 0) return;
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void removeAll(Product product) {
    _items.removeWhere((i) => i.product.id == product.id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  String get formattedTotal {
    final hasFraction = totalPrice != totalPrice.roundToDouble();
    final value = hasFraction
        ? totalPrice.toStringAsFixed(2)
        : totalPrice.toStringAsFixed(0);
    final parts = value.split('.');
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (m) => '${m[1]},',
    );
    return parts.length > 1 ? '\$$intPart.${parts[1]}' : '\$$intPart';
  }
}

class CartScope extends InheritedNotifier<CartModel> {
  const CartScope({
    super.key,
    required CartModel cart,
    required super.child,
  }) : super(notifier: cart);

  static CartModel of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'CartScope ağaçta bulunamadı.');
    return scope!.notifier!;
  }
}
