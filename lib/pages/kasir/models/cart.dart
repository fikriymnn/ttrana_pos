import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ttrana_pos/pages/kasir/models/produk.dart';

class Cart extends ChangeNotifier {
  // Menggunakan struktur yang fleksibel
  List<Map<String, dynamic>> _cart = [];
  List<Map<String, dynamic>> get cart => _cart;

  void addToCart(Product tanaman, int quantity, String color, String ageGroup,
      String variasi) {
    _cart.add({
      'product': tanaman,
      'quantity': quantity,
      'color': color,
      'ageGroup': ageGroup,
      'variasi': variasi,
    });
    notifyListeners();
  }

  void removeFromCart(Product tanaman) {
    _cart.removeWhere((item) => item['product'] == tanaman);
    notifyListeners();
  }

  void clearCart() {
    _cart = [];
    notifyListeners();
  }
}



// class Cart extends ChangeNotifier {
//   //customer cart
//   List<Map<Product, int>> _cart = [];
//   List<Map<Product, int>> get cart => _cart;

//   void addToCart(Product tanaman, int quantity, String warna, String usia) {
//     _cart.add({tanaman: quantity,
//     warna: warna,});
//     notifyListeners();
//   }

//   void removeFromCart(Product tanaman) {
//     _cart.removeWhere((item) => item.containsKey(tanaman));
//     notifyListeners();
//   }

//   void clearCart() {
//     _cart = [];
//     notifyListeners();
//   }
// }
