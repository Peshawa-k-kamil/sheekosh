import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widgets/order_button.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Consumer<CartProvider>(
                    builder: (ctx, cartProvider, child) => Chip(
                      label: Text(
                        '\$${cartProvider.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6!
                              .color,
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  Consumer<CartProvider>(
                    builder: (ctx, cartProvider, child) =>
                        OrderButton(cartProvider: cartProvider),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //ListView doesnt work inside column, but you can use Expanded and insided it ListView
          Expanded(
            child: Consumer<CartProvider>(
              builder: (ctx, cartProvider, child) => ListView.builder(
                itemCount: cartProvider.itemCount,
                itemBuilder: (ctx, i) => CartItem(
                    id: cartProvider.items.values.toList()[i].id,
                    productId: cartProvider.items.keys.toList()[i],
                    title: cartProvider.items.values.toList()[i].title,
                    quantity: cartProvider.items.values.toList()[i].quantity,
                    price: cartProvider.items.values.toList()[i].price),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
