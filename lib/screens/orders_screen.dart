import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/order_item.dart';
import '../products_provide.dart/orders.dart' show Orders;

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isloading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((onValue) async {
      setState(() {
        _isloading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
      setState(() {
        _isloading = false;
      });
    });

    setState(() {
      _isloading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: _isloading
          ? Center(
              child: Shimmer.fromColors(
                child: Text(
                  'Loading Orders...',
                  style: TextStyle(fontSize: 25),
                ),
                baseColor: Colors.greenAccent,
                highlightColor: Colors.lightBlueAccent,
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return OrderItem(
                  orderData.order[index],
                );
              },
              itemCount: orderData.order.length,
            ),
    );
  }
}
