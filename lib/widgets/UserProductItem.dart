import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Products_provider.dart';
import '../screens/EditProductsScreen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;
  UserProductItem(this.id, this.imageUrl, this.title);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductsScreen.routeName,
                  arguments: id,
                );
              },
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false).deleteProduct(id);
                } catch (error) {
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text("Deleting Failed"),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
