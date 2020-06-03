import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopapp/products_provide.dart/auth.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/appBarBackgrd.jpg'),
          ),
        ),
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.greenAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CircleAvatar(
                    //  backgroundImage: Image.network(),
                    ),
              ),
              title: Text('Hello Friend!'),
            ),
            Divider(),
            ListTile(
              leading: Shimmer.fromColors(
                baseColor: Colors.lightGreenAccent,
                highlightColor: Colors.lightBlueAccent,
                child: Icon(Icons.shop, size: 40),
              ),
              title: Text(
                'Shop',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Click to View all products'),
              onTap: () => Navigator.of(context).pushReplacementNamed('/'),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.payment,
                size: 40,
              ),
              title: Text(
                'Orders',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Your Orders'),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.perm_data_setting,
                size: 40,
              ),
              title: Text(
                'Manage Products',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Find your Managed products'),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routeName),
            ),
            Divider(),
            ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  size: 40,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Logout from app'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/');
                  Provider.of<Auth>(context, listen: false).logout();
                }),
          ],
        ),
      ),
    );
  }
}
