import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ttrana_pos/pages/kasir/models/produk.dart';

class Cart extends ChangeNotifier {
  //customer cart
  List<Map<Product, int>> _cart = [];
  List<Map<Product, int>> get cart => _cart;

  void addToCart(Product tanaman, int quantity) {
    _cart.add({tanaman: quantity});
    notifyListeners();
  }

  void removeFromCart(Product tanaman) {
    _cart.removeWhere((item) => item.containsKey(tanaman));
    notifyListeners();
  }

  void clearCart() {
    _cart = [];
    notifyListeners();
  }
}
