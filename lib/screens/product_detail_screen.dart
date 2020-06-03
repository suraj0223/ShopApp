import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../products_provide.dart/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static final routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      // bottomSheet: Container(
      //   height: 100,
      //   color: Colors.red,
      //   child: ListView(
      //     children: <Widget>[
      //       ListTile(title:Text('Hello')),
      //       ListTile(title:Text('Hello')),
      //       ListTile(title:Text('Hello')),
      //       ListTile(title:Text('Hello')),
      //       ListTile(title:Text('Hello')),
      //       ListTile(title:Text('Hello')),
      //     ],
      //   ),
      // ),

      body: CustomScrollView(
        semanticChildCount: 1,
        anchor: 0.01,
        //slivers are just scrollable areas on the screens that can scroll
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.lightBlueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            expandedHeight: 400,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(loadedProduct.title),
              ),
              background: Hero(
                tag: loadedProduct.id,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.network(
                    loadedProduct.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(),
              Text(
                '\$${loadedProduct.price}',
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  loadedProduct.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),

              //only for testing
              SizedBox(height: 1000)
            ]),
          ),
        ],
      ),
    );
  }
}
