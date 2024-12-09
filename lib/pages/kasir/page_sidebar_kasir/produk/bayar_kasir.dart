import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttrana_pos/pages/kasir/models/cart.dart';
import 'package:ttrana_pos/pages/kasir/printer_struck_kasir.dart';

class BayarKasir extends StatefulWidget {
  final Cart produkCart;
  final double totalHarga;
  final double subTotal;
  final List<Map<String, dynamic>> produkItems;

  const BayarKasir({
    required this.produkCart,
    required this.totalHarga,
    required this.subTotal,
    required this.produkItems,
    Key? key,
  }) : super(key: key);

  @override
  State<BayarKasir> createState() => _BayarKasirState();
}

class _BayarKasirState extends State<BayarKasir> {
  String? token;
  String? _selectedItem;
  final TextEditingController _nominalController = TextEditingController();

  final List<String> _pembayaran = [
    "Dana",
    "Gopay",
    "M-Banking",
    "Ovo",
    "SeaBank"
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
  }

  void _onNominalChanged(String value) {
    String rawValue = value.replaceAll('Rp ', '').replaceAll('.', '').trim();

    if (rawValue.isNotEmpty) {
      try {
        int numberValue = int.parse(rawValue);
        String formattedValue = NumberFormat.currency(
                locale: "id_ID", symbol: "Rp ", decimalDigits: 0)
            .format(numberValue);
        _nominalController.value = TextEditingValue(
          text: formattedValue,
          selection: TextSelection.collapsed(offset: formattedValue.length),
        );
      } catch (_) {}
    } else {
      _nominalController.value = TextEditingValue(text: '');
    }
  }

  Future<void> _kirimTransaksi() async {
    if (_selectedItem == null || _nominalController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Isi nominal dan metode pembayaran!")),
      );
      return;
    }

    final nominal = double.tryParse(
      _nominalController.text.replaceAll('Rp ', '').replaceAll('.', '').trim(),
    );

    if (nominal == null || nominal < widget.subTotal) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nominal kurang dari subtotal!")),
      );
      return;
    }

    final transaksiData = {
      'metode_transaksi': 'offline',
      'metode_pembayaran': _selectedItem,
      'produk': widget.produkItems.map((item) {
        return {
          'id_produk': item['id_produk'],
          'jumlah': item['jumlah'],
          'id_subvariasi': item['id_subvariasi'],
        };
      }).toList(),
    };

    try {
      Dio dio = Dio();
      final response = await dio.post(
        'https://74gslzvj-8000.asse.devtunnels.ms/api/transaksiKasir',
        data: transaksiData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        _navigateToPrinterStruckKasir();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaksi Berhasil')),
        );
      } else {
        // Tangkap pesan kesalahan dari backend
        final errorMessage = response.data['message'] ?? 'Terjadi kesalahan';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengirim transaksi: $errorMessage')),
        );

        // Cek jika ada error terkait stok produk
        if (response.data['errors'] != null) {
          for (var error in response.data['errors']) {
            debugPrint('Error Produk: ${error['message']}');
          }
        }
      }
    } on DioError catch (dioError) {
      // Tangkap kesalahan jaringan atau server
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kesalahan jaringan: ${dioError.message}')),
      );

      // Tampilkan log detail kesalahan
      if (dioError.response != null) {
        debugPrint('Response Data: ${dioError.response!.data}');
      }
    } catch (e) {
      // Tangkap kesalahan tak terduga
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kesalahan tak terduga: $e')),
      );
      debugPrint('Error: $e');
    }
  }

  void _navigateToPrinterStruckKasir() {
    final nominal = double.tryParse(
      _nominalController.text.replaceAll('Rp ', '').replaceAll('.', '').trim(),
    );

    print('Navigasi ke Printer Struck dengan nominal: $nominal');
    print('Subtotal: ${widget.subTotal}');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrinterStruckKasir(
          nominalDiberikan: nominal ?? 0.0,
          subTotal: widget.subTotal,
          metodePembayaran: _selectedItem!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    String formatAngka(double angka) {
      final formatter = NumberFormat('#,##0', 'id_ID');
      return formatter.format(angka);
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 202, 231, 239),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPembayaranSection(size, formatAngka),
        ],
      ),
    );
  }

  Widget _buildPembayaranSection(
      Size size, String Function(double) formatAngka) {
    return Container(
      height: size.height,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(size.width * 0.02),
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              "Rp. ${formatAngka(widget.subTotal)}",
              style: GoogleFonts.josefinSans(fontSize: size.width * 0.037),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.1),
            child: Divider(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: _buildNominalInput(size),
          ),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: _buildDropdown(size),
          ),
          Spacer(),
          GestureDetector(
            onTap: _kirimTransaksi,
            child: Container(
              height: 50,
              width: double.infinity,
              color: Color.fromARGB(255, 69, 165, 97),
              child: Center(
                child: Text(
                  "Bayar",
                  style: GoogleFonts.josefinSans(
                    fontSize: size.width * 0.018,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNominalInput(Size size) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Row(
        children: [
          Text(
            "Tunai",
            style: GoogleFonts.josefinSans(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: size.width * 0.02),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: size.width * 0.11),
              child: TextField(
                controller: _nominalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(255, 130, 212, 181),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Color(0xff3F9272),
                      width: 1,
                    ),
                  ),
                  hintText: "Masukkan nominal",
                  hintStyle: TextStyle(
                    color: Color(0xff3F9272),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                onChanged: _onNominalChanged,
                style: TextStyle(color: Color(0xff3F9272)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(Size size) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Row(
        children: [
          Text(
            "Metode Pembayaran",
            style: GoogleFonts.josefinSans(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: size.width * 0.02),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 130, 212, 181),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: const Color(0xff3F9272),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownButton<String>(
                value: _selectedItem,
                isExpanded: true,
                underline: const SizedBox(),
                hint: const Text(
                  'Pilih metode pembayaran',
                  style: TextStyle(
                    color: Color(0xff3F9272),
                  ),
                ),
                items: _pembayaran.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Color(0xff3F9272),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedItem = value;
                  });
                },
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xff3F9272),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
