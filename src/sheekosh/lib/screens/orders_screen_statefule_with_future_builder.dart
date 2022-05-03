import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreenStatefuleWithFutureBuilder extends StatefulWidget {
  const OrdersScreenStatefuleWithFutureBuilder({Key? key}) : super(key: key);

  static const routeName = '/orderssf';

  @override
  State<OrdersScreenStatefuleWithFutureBuilder> createState() =>
      _OrdersScreenStatefuleWithFutureBuilderState();
}

class _OrdersScreenStatefuleWithFutureBuilderState
    extends State<OrdersScreenStatefuleWithFutureBuilder> {
  late Future _ordersFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<OrdersProvider>(context, listen: false)
        .fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final ordersProvider = Provider.of<OrdersProvider>(context);
    //print('state fulakay bakar henrawa, bulding oredrs');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
          future: _ordersFuture,
          builder: (ctx, dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (dataSnapShot.error != null) {
              //...
              //Do error handling here
              return const Center(child: Text('An error occured'));
            }
            return Consumer<OrdersProvider>(
                builder: (ctx, orderDataFromProvider, child) =>
                    ListView.builder(
                      itemCount: orderDataFromProvider.orders.length,
                      itemBuilder: (ctx, i) => OrderItem(
                        order: orderDataFromProvider.orders[i],
                      ),
                    ));
          },
        ));
  }
}
