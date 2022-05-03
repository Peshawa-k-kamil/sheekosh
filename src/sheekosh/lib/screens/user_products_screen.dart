import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheekosh/providers/products_provider.dart';
import 'package:sheekosh/screens/edit_product_screen.dart';
import 'package:sheekosh/widgets/app_drawer.dart';
import 'package:sheekosh/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    //final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Consumer<ProductsProvider>(
            builder: (ctx, productsProvider, child) => ListView.builder(
              itemCount: productsProvider.items.length,
              itemBuilder: (_, i) => Column(
                children: [
                  UserProductItem(
                      id: productsProvider.items[i].id,
                      title: productsProvider.items[i].title,
                      imageUrl: productsProvider.items[i].imageUrl),
                  const Divider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
