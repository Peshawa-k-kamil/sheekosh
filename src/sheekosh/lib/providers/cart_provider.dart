import 'package:flutter/foundation.dart';

import 'models/cart_item_model.dart';

class CartProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  Map<String, CartItemModel> _items = {};

  Map<String, CartItemModel> get items {
    return {..._items};
  }

  int get itemCount {
    //return _items == null ? 0 : _items.length;
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productid, double price, String title) {
    if (_items.containsKey(productid)) {
      _items.update(
          productid,
          (existingCartItem) => CartItemModel(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
          productid,
          () => CartItemModel(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existCartItem) => CartItemModel(
              id: existCartItem.id,
              title: existCartItem.title,
              quantity: existCartItem.quantity - 1,
              price: existCartItem.price));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}//end Cart class
