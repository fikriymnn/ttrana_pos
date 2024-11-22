import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttrana_pos/pages/kasir/printer_struck_kasir.dart';
import 'package:ttrana_pos/widget/InputNominal.dart';

import 'package:ttrana_pos/pages/kasir/models/cart.dart';
import 'package:ttrana_pos/widget/responsive.dart';

class BayarKasir extends StatefulWidget {
  const BayarKasir({super.key});

  @override
  State<BayarKasir> createState() => _BayarKasirState();
}

class _BayarKasirState extends State<BayarKasir> {
  String? token;

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

  //untuk pilihan metode pembayaran dropdownbutton
  final List<String> _pembayaran = [
    "dana",
    "gopay",
    "Mbanking",
    "ovo",
    "seaBank"
  ];
  //untuk menyimpan perubahan dropdownbutton untuk pembayaran
  String? _selectedItem;
  final TextEditingController _nominalController = TextEditingController();
  final NumberFormat _numberFormat =
      NumberFormat('#,##0', 'id_ID'); // Format untuk Indonesia

  @override
  void _onNominalChanged(String value) {
    String rawValue = value
        .replaceAll('Rp ', '')
        .replaceAll('Rp.', '')
        .replaceAll('.', '')
        .trim();

    if (rawValue.isNotEmpty) {
      try {
        int numberValue = int.parse(rawValue);
        String formattedValue = NumberFormat.currency(
                locale: "id_ID", symbol: "Rp ", decimalDigits: 0)
            .format(numberValue);

        _nominalController.value = TextEditingValue(
          text: formattedValue,
          selection: TextSelection.collapsed(
              offset: formattedValue.length), // Memindahkan cursor ke akhir
        );
      } catch (e) {
        print("Error: $e"); // Menangkap error parsing
      }
    } else {
      _nominalController.value = TextEditingValue(text: '');
    }
  }

  void _navigateToPrinterStruckKasir() {
    String nominal = _nominalController.text
        .replaceAll('Rp ', '')
        .replaceAll('.', '')
        .trim();

    print("Nilai yang akan dikirim: $nominal"); // Contoh pengiriman

    final double nominalDiberikan = double.tryParse(nominal) ?? 0.0;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PrinterStruckKasir(nominalDiberikan: nominalDiberikan),
      ),
    );
  }

  // Fungsi untuk mendapatkan nilai mentah
  String getRawValue() {
    // Menghapus karakter non-digit dari input
    return _nominalController.text.replaceAll(RegExp(r'[^0-9]'), '');
  }

  void dispose() {
    _nominalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final produkCart = context.watch<Cart>(); // Akses provider model Cart
    var size = MediaQuery.of(context).size;

// Hitung total harga
    final totalHarga = produkCart.cart.fold(0.0, (previousValue, item) {
      final product = item['product'];
      final quantity = item['quantity'] as int;

      return previousValue + (product.harga * quantity);
    });

// Hitung Subtotal harga
    final subTotal = produkCart.cart.fold(0.0, (previousValue, item) {
      final product = item['product'];
      final quantity = item['quantity'] as int;

      final itemTotal = product.harga * quantity; // Harga per item
      final ppn = itemTotal * 0.02; // Hitung PPN 2%
      final biayaLain = 2500; // Biaya tambahan tetap

      return previousValue + itemTotal + ppn + biayaLain;
    });

    // Rupiah
    String formatAngka(double angka) {
      final formatter = NumberFormat(
          '#,##0', 'id_ID'); // Menggunakan locale Indonesia dengan format titik
      return formatter.format(angka); // Hasilnya akan seperti 1.000.000
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Responsive(
        mobile: Expanded(
          child: Row(
            children: [
              Container(
                height: size.height,
                width: size.width * 0.23,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.14,
                      color: Color.fromARGB(255, 73, 142, 125),
                      child: Center(
                        child: Text(
                          "Produk",
                          style: GoogleFonts.josefinSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.02,
                          ),
                        ),
                      ),
                    ),
                    // Menampilkan produk yang di input
                    Expanded(
                      child: Container(
                        child: produkCart.cart.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: produkCart.cart.length,
                                  itemBuilder: (context, index) {
                                    // Setiap item di cart adalah Map<String, dynamic>
                                    final item = produkCart.cart[index];
                                    final product = item['product'];
                                    final quantity = item['quantity'] as int;
                                    final color = item['color']
                                        as String; // Warna yang dipilih
                                    final ageGroup = item['ageGroup']
                                        as String; // Usia yang dipilih

                                    return ListTile(
                                      title: Text(product.judulProduk!),
                                      subtitle: Text(
                                        "Rp. ${product.harga != null ? formatAngka(product.harga!.toDouble()) : 'Tidak ada harga'}",
                                        style: GoogleFonts.josefinSans(
                                          fontSize: 20,
                                          color: Color(0xffFF0A0A),
                                        ),
                                      ),
                                      trailing: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${quantity}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // trailing: Text(
                                      //   'Total: Rp ${tanaman.harga * quantity}',
                                      //   style: const TextStyle(
                                      //     fontWeight: FontWeight.bold,
                                      //     color: Colors.red,
                                      //   ),
                                      // ),
                                    );
                                  },
                                ),
                              )
                            : const Center(
                                child: Text('Kosong'),
                              ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Divider(
                            thickness: 2,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.01),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Total",
                                      style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.018),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.073,
                                    ),
                                    Text(
                                      "Rp. ${formatAngka(totalHarga.toDouble())}",
                                      style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.018),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "PPN",
                                      style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.018),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.077,
                                    ),
                                    Text(
                                      "2%",
                                      style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.018),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Service",
                                      style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.018),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.055,
                                    ),
                                    Text(
                                      "Rp. 2.500",
                                      style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.018),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 3,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.01),
                            child: Row(
                              children: [
                                Text(
                                  "Sub Total",
                                  style: GoogleFonts.josefinSans(
                                      fontSize: size.width * 0.018),
                                ),
                                SizedBox(
                                  width: size.width * 0.035,
                                ),
                                Text(
                                  "Rp. ${formatAngka(subTotal.toDouble())}",
                                  style: GoogleFonts.josefinSans(
                                      fontSize: size.width * 0.018),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height,
                width: size.width * 0.73,
                color: const Color.fromARGB(255, 202, 231, 239),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.026,
                              left: size.width * 0.026),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: size.width * 0.036,
                              height: size.width * 0.036,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.06),
                                  ),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  )),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back,
                                  size: size.width * 0.023,
                                  color: Color.fromARGB(255, 73, 142, 125),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Rp. ${formatAngka(subTotal.toDouble())}",
                      style:
                          GoogleFonts.josefinSans(fontSize: size.width * 0.037),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.02,
                          left: size.width * 0.035,
                          right: size.width * 0.035,
                          bottom: size.height * 0.02),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.035,
                        ),
                        Text(
                          "Tunai",
                          style: GoogleFonts.josefinSans(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.02,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.17,
                        ),
                        Container(
                          height: size.height * 0.07,
                          width: size.width * 0.17,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 169, 240, 210),
                            borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 0.003),
                            ),
                            border: Border.all(
                              width: size.width * 0.001,
                              color: Color.fromARGB(255, 73, 142, 125),
                            ),
                          ),
                          child: TextField(
                            controller: _nominalController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Masukan nominal',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.05,
                        bottom: size.height * 0.08,
                        left: size.width * 0.035,
                        right: size.width * 0.035,
                      ),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.035,
                        ),
                        Text(
                          "Transfer",
                          style: GoogleFonts.josefinSans(
                            fontSize: size.width * 0.02,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.14,
                        ),
                        Container(
                          width: size.width * 0.35,
                          height: size.height * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.wallet_outlined,
                                size: size.width * 0.03,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: size.width * 0.019,
                              ),
                              Text(
                                "Belum Ada Rekening Transfer",
                                style: GoogleFonts.josefinSans(
                                  color: Colors.grey,
                                  fontSize: size.width * 0.017,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.025,
                              ),
                              Text(
                                "Pilih",
                                style: GoogleFonts.josefinSans(
                                  color: Colors.grey,
                                  fontSize: size.width * 0.017,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.39,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: size.width * 0.12,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 73, 142, 125),
                          borderRadius:
                              BorderRadius.circular(size.width * 0.006),
                        ),
                        child: Center(
                          child: Text(
                            "Bayar",
                            style: GoogleFonts.josefinSans(
                              color: Colors.white,
                              fontSize: size.width * 0.016,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        tablet: Expanded(
          child: Row(
            children: [
              Container(
                height: size.height,
                width: size.width * 0.23,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.1,
                      color: Color.fromARGB(255, 73, 142, 125),
                      child: Center(
                        child: Text(
                          "Produk",
                          style: GoogleFonts.josefinSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.02,
                          ),
                        ),
                      ),
                    ),
                    // Menampilkan produk yang di input
                    Expanded(
                      child: Container(
                        child: produkCart.cart.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: produkCart.cart.length,
                                  itemBuilder: (context, index) {
                                    final item = produkCart.cart[index];
                                    final product = item['product'];
                                    final quantity = item['quantity'] as int;
                                    final color = item['color']
                                        as String; // Warna yang dipilih
                                    final ageGroup = item['ageGroup']
                                        as String; // Usia yang dipilih

                                    return ListTile(
                                      title: Text(product.judulProduk!),
                                      subtitle: Text(
                                        "Rp. ${product.harga != null ? formatAngka(product.harga!.toDouble()) : 'Tidak ada harga'}",
                                        style: GoogleFonts.josefinSans(
                                          fontSize: 20,
                                          color: Color(0xffFF0A0A),
                                        ),
                                      ),
                                      trailing: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${quantity}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // trailing: Text(
                                      //   'Total: Rp ${tanaman.harga * quantity}',
                                      //   style: const TextStyle(
                                      //     fontWeight: FontWeight.bold,
                                      //     color: Colors.red,
                                      //   ),
                                      // ),
                                    );
                                  },
                                ),
                              )
                            : const Center(
                                child: Text('Kosong'),
                              ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Divider(
                            thickness: 2,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.01),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Total",
                                      style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.018),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.073,
                                    ),
                                    Text(
                                      "Rp. ${formatAngka(totalHarga.toDouble())}",
                                      style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.018),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "PPN",
                                      style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.018),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.077,
                                    ),
                                    Text(
                                      "2%",
                                      style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.018),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Service",
                                      style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.018),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.055,
                                    ),
                                    Text(
                                      "Rp. 2.500",
                                      style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.018),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 3,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.01),
                            child: Row(
                              children: [
                                Text(
                                  "Sub Total",
                                  style: GoogleFonts.josefinSans(
                                      fontSize: size.width * 0.018),
                                ),
                                SizedBox(
                                  width: size.width * 0.035,
                                ),
                                Text(
                                  "Rp. ${formatAngka(subTotal.toDouble())}",
                                  style: GoogleFonts.josefinSans(
                                      fontSize: size.width * 0.018),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height,
                width: size.width * 0.769,
                color: const Color.fromARGB(255, 202, 231, 239),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.026,
                              left: size.width * 0.026),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: size.width * 0.036,
                              height: size.width * 0.036,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.06),
                                  ),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  )),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back,
                                  size: size.width * 0.023,
                                  color: Color.fromARGB(255, 73, 142, 125),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Rp. ${formatAngka(subTotal.toDouble())}",
                      style:
                          GoogleFonts.josefinSans(fontSize: size.width * 0.037),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.02,
                          left: size.width * 0.035,
                          right: size.width * 0.035,
                          bottom: size.height * 0.02),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.035,
                        ),
                        Text(
                          "Tunai",
                          style: GoogleFonts.josefinSans(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.02,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.139,
                        ),
                        Container(
                          height: size.height * 0.07,
                          width: size.width * 0.17,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 169, 240, 210),
                            borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 0.003),
                            ),
                            border: Border.all(
                              width: size.width * 0.001,
                              color: Color.fromARGB(255, 73, 142, 125),
                            ),
                          ),
                          child: TextField(
                            controller: _nominalController,
                            keyboardType: TextInputType.number,
                            onChanged:
                                _onNominalChanged, // Panggil fungsi saat terjadi perubahan
                            decoration: InputDecoration(
                              hintText: 'Masukan nominal',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 73, 142, 125),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.02,
                                  horizontal: size.width * 0.02),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.035,
                        ),
                        Text(
                          "Metode\nPembayaran",
                          style: GoogleFonts.josefinSans(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.02,
                          ),
                        ),
                        SizedBox(width: size.width * 0.07),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 169, 240, 210),
                            borderRadius: BorderRadius.all(
                              Radius.circular(size.width * 0.003),
                            ),
                            border: Border.all(
                              width: size.width * 0.001,
                              color: Color.fromARGB(255, 73, 142, 125),
                            ),
                          ),
                          child: DropdownButton<String>(
                            underline: SizedBox(),
                            style: GoogleFonts.josefinSans(
                              color: Color.fromARGB(255, 73, 142, 125),
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.017,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.002),
                            value: _selectedItem,
                            dropdownColor:
                                const Color.fromARGB(255, 169, 240, 210),
                            hint: Text(
                              "Pilih Pembayaran",
                              style:
                                  GoogleFonts.josefinSans(color: Colors.grey),
                            ),
                            items: _pembayaran.map(
                              (String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              },
                            ).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedItem = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.31,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 73, 142, 125),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.006),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.02,
                          horizontal: size.width * 0.04,
                        ),
                      ),
                      onPressed: () {
                        _navigateToPrinterStruckKasir();
                      },
                      child: Text(
                        "Bayar",
                        style: GoogleFonts.josefinSans(
                          color: Colors.white,
                          fontSize: size.width * 0.016,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
