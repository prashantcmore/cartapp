import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final String description;
  bool isFavourite;

  Product(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.price,
      required this.description,
      this.isFavourite = false});

  notifyListeners();

  Future<void> toggleFavourite(String userId) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = Uri.parse('https://cartapp-3e019-default-rtdb.firebaseio.com/userFavourites/$userId/$id.json');
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavourite,
        ),
      );
      if (response.statusCode >= 400) {
        isFavourite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavourite = oldStatus;
      notifyListeners();
    }
  }
}
