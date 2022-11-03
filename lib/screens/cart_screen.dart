import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/AppDrawer.dart';
import '../widgets/Cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routename = "cart screen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 20),
              ),
              Chip(
                backgroundColor: Theme.of(context).primaryColor,
                label: Text(
                  cart.totalAmt.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Provider.of<Orders>(
                    context,
                    listen: false,
                  ).addOrder(cart.items.values.toList(), cart.totalAmt);
                  cart.clear();
                },
                child: const Text("Order Now"),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => CartItems(
                      cart.items.values.toList()[i].id,
                      cart.items.keys.toList()[i],
                      cart.items.values.toList()[i].quantity,
                      cart.items.values.toList()[i].price,
                      cart.items.values.toList()[i].title,
                    )),
          ),
        ],
      ),
    );
  }
}
