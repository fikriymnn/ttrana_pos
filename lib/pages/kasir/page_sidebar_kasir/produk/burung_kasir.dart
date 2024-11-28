// Halaman Tanaman
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ttrana_pos/services/api_services.dart';
import 'package:ttrana_pos/pages/kasir/models/produk.dart';
import 'package:ttrana_pos/pages/kasir/models/cart.dart';
import 'package:ttrana_pos/widget/responsive.dart';
import 'package:intl/intl.dart';

class BurungKasir extends StatefulWidget {
  const BurungKasir({super.key});

  @override
  State<BurungKasir> createState() => _BurungKasirState();
}

class _BurungKasirState extends State<BurungKasir> {
  // Model produk dan pemanggilan API
  late Future<List<Product>> _product;

  @override
  void initState() {
    super.initState();
    _product = ApiService().getProductsTanaman();
  }

  // Pop up input jumlah untuk tablet
  void _showQuantityDialogTablet(BuildContext context, Product product) {
    final size = MediaQuery.of(context).size;
    final cartProvider = context.read<Cart>();

    int quantity = 1; // Jumlah default

    int? _selectedColor; // Indeks warna yang dipilih

    final List<dynamic> category = product.variasis
            ?.expand((variasi) => variasi.subvariasis ?? [])
            .map((subvariasi) => subvariasi.namaSubVariasi ?? "Tidak diketahui")
            .toList() ??
        [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Masukkan Detail Produk'),
              content: Container(
                height: size.height * 0.3,
                width: size.width * 0.3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 5),
                      Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: size.height * 0.01),
                            child: Text(
                              "Warna",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10.0,
                            children: List.generate(category.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedColor = index;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: _selectedColor == index
                                        ? const Color(0xFF28DFB1)
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: _selectedColor == index
                                          ? const Color(0xFF28DFB1)
                                          : Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    category[index],
                                    style: TextStyle(
                                      color: _selectedColor == index
                                          ? Colors.white
                                          : Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                            icon: Icon(Icons.remove),
                          ),
                          Text('$quantity'),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Batal'),
                ),
                TextButton(
                  onPressed: () {
                    if (_selectedColor != null) {
                      final selectedColor = category[_selectedColor!];

                      cartProvider.addToCart(product, quantity, selectedColor);
                      Navigator.pop(context);
                    } else {
                      // Tampilkan pesan error jika warna/usia tidak dipilih
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Pilih warna terlebih dahulu')),
                      );
                    }
                  },
                  child: Text('Tambah'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Pop up input jumlah untuk Mobile
  void _showQuantityDialogMobile(BuildContext context, Product product) {
    final size = MediaQuery.of(context).size;
    final cartProvider = context.read<Cart>();

    int quantity = 1; // Jumlah default

    int? _selectedColor; // Indeks warna yang dipilih

    final List<dynamic> category = product.variasis
            ?.expand((variasi) => variasi.subvariasis ?? [])
            .map((subvariasi) => subvariasi.namaSubVariasi ?? "Tidak diketahui")
            .toList() ??
        [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Masukkan Detail Produk'),
              content: Container(
                height: size.height * 0.3,
                width: size.width * 0.3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 5),
                      Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: size.height * 0.01),
                            child: Text(
                              "Warna",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10.0,
                            children: List.generate(category.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedColor = index;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: _selectedColor == index
                                        ? const Color(0xFF28DFB1)
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: _selectedColor == index
                                          ? const Color(0xFF28DFB1)
                                          : Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    category[index],
                                    style: TextStyle(
                                      color: _selectedColor == index
                                          ? Colors.white
                                          : Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                            icon: Icon(Icons.remove),
                          ),
                          Text('$quantity'),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Batal'),
                ),
                TextButton(
                  onPressed: () {
                    if (_selectedColor != null) {
                      final selectedColor = category[_selectedColor!];

                      cartProvider.addToCart(product, quantity, selectedColor);
                      Navigator.pop(context);
                    } else {
                      // Tampilkan pesan error jika warna/usia tidak dipilih
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Pilih warna terlebih dahulu')),
                      );
                    }
                  },
                  child: Text('Tambah'),
                ),
              ],
            );
          },
        );
      },
    );
  }

// Rupiah
  String formatAngka(double angka) {
    final formatter = NumberFormat(
        '#,##0', 'id_ID'); // Menggunakan locale Indonesia dengan format titik
    return formatter.format(angka); // Hasilnya akan seperti 1.000.000
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Responsive(
      // Tampilan Mobile
      mobile: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
              vertical: size.height * 0.02,
            ),
            child: Container(
              height: size.height, // Menggunakan ukuran lebar untuk tinggi
              width: size.width * 0.65,
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<List<Product>>(
                        future: _product,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(child: Text('No products available'));
                          }

                          final tanaman = snapshot.data!;

                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.7,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.01,
                              vertical: size.height * 0.01,
                            ),
                            itemCount: tanaman.length,
                            itemBuilder: (context, index) {
                              final product = tanaman[index];
                              return GestureDetector(
                                onTap: () {
                                  _showQuantityDialogMobile(context, product);
                                },
                                child: Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: size.width * 0.01,
                                      left: size.width * 0.01,
                                      top: size.height * 0.1,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: product.fotoProduk != null &&
                                                  product.fotoProduk!.isNotEmpty
                                              ? Image.network(
                                                  'https://74gslzvj-8000.asse.devtunnels.ms${product.fotoProduk}',
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Container(
                                                      color: Colors.grey[200],
                                                      child: Icon(Icons
                                                          .image_not_supported),
                                                    );
                                                  },
                                                )
                                              : Container(
                                                  color: Colors.grey[200],
                                                  child: Icon(Icons
                                                      .image_not_supported),
                                                ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.008,
                                            vertical: size.height * 0.008,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.judulProduk!,
                                                style: GoogleFonts.josefinSans(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "Rp. ${product.harga != null ? formatAngka(product.harga!.toDouble()) : 'Tidak ada harga'}",
                                                style: GoogleFonts.josefinSans(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.red,
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
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // Tampilan Tablet
      tablet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
              vertical: size.height * 0.02,
            ),
            child: Container(
              height: size.height,
              width: size.width * 0.65,
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<List<Product>>(
                        future: _product,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No products available'));
                          }

                          final tanaman = snapshot.data!;

                          return GridView.builder(
                            itemCount: tanaman.length,
                            padding: const EdgeInsets.all(20),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 25,
                              childAspectRatio: 0.7,
                            ),
                            itemBuilder: (context, index) {
                              var product = tanaman[index];

                              // Mengambil subvariasi pertama untuk contoh
                              final firstSubvariasi = product.variasis
                                  ?.expand(
                                      (variasi) => variasi.subvariasis ?? [])
                                  .toList()
                                  .firstOrNull;

                              return GestureDetector(
                                onTap: () {
                                  _showQuantityDialogTablet(context, product);
                                },
                                child: Card(
                                  elevation: 2,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: size.width * 0.01,
                                      left: size.width * 0.01,
                                      top: size.height * 0.03,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: product.fotoProduk != null &&
                                                  product.fotoProduk!.isNotEmpty
                                              ? Image.network(
                                                  'https://74gslzvj-8000.asse.devtunnels.ms${product.fotoProduk!}',
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Container(
                                                      color: Colors.grey[200],
                                                      child: const Icon(Icons
                                                          .image_not_supported),
                                                    );
                                                  },
                                                )
                                              : Container(
                                                  color: Colors.grey[200],
                                                  child: const Icon(Icons
                                                      .image_not_supported),
                                                ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.008,
                                            vertical: size.height * 0.008,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.judulProduk ??
                                                    'Tanpa Judul',
                                                style: GoogleFonts.josefinSans(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Rp. ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(product.harga)}',
                                                    style:
                                                        GoogleFonts.josefinSans(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.red,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Stok: ${product.jumlahProduk}",
                                                    style:
                                                        GoogleFonts.josefinSans(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
