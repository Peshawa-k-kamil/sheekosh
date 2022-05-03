import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheekosh/providers/products_provider.dart';
import 'package:sheekosh/ui/widgets/home/search.dart';
import 'package:sheekosh/ui/widgets/home/top_carousel_reklam.dart';
import 'package:sheekosh/ui/widgets/shared/bottom_nav.dart';

import '../../providers/cart_provider.dart';
import '../../screens/cart_screen.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/badge.dart';
import '../widgets/home/recomended_prods_grid.dart';

enum FilterOptions { favorites, all }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    //Provider.of<ProductsProvider>(context,listen: false).fetchAndSetProducts();
    //tanha bam sheway sarawa la initState ish aka
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Text(
                    'کاڵای پێشنیار کراو',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: RecomendedProdsGrid(_showOnlyFavorites),
                ),
              ],
            ),
      bottomNavigationBar: const BottomNav(),
    );
  }

  PreferredSize _appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(275),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
        ),
        //color: Colors.red,
        child: Column(
          children: [
            AppBar(
              //toolbarHeight: 50,
              title: const Text('MyShop'),
              actions: [
                PopupMenuButton(
                  onSelected: (FilterOptions selectedValue) {
                    setState(() {
                      if (selectedValue == FilterOptions.favorites) {
                        _showOnlyFavorites = true;
                      } else {
                        _showOnlyFavorites = false;
                      }
                    });

                    //print(selectedValue);
                  },
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                  itemBuilder: (_) => [
                    const PopupMenuItem(
                        child: Text('Only Favorites'),
                        value: FilterOptions.favorites),
                    const PopupMenuItem(
                        child: Text('Show All'), value: FilterOptions.all),
                  ],
                ),
                Consumer<CartProvider>(
                  builder: (_, cart, ch) => Badge(
                    //key: key,
                    child: ch!,
                    value: cart.itemCount.toString(),
                    color: Colors.blue,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              //color: Colors.green,
              height: 218,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Search(),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      //color: Colors.blue,
                      child: TopReklamCarousel(imgList: const [
                        'https://cdn.obag.filoblu.com/media/catalog/product/cache/25162cc576cf81151d28507649e6339b/o/b/obagdocmilk_L1.jpg',
                        'https://cdn.obag.filoblu.com/media/catalog/product/cache/25162cc576cf81151d28507649e6339b/o/b/obagdocmilk_L1.jpg',
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
                      ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
