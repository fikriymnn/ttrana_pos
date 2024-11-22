import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/produk/tanaman_kasir.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/produk/bayar_kasir.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/produk/burung_kasir.dart';
import 'package:ttrana_pos/pages/kasir/models/cart.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/produk/ikan_kasir.dart';
import 'package:ttrana_pos/widget/responsive.dart';

class ProdukKasir extends StatefulWidget {
  const ProdukKasir({super.key});

  @override
  State<ProdukKasir> createState() => _ProdukKasirState();
}

class _ProdukKasirState extends State<ProdukKasir> {
  List<String> tabs = [
    "Tanaman",
    "Ikan",
    "Burung",
  ];
  double changePositionM(Size size) {
    switch (current) {
      case 0:
        return size.width * 0.237;
      case 1:
        return size.width * 0.354;
      case 2:
        return size.width * 0.428;

      default:
        return 0;
    }
  }

  double changeContainerWidthM(Size size) {
    switch (current) {
      case 0:
        return size.width * 0.087;
      case 1:
        return size.width * 0.041;
      case 2:
        return size.width * 0.067;

      default:
        return 0;
    }
  }

  double changePositionT(Size size) {
    switch (current) {
      case 0:
        return size.width * 0.237;
      case 1:
        return size.width * 0.353;
      case 2:
        return size.width * 0.425;

      default:
        return 0;
    }
  }

  double changeContainerWidthT(Size size) {
    switch (current) {
      case 0:
        return size.width * 0.086;
      case 1:
        return size.width * 0.042;
      case 2:
        return size.width * 0.069;

      default:
        return 0;
    }
  }

  int current = 0;

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
      backgroundColor: const Color.fromARGB(255, 202, 231, 239),
      body: Responsive(
        // Tampilan mobile
        mobile: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.03,
                  ),
                  child: Container(
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
                                        final quantity =
                                            item['quantity'] as int;
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
                                padding:
                                    EdgeInsets.only(left: size.width * 0.01),
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
                                padding:
                                    EdgeInsets.only(left: size.width * 0.01),
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
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.26),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: size.width * 0.20,
                        left: size.width * 0.20,
                        top: size.height * 0.05,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: size.height * 0.009,
                            horizontal: size.width * 0.02,
                          ),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.3,
                              height: size.height * 0.05,
                              // color: Colors.black,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: tabs.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        current = index;
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: index == 0
                                            ? size.width * 0.016
                                            : size.width * 0.034,
                                      ),
                                      child: Text(
                                        tabs[index],
                                        style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.0196,
                                          fontWeight: current == index
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: current == index
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        AnimatedPositioned(
                          bottom: 0,
                          left: changePositionT(size),
                          curve: Curves.fastEaseInToSlowEaseOut,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: changeContainerWidthT(size),
                            height: size.height * 0.006,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                            ),
                          ),
                          duration: const Duration(milliseconds: 500),
                        ),
                      ],
                    ),
                    SizedBox(height: size.width * 0.015),
                    Stack(
                      children: [
                        IndexedStack(
                          index: current,
                          children: [
                            TanamanKasir(),
                            IkanKasir(),
                            BurungKasir(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.26,
                ),
                child: Container(
                  width: size.width * 0.739,
                  height: size.height * 0.1,
                  // color: Colors.black,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BayarKasir()));
                    },
                    child: Center(
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
                  ),
                ),
              ),
            ),
          ],
        ),
        // Tampilan tablet
        tablet: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.03,
                  ),
                  child: Container(
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
                                        final quantity =
                                            item['quantity'] as int;
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
                                padding:
                                    EdgeInsets.only(left: size.width * 0.01),
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
                                padding:
                                    EdgeInsets.only(left: size.width * 0.01),
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
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.26),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: size.width * 0.20,
                        left: size.width * 0.20,
                        top: size.height * 0.05,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: size.height * 0.009,
                            horizontal: size.width * 0.02,
                          ),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.3,
                              height: size.height * 0.045,
                              // color: Colors.black,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: tabs.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        current = index;
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: index == 0
                                            ? size.width * 0.016
                                            : size.width * 0.034,
                                      ),
                                      child: Text(
                                        tabs[index],
                                        style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.0196,
                                          fontWeight: current == index
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: current == index
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        AnimatedPositioned(
                          bottom: 0,
                          left: changePositionT(size),
                          curve: Curves.fastEaseInToSlowEaseOut,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: changeContainerWidthT(size),
                            height: size.height * 0.006,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                            ),
                          ),
                          duration: const Duration(milliseconds: 500),
                        ),
                      ],
                    ),
                    SizedBox(height: size.width * 0.015),
                    Stack(
                      children: [
                        IndexedStack(
                          index: current,
                          children: [
                            TanamanKasir(),
                            IkanKasir(),
                            BurungKasir(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.26,
                ),
                child: Container(
                  width: size.width * 0.739,
                  height: size.height * 0.1,
                  // color: Colors.black,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BayarKasir()));
                    },
                    child: Center(
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
