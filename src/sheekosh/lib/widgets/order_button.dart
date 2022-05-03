import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/orders_provider.dart';

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cartProvider,
  }) : super(key: key);

  final CartProvider cartProvider;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Theme.of(context).primaryColor, // foreground
      ),
      onPressed: (widget.cartProvider.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });

              try {
                await Provider.of<OrdersProvider>(context, listen: false)
                    .addOrder(
                  widget.cartProvider.items.values.toList(),
                  widget.cartProvider.totalAmount,
                );

                setState(() {
                  _isLoading = false;
                });

                widget.cartProvider.clear();
              } catch (e) {
                await showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('An error occured'),
                    //content: Text(error.toString()),
                    content: const Text('Something went wrong with!'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('Okay')),
                    ],
                  ),
                );
                setState(() {
                  _isLoading = false;
                });
              }
            },
      child: _isLoading
          ? const CircularProgressIndicator()
          : const Text('Order Now'),
    );
  }
}
