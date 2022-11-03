import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Auth.dart';
import '../providers/cart.dart';
import '../screens/Product_Detail_Screen.dart';
import '../providers/Product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context);
    return GridTile(
      // ignore: sort_child_properties_last
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routename,
            arguments: products.id,
          );
        },
        child: Image.network(
          products.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
          icon: Icon(
            products.isFavourite ? Icons.favorite : Icons.favorite_border,
            color: Colors.deepOrange,
          ),
          onPressed: () {
            products.toggleFavourite(authData.userId);
          },
        ),
        title: Text(
          products.title,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.shopping_cart,
            color: Colors.deepOrange,
          ),
          onPressed: () {
            cart.addItem(products.id, products.title, products.price);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: const Text("Added to cart sucsessfully"),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                      label: ("UNDO"),
                      onPressed: () {
                        cart.removeSingleItem(products.id);
                      })),
            );
          },
        ),
      ),
    );
  }
}
