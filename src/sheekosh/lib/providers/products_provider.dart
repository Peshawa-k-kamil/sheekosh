import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sheekosh/providers/models/http_exception.dart';
import 'dart:convert';

import '../providers/product_provider.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductProvider> _items = [];

  List<ProductProvider> get items {
    return [..._items];
  }

  List<ProductProvider> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  ProductProvider findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://shop-app-backend-cf99c-default-rtdb.firebaseio.com/products.json');

    try {
      final response = await http.get(url);
      //print(json.decode(response.body));

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<ProductProvider> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(ProductProvider(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite'],
            imageUrl: prodData['imageUrl']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(ProductProvider product) async {
    final url = Uri.parse(
        'https://shop-app-backend-cf99c-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite
        }),
      );

      final newProduct = ProductProvider(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);

      _items.add(newProduct);

      notifyListeners();
    } catch (error) {
      //print(error.toString());
      rethrow;
    }
  }

  Future<void> updateProduct(String id, ProductProvider newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);

    final url = Uri.parse(
        'https://shop-app-backend-cf99c-default-rtdb.firebaseio.com/products/$id.json');

    await http.patch(url,
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'imageUrl': newProduct.imageUrl,
          'price': newProduct.price,
        }));
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      //print('....');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://shop-app-backend-cf99c-default-rtdb.firebaseio.com/products/$id.json');

    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    ProductProvider existingProduct = _items[existingProductIndex];

    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('The product could not be deleted');
    }
    //flitering la lanw provider a globalaka nakre , nabe lera bikai ama regayaki bash nya , balku filtering law widget a bka ka bzabt atawe baw shewa darkawe
  }
}
