import 'package:cartapp/providers/Products_provider.dart';
import 'package:cartapp/screens/EditProductsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/AppDrawer.dart';
import '../providers/Product.dart';
import '../widgets/UserProductItem.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);
  static const routeName = 'userproducts';
  Future<void> _refreshFun(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetData();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
            onPressed: () {
              // Provider.of<Products>(context).deleteProduct(products.id);
              Navigator.of(context).pushReplacementNamed(EditProductsScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshFun(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.item.length,
            itemBuilder: (ctx, i) => UserProductItem(
              products.item[i].id,
              products.item[i].imageUrl,
              products.item[i].title,
            ),
          ),
        ),
      ),
    );
  }
}
