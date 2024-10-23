import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/produk/Tanaman/model_tanaman.dart';

class Cart extends ChangeNotifier {
  final Dio _dio = Dio();

  Future<List<ProdukTanaman>> getProducts() async {
    const String url =
        'https://74gslzvj-8000.asse.devtunnels.ms/api/filterdanGet?kategori=tanaman';

    try {
      Response response = await _dio.get(url);
      List<dynamic> data = response.data;

      // Konversi data JSON menjadi daftar objek Product
      return data.map((json) => ProdukTanaman.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  //customer cart
  final List<Map<ProdukTanaman, int>> _cart = [];

  void addToCart(ProdukTanaman tanaman, int quantity) {
    _cart.add({tanaman: quantity});
    notifyListeners();
  }
  void removeFromCart(ProdukTanaman tanaman) {
    _cart.removeWhere((item) => item.containsKey(tanaman));
    notifyListeners();
  }

  List<Map<ProdukTanaman, int>> get cart => _cart;
}
