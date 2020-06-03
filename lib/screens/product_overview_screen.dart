import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopapp/products_provide.dart/products.dart';
import '../products_provide.dart/cart.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/widgets/app_drawer.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavourites = false;
  var _runonce = true;
  var _isLoading = false;

  // Init state runs only once so it's a best place to get data from server
  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_){
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_runonce) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _runonce = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        
        centerTitle: true,
        title: Text('PS Cart'),
        actions: <Widget>[
          PopupMenuButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            icon: Icon(Icons.apps),
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favourites) {
                  _showOnlyFavourites = true;
                } else {
                  _showOnlyFavourites = false;
                }
              });
            },
            padding: EdgeInsets.all(10),
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text('Only Favourites'),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.pinkAccent)),
                  value: FilterOptions.Favourites,
                ),
                PopupMenuItem(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.greenAccent),
                    child: Text('Show All'),
                  ),
                  value: FilterOptions.All,
                ),
              ];
            },
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              // here ch in builder method is the IconBotton which is child that
              // not rebuild again when cart changes
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: Shimmer.fromColors(
                child: Text(
                  'Loading Products...',
                  style: TextStyle(fontSize: 25),
                ),
                baseColor: Colors.greenAccent,
                highlightColor: Colors.lightBlueAccent,
                period: Duration(milliseconds: 100),
              ),
            )
          : ProductsGrid(_showOnlyFavourites),
    );
  }
}
