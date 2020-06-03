import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/products_provide.dart/auth.dart';
import '../products_provide.dart/cart.dart';
import '../products_provide.dart/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // const ProductItem(this.id, this.imageUrl, this.title);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    SnackBar _showSnack(String contentData) {
      return SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 10.0,
        duration: Duration(seconds: 2),
        content: Text(
          product.isFavourite ? 'Added to Favourite' : 'Removed From Favourite',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Hero(
                tag: product.id,
                      child: FadeInImage(
              placeholder: AssetImage('assets/images/fadeIn.jpg'),
              image: NetworkImage(product.imageUrl),
            ),
          ),
        ),
        footer: GridTileBar(
          title: Text(
            product.title,
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(
              product.isFavourite ? Icons.favorite : Icons.favorite_border,
              size: 30,
            ),
            color: Theme.of(context).accentColor,
            onPressed: () {
              product.toggleFavouritestatus(authData.token, authData.userId);
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                product.isFavourite
                    ? _showSnack('Added to Favorite')
                    : _showSnack('Removed from favourite'),
              );
            },
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                size: 30,
              ),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                Scaffold.of(context).removeCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      'Item Added to Cart',
                      textAlign: TextAlign.start,
                    ),
                    elevation: 10,
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        }),
                  ),
                );
              },
              color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
