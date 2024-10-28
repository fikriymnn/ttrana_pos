import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/produk/bayar_berhasil_kasir.dart';
import 'package:ttrana_pos/pages/kasir/models/cart.dart';
import 'package:ttrana_pos/responsive.dart';

class BayarKasir extends StatefulWidget {
  const BayarKasir({super.key});

  @override
  State<BayarKasir> createState() => _BayarKasirState();
}

class _BayarKasirState extends State<BayarKasir> {
  final TextEditingController _nominalController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final produkTanaman =
        context.watch<Cart>(); // Akses provider model ProdukTanaman
    var size = MediaQuery.of(context).size;
    // Hitung total harga
    final totalHarga =
        produkTanaman.cart.fold(0, (previousValue, productEntry) {
      final tanaman = productEntry.keys.first;
      final quantity = productEntry[tanaman]!;

      return previousValue + (tanaman.harga * quantity);
    });
    // Hitung Subtotal harga
    final subTotal = produkTanaman.cart.fold(0, (previousValue, productEntry) {
      final tanaman = productEntry.keys.first;
      final quantity = productEntry[tanaman]!;
      final ppn = totalHarga * 0.02; //Hitung ppn

      return previousValue + (tanaman.harga * quantity + ppn.toInt() + 2500);
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
                        child: produkTanaman.cart.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: produkTanaman.cart.length,
                                  itemBuilder: (context, index) {
                                    // Each cart entry is a Map<tanaman, int>
                                    final productEntry =
                                        produkTanaman.cart[index];
                                    final tanaman = productEntry.keys.first;
                                    final quantity = productEntry[tanaman]!;

                                    // final ppn = tanaman.harga * 0.02;

                                    return ListTile(
                                      title: Text(tanaman.judulProduk),
                                      subtitle: Text(
                                        "Rp. ${formatAngka(tanaman.harga.toDouble())}",
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
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                top: size.height * 0.002,
                                left: size.width * 0.005,
                              ),
                              hintText: "Masukan Nominal",
                              hintStyle: GoogleFonts.josefinSans(
                                color: Color.fromARGB(255, 73, 142, 125),
                                fontSize: size.width * 0.019,
                              ),
                              border: InputBorder.none,
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
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BayarBerhasilKasir()));
                      },
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
                        child: produkTanaman.cart.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: produkTanaman.cart.length,
                                  itemBuilder: (context, index) {
                                    // Each cart entry is a Map<tanaman, int>
                                    final productEntry =
                                        produkTanaman.cart[index];
                                    final tanaman = productEntry.keys.first;
                                    final quantity = productEntry[tanaman]!;

                                    // final ppn = tanaman.harga * 0.02;

                                    return ListTile(
                                      title: Text(tanaman.judulProduk),
                                      subtitle: Text(
                                        "Rp. ${formatAngka(tanaman.harga.toDouble())}",
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
                          width: size.width * 0.07,
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
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                top: size.height * 0.002,
                                left: size.width * 0.005,
                              ),
                              hintText: "Masukan Nominal",
                              hintStyle: GoogleFonts.josefinSans(
                                color: Color.fromARGB(255, 73, 142, 125),
                                fontSize: size.width * 0.019,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.61,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BayarBerhasilKasir(),
                            ));
                      },
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
      ),
    );
  }
}
