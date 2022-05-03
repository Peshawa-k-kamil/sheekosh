import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/products_provider.dart';
import '../../../widgets/product_item.dart';

class RecomendedProdsGrid extends StatelessWidget {
  final bool showFavs;

  const RecomendedProdsGrid(this.showFavs, {Key? key}) : super(key: key);
  //ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 10 / 9,
        mainAxisExtent: 200,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child:
            // ignore: prefer_const_constructors
            ProductItem(), // agar ama const be awa favorite akan ba rasty pshan nada
      ),
    );
  }
}
