import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheekosh/providers/products_provider.dart';
import 'package:sheekosh/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  //const UserProductItem({Key? key}) : super(key: key);

  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem(
      {Key? key, required this.id, required this.title, required this.imageUrl})
      : super(key: key);

  // UserProductItem(
  //     {required this.id, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final scaffoldMessnger = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              icon: const Icon(
                Icons.edit,
              ),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<ProductsProvider>(context, listen: false)
                      .deleteProduct(id);
                } catch (e) {
                  scaffoldMessnger.showSnackBar(const SnackBar(
                      content: Text(
                    'Deleting failed',
                    textAlign: TextAlign.center,
                  )));
                }
              },
              icon: const Icon(
                Icons.delete,
              ),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
