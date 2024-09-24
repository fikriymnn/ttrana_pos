import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Produk extends StatelessWidget {
  Future<List<dynamic>> fetchApi() async {
    Dio dio = Dio();

    var response =
        await dio.get('https://74gslzvj-8000.asse.devtunnels.ms/api/getProduk');

    print(response.data.toString());

    return response.data;
  }

  const Produk({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchApi(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
              //menampilkan ke gridview
              itemCount: snapshot.data?.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                return Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://74gslzvj-8000.asse.devtunnels.ms/uploads/',
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                      ),
                      Row(
                        children: [
                          Text(snapshot.data![index]['judul_produk']),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Rp. ${snapshot.data![index]['harga']}',
                            style: GoogleFonts.josefinSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffFF0A0A),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
