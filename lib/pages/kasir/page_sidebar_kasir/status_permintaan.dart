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
          // Filter data yang hanya memiliki status 'ya' atau 'tidak'
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
                child: Container(
                  color: Color(0xFFE0F7FA), // Warna latar belakang tabel
                  padding: EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      dataRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white), // Warna latar baris data
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Color(0xFF00796B)), // Warna latar header
                      columnSpacing: 12.0,
                      columns: [
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Nama Produk',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Stok',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Harga Satuan',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Deskripsi',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Subtotal',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
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
                          color: MaterialStateColor.resolveWith((states) {
                            if (isAccepted)
                              return Colors.green.withOpacity(0.2);
                            if (isRejected) return Colors.red.withOpacity(0.2);
                            return Colors.white;
                          }),
                          cells: [
                            DataCell(Center(child: Text(item['nama_produk']))),
                            DataCell(
                                Center(child: Text(item['stok'].toString()))),
                            DataCell(Center(
                                child: Text(item['hargaSatuan'].toString()))),
                            DataCell(Center(child: Text(item['deskripsi']))),
                            DataCell(
                                Center(child: Text(item['total'].toString()))),
                            DataCell(
                              isAccepted
                                  ? Center(
                                      child: Icon(Icons.check_circle,
                                          color: Colors.green),
                                    )
                                  : isRejected
                                      ? Center(
                                          child: Icon(Icons.close,
                                              color: Colors.red),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: size.width * 0.07,
                                              height: size.width * 0.02,
                                              child: ElevatedButton(
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
                                            ),
                                            SizedBox(width: size.width * 0.01),
                                            Container(
                                              width: size.width * 0.07,
                                              height: size.width * 0.02,
                                              child: ElevatedButton(
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
    );
  }
}
