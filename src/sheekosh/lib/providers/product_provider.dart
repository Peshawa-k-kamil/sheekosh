import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sheekosh/providers/models/http_exception.dart';

class ProductProvider with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  ProductProvider({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldState = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final url = Uri.parse(
        'https://shop-app-backend-cf99c-default-rtdb.firebaseio.com/products/$id.json');

    try {
      final response = await http.patch(url,
          body: json.encode({
            'isFavorite': isFavorite,
          }));

      if (response.statusCode >= 400) {
        _setFavValue(oldState);
        throw HttpException('Can not faovorite');
      }
    } catch (e) {
      _setFavValue(oldState);
      throw HttpException('Can not faovorite');
    }
  }
}
