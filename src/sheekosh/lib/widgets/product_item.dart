import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../screens/product_detail_screen.dart';

// class ProductItem extends StatelessWidget {
// final String id;
// final String title;
// final String imageUrl;

// ProductItem(
//   this.id,
//   this.title,
//   this.imageUrl,
// );

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessnger = ScaffoldMessenger.of(context);
    final productsProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: productsProvider.id,
            );
          },
          child: Hero(
            tag: productsProvider.id,
            child: Image.network(
              productsProvider.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<ProductProvider>(
            builder: (ctx, productProvider, child) => IconButton(
              onPressed: () async {
                //product.toggleFavoriteStatus();
                try {
                  await productProvider.toggleFavoriteStatus();
                } catch (e) {
                  scaffoldMessnger.showSnackBar(const SnackBar(
                      content: Text(
                    'Failed',
                    textAlign: TextAlign.center,
                  )));
                }
              },

              // onPressed: () async {
              //   try {
              //     await Provider.of<ProductsProvider>(context, listen: false)
              //         .deleteProduct(id);
              //   } catch (e) {
              //     scaffoldMessnger.showSnackBar(const SnackBar(
              //         content: Text(
              //       'Deleting failed',
              //       textAlign: TextAlign.center,
              //     )));
              //   }
              // },

              icon: Icon(
                productProvider.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            productsProvider.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              cartProvider.addItem(
                productsProvider.id,
                productsProvider.price,
                productsProvider.title,
              );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: const Text(
                      'Added item to the cart',
                      //textAlign: TextAlign.center,
                    ),
                    duration: const Duration(
                      seconds: 2,
                    ),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cartProvider.removeSingleItem(productsProvider.id);
                      },
                    )),
              );
            },
            icon: const Icon(
              Icons.shopping_cart,
            ),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
