import 'package:cartapp/screens/Orders_Screen.dart';
import 'package:provider/provider.dart';
import 'package:cartapp/screens/Product_Detail_Screen.dart';
import 'package:cartapp/screens/Productsovervoiescreen.dart';
import 'package:cartapp/screens/UserProductsScreen.dart';
import 'package:flutter/material.dart';

import '../providers/Auth.dart';
import '../providers/Products_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: const Text("Hello Friends"),
          automaticallyImplyLeading: false,
        ),
        const Divider(),
        ListTile(
            leading: const Icon(Icons.shop),
            title: const Text(
              "Shop",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: (() {
              Navigator.of(context).pushReplacementNamed(ProductsoverviewScreen.routeName);
              // Provider.of<Products>(context).fetchAndSetData;
            })),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text(
            "Orders",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () => Navigator.of(context).pushReplacementNamed(OrderScreen.routeName),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text(
            "Manage Products",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () => Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName),
        ),
        ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              "Log Out",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
            }),
      ]),
    );
  }
}
