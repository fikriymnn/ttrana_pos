// Halaman Tanaman
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Tanaman extends StatelessWidget {
  const Tanaman({super.key});

  Future<List<dynamic>> fetchApi() async {
    Dio dio = Dio();

    try {
      var response = await dio.get(
          'https://74gslzvj-8000.asse.devtunnels.ms/api/filterdanGet?kategori=tanaman');

      print(response.data.toString());

      return response.data;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: size.height, // Menggunakan ukuran lebar untuk tinggi
          width: size.width * 0.65,
          color: const Color(0xFFEBFFF8),
          child: Center(
            child: FutureBuilder<List<dynamic>>(
              future: fetchApi(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Terjadi kesalahan saat memuat data'),
                  );
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return GridView.builder(
                    itemCount: snapshot.data?.length,
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 25,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      var product = snapshot.data![index];
                      return Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://74gslzvj-8000.asse.devtunnels.ms${product['foto_produk']}',
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 150,
                              child: Row(
                                children: [
                                  Text(
                                    product['judul_produk'] ?? 'Tanpa Judul',
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 1),
                            Container(
                              width: 150,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rp. ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(product['harga'])}',
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xffFF0A0A),
                                    ),
                                  ),
                                  Text(
                                    'Stok: ${product['jumlah']}',
                                    style: GoogleFonts.josefinSans(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Tidak ada produk yang tersedia'),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
