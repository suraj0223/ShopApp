import 'package:flutter/material.dart';

import '../products_provide.dart/products.dart';
import '../widgets/product_item.dart';

import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFav;

  const ProductsGrid(this.showFav);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFav ? productsData.favouriteItems : productsData.items;

    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // create: (ctxx) => products[i],
        value: products[i],
        child: ProductItem(
            // products[i].id,
            // products[i].imageUrl,
            // products[i].title,
            ),
      ),
      itemCount: products.length,
    );
  }
}
