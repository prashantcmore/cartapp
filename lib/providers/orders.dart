import 'package:cartapp/providers/cart.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderItem with ChangeNotifier {
  final String id;
  final List<CartItem> products;
  final double amount;
  DateTime dateTime;

  OrderItem({required this.id, required this.products, required this.amount, required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final url = Uri.parse('https://cartapp-3e019-default-rtdb.firebaseio.com/orders.json');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    // if (extractedData == null) {
    //   return;
    // }
    extractedData.forEach(
      (orderId, orderData) {
        loadedOrders.add(
          OrderItem(
            id: orderId,
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(id: item.id, title: item.title, price: item.price, quantity: item.quantity),
                )
                .toList(),
            amount: orderData['totalamont'],
            dateTime: DateTime.parse(
              orderData['dateTime'],
            ),
          ),
        );
      },
    );
  }

  Future<void> addOrder(List<CartItem> cartproducts, double totalamount) async {
    final timestamp = DateTime.now();
    final url = Uri.parse('https://cartapp-3e019-default-rtdb.firebaseio.com/orders.json');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "id": timestamp.toIso8601String(),
            "totalamont": totalamount,
            "products": cartproducts
                .map((cp) => {
                      'id': timestamp.toString(),
                      'title': cp.title,
                      'price': cp.price,
                      'quantity': cp.quantity,
                    })
                .toList()
          },
        ),
      );
    } catch (error) {}

    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: totalamount,
        dateTime: DateTime.now(),
        products: cartproducts,
      ),
    );
    notifyListeners();
  }
}
