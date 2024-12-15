import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class StatusPermintaan extends StatefulWidget {
  @override
  _StatusPermintaanState createState() => _StatusPermintaanState();
}

class _StatusPermintaanState extends State<StatusPermintaan> {
  final Dio _dio = Dio();
  List<dynamic> permintaanData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPermintaanData();
  }

  Future<void> fetchPermintaanData() async {
    try {
      final response = await _dio.get(
        'https://74gslzvj-8000.asse.devtunnels.ms/api/getPermintaan',
      );

      if (response.statusCode == 200) {
        setState(() {
          permintaanData = response.data
              .where(
                  (item) => item['status'] == 'ya' || item['status'] == 'tidak')
              .toList();
          isLoading = false;
        });
      } else {
        print('Gagal mendapatkan data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error saat mengambil data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.only(left: size.width * 0.08),
                  child: Container(
                    color: Colors.white, // Background color of the table

                    child: SingleChildScrollView(
                      scrollDirection:
                          Axis.horizontal, // Enable horizontal scroll
                      child: DataTable(
                        border: TableBorder.symmetric(
                            outside:
                                BorderSide(color: Color(0xFF00796B), width: 2),
                            inside: BorderSide.none),
                        dataRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Color(0xFF00796B)),
                        columnSpacing: size.width * 0.01,
                        columns: [
                          DataColumn(
                            label: Container(
                              width: size.width *
                                  0.2, // Set a fixed width for the column
                              child: Text(
                                'Nama Produk',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: size.width *
                                  0.1, // Set a fixed width for the column
                              child: Text(
                                'Stok',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: size.width *
                                  0.1, // Set a fixed width for the column
                              child: Text(
                                'Harga (Satuan)',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: size.width *
                                  0.2, // Set a fixed width for the column
                              child: Text(
                                'Subtotal',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: size.width *
                                  0.1, // Set a fixed width for the column
                              child: Text(
                                'Deskripsi',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: size.width *
                                  0.1, // Set a fixed width for the column
                              child: Text(
                                'Status',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                        rows: permintaanData.map((item) {
                          final isAccepted = item['status'] == 'ya';
                          final isRejected = item['status'] == 'tidak';

                          return DataRow(
                            cells: [
                              DataCell(
                                  Center(child: Text(item['nama_produk']))),
                              DataCell(
                                  Center(child: Text(item['stok'].toString()))),
                              DataCell(Center(
                                  child: Text(item['hargaSatuan'].toString()))),
                              DataCell(Center(child: Text(item['total']))),
                              DataCell(Center(
                                  child: Text(item['deskripsi'].toString()))),
                              DataCell(
                                isAccepted
                                    ? Center(
                                        child: Icon(Icons.check_circle,
                                            color: Colors.green))
                                    : isRejected
                                        ? Center(
                                            child: Icon(Icons.close,
                                                color: Colors.red))
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xFF3F9272),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.zero,
                                                  ),
                                                ),
                                                child: Text(
                                                  "Terima",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xFFC7C5C5),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.zero,
                                                  ),
                                                ),
                                                child: Text(
                                                  "Tolak",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
