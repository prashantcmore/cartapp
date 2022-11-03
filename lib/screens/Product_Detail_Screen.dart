import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);
  static const routename = 'product-details';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.50,
          width: double.infinity,
          child: Image.network(loadedProduct.imageUrl, fit: BoxFit.cover),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Text(
          '\$${loadedProduct.price}',
          style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            loadedProduct.description,
            softWrap: true,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        )
      ]),
    );
  }
}
