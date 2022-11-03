import 'package:cartapp/widgets/AppDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Product.dart';
import '../providers/Products_provider.dart';
import '../providers/cart.dart';
import '../widgets/Products_grid.dart';
import 'package:cartapp/widgets/badge%20(2).dart';
import '../screens/cart_screen.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductsoverviewScreen extends StatefulWidget {
  static const routeName = "productsoverview";
  @override
  State<ProductsoverviewScreen> createState() => _ProductsoverviewScreenState();
}

class _ProductsoverviewScreenState extends State<ProductsoverviewScreen> {
  var showOnlyFavs = false;
  var _isInit = true;

  @override
  Widget build(BuildContext context) {
    void initState() {
      Provider.of<Products>(context, listen: false).fetchAndSetData();
      super.initState();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("ShopApp"),
          actions: <Widget>[
            PopupMenuButton(
                onSelected: (selctedValue) {
                  setState(() {
                    if (selctedValue == FilterOptions.Favourites) {
                      showOnlyFavs = true;
                    } else {
                      showOnlyFavs = false;
                    }
                  });
                },
                icon: const Icon(Icons.more_vert),
                itemBuilder: (_) => const [
                      PopupMenuItem(
                        child: Text('only favs'),
                        value: FilterOptions.Favourites,
                      ),
                      PopupMenuItem(
                        child: Text("All"),
                        value: FilterOptions.All,
                      ),
                    ]),
            Consumer<Cart>(
              builder: (context, cart, child) => Badge(
                  // ignore: sort_child_properties_last
                  child: IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        Provider.of<Products>(context, listen: false).fetchAndSetData();
                        Navigator.of(context).pushNamed(CartScreen.routename);
                        // }
                      }),
                  value: cart.itemCount.toString(),
                  color: Colors.deepOrange),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: ProductsGrid(showOnlyFavs));
  }
}
