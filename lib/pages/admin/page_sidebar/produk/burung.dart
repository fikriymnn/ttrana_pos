// Halaman Burung
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Burung extends StatelessWidget {
  const Burung({super.key});

  Future<List<dynamic>> fetchApi() async {
    Dio dio = Dio();

    try {
      var response = await dio.get(
          'https://74gslzvj-8000.asse.devtunnels.ms/api/filterdanGet?kategori=burung');

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
                      return Card(
                        elevation: 2,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: size.width * 0.01,
                            left: size.width * 0.01,
                            top: size.height * 0.03,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: product['foto_produk'] != null &&
                                        product['foto_produk'].isNotEmpty
                                    ? Image.network(
                                        'https://74gslzvj-8000.asse.devtunnels.ms${product['foto_produk']}',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey[200],
                                            child:
                                                Icon(Icons.image_not_supported),
                                          );
                                        },
                                      )
                                    : Container(
                                        color: Colors.grey[200],
                                        child: Icon(Icons.image_not_supported),
                                      ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.008,
                                  vertical: size.height * 0.008,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['judul_produk'] ?? 'Tanpa Judul',
                                      style: GoogleFonts.josefinSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Rp. ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(product['harga'])}',
                                          style: GoogleFonts.josefinSans(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Stok: ${product['jumlahProduk']}',
                                          style: GoogleFonts.josefinSans(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
