import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AdminPermintaanPage extends StatefulWidget {
  @override
  _AdminPermintaanPageState createState() => _AdminPermintaanPageState();
}

class _AdminPermintaanPageState extends State<AdminPermintaanPage> {
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
          permintaanData = response.data ?? [];
          isLoading = false;
        });
      } else {
        _showError('Gagal mendapatkan data: ${response.statusCode}');
      }
    } catch (e) {
      _showError('Error saat mengambil data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateStatus(int id, String status) async {
    try {
      final response = await _dio.put(
        'https://74gslzvj-8000.asse.devtunnels.ms/api/editStatus/$id',
        data: {
          'status': status,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status berhasil diperbarui menjadi $status')),
        );
        fetchPermintaanData(); // Refresh data setelah update
      } else {
        _showError('Gagal memperbarui status: ${response.statusCode}');
      }
    } catch (e) {
      _showError('Error saat memperbarui status: $e');
    }
  }

  void _showError(String message) {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 73, 142, 125),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size.width * 0.004),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatAngka(double angka) {
    final formatter = NumberFormat('#,##0', 'id_ID');
    return formatter.format(angka);
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
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
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
                        columnSpacing: size.width * 0.001,
                        columns: [
                          DataColumn(
                            label: Container(
                              width: size.width *
                                  0.1, // Set a fixed width for the column
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
                                  0.1, // Set a fixed width for the column
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
                                Center(
                                    child: Text(item['nama_produk'] ??
                                        'Tidak ada nama')),
                              ),
                              DataCell(
                                Center(
                                    child:
                                        Text(item['stok']?.toString() ?? '0')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        'Rp. ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(item['hargaSatuan'])}'
                                                .toString() ??
                                            '0')),
                              ),
                              DataCell(
                                
                                Center(
                                    child:
                                        Text(item['total']?.toString() ?? '0')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(item['deskripsi'] ??
                                        'Tidak ada deskripsi')),
                              ),
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
                                                  onPressed: () => updateStatus(
                                                      item['id'], 'ya'),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Color(0xFF3F9272),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Terima",
                                                    style:
                                                        GoogleFonts.josefinSans(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.01,
                                              ),
                                              Container(
                                                width: size.width * 0.07,
                                                height: size.width * 0.02,
                                                child: ElevatedButton(
                                                  onPressed: () => updateStatus(
                                                      item['id'], 'tidak'),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Color(0xFFC7C5C5),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Tolak",
                                                    style:
                                                        GoogleFonts.josefinSans(
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
            ),
    );
  }
}
