import 'package:flutter/services.dart';

class HttpEcxeption implements Exception {
  final String message;

  HttpEcxeption(this.message);

  @override
  String toString() {
    return message;
  }
}
