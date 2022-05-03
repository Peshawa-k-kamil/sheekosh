import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sheekosh/providers/models/http_exception.dart';
import 'package:sheekosh/providers/models/order_item_model.dart';

import 'models/cart_item_model.dart';

class OrdersProvider with ChangeNotifier {
  //List<OrderItemModel> _orders = [];
  List<OrderItemModel> _orders = [];

  List<OrderItemModel> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://shop-app-backend-cf99c-default-rtdb.firebaseio.com/orders.json');

    final response = await http.get(url);
    final List<OrderItemModel> loadedOrders = [];
    Map<String, dynamic>? extractedData =
        json.decode(response.body) as Map<String, dynamic>?;

    if (extractedData != null) {
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(OrderItemModel(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItemModel(
                  id: item['id'],
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price']))
              .toList(),
        ));
      });
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    }
  }

  Future<void> addOrder(List<CartItemModel> cartProducts, double total) async {
    final url = Uri.parse(
        'https://shop-app-backend-cf99c-default-rtdb.firebaseio.com/orders.json');

    final timestamp = DateTime.now();

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
        }),
      );

      _orders.insert(
          0,
          OrderItemModel(
            id: json.decode(response.body)['name'],
            amount: total,
            products: cartProducts,
            dateTime: timestamp,
          ));
      notifyListeners();
    } catch (e) {
      throw HttpException('couldnt add order');
    }
  }
}
