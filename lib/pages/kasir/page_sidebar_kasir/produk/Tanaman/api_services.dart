import 'package:dio/dio.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/produk/Tanaman/model_tanaman.dart';

class ApiService {
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
}
