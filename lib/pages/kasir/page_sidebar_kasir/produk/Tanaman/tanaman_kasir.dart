// Halaman Tanaman
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/produk/Tanaman/api_services.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/produk/Tanaman/model_tanaman.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/produk/cart.dart';
import 'package:ttrana_pos/responsive.dart';

class TanamanKasir extends StatefulWidget {
  const TanamanKasir({super.key});

  @override
  State<TanamanKasir> createState() => _TanamanKasirState();
}

class _TanamanKasirState extends State<TanamanKasir> {
  // Model produk dan pemanggilan API
  late Future<List<ProdukTanaman>> _produkTanaman;

  @override
  void initState() {
    super.initState();
    _produkTanaman = ApiService().getProducts();
  }

  int _selected = -1;
  int _selectedUsia = -1;

  final List<String> category = [
    'Putih',
    'Merah',
    'Kuning',
    'pink',
    'ungu',
  ];
  final List<String> categoryUsia = [
    '2 Bulan',
    '3 Bulan',
    '4 Bulan',
    '5 Bulan',
    '6 Bulan',
    '1 Tahun',
    'lebih 1 Tahun',
  ];

  // Pop up input jumlah untuk tablet
  void _showQuantityDialogTablet(BuildContext context, ProdukTanaman product) {
    final size = MediaQuery.of(context).size;
    final produkTanaman = context.read<Cart>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int quantity = 1; // Jumlah default
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Masukkan Detail Produk',
              ),
              content: Container(
                height: 350,
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Produk: ${product.judulProduk}'),
                    Text('Harga: Rp. ${product.harga}'),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Warna"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      spacing: 10, // Jarak horizontal antar item
                      runSpacing: 10.0, // Jarak vertikal antar baris
                      children: List.generate(category.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selected = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(
                                milliseconds: 300), // Animasi perubahan warna
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: _selected == index
                                  ? const Color(0xFF28DFB1)
                                  : Colors.transparent,
                              border: Border.all(
                                color: _selected == index
                                    ? const Color(0xFF28DFB1)
                                    : Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              category[index],
                              style: TextStyle(
                                color: _selected == index
                                    ? Colors.white
                                    : Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Usia"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      spacing: 10, // Jarak horizontal antar item
                      runSpacing: 10.0, // Jarak vertikal antar baris
                      children: List.generate(categoryUsia.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedUsia = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(
                                milliseconds: 300), // Animasi perubahan warna
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: _selectedUsia == index
                                  ? const Color(0xFF28DFB1)
                                  : Colors.transparent,
                              border: Border.all(
                                color: _selectedUsia == index
                                    ? const Color(0xFF28DFB1)
                                    : Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              categoryUsia[index],
                              style: TextStyle(
                                color: _selectedUsia == index
                                    ? Colors.white
                                    : Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) {
                                quantity--;
                              }
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
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Batal'),
                ),
                TextButton(
                  onPressed: () {
                    produkTanaman.addToCart(product, quantity);
                    Navigator.pop(context);
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
  void _showQuantityDialogMobile(BuildContext context, ProdukTanaman product) {
    final size = MediaQuery.of(context).size;
    final produkTanaman = context.read<Cart>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int quantity = 1; // Jumlah default
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Masukkan Detail Produk , Mobile',
              ),
              content: Container(
                height: 350,
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Produk: ${product.judulProduk}'),
                    Text('Harga: Rp. ${product.harga}'),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Warna"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      spacing: 10, // Jarak horizontal antar item
                      runSpacing: 10.0, // Jarak vertikal antar baris
                      children: List.generate(category.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selected = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(
                                milliseconds: 300), // Animasi perubahan warna
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: _selected == index
                                  ? const Color(0xFF28DFB1)
                                  : Colors.transparent,
                              border: Border.all(
                                color: _selected == index
                                    ? const Color(0xFF28DFB1)
                                    : Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              category[index],
                              style: TextStyle(
                                color: _selected == index
                                    ? Colors.white
                                    : Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Usia"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      spacing: 10, // Jarak horizontal antar item
                      runSpacing: 10.0, // Jarak vertikal antar baris
                      children: List.generate(categoryUsia.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedUsia = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(
                                milliseconds: 300), // Animasi perubahan warna
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: _selectedUsia == index
                                  ? const Color(0xFF28DFB1)
                                  : Colors.transparent,
                              border: Border.all(
                                color: _selectedUsia == index
                                    ? const Color(0xFF28DFB1)
                                    : Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              categoryUsia[index],
                              style: TextStyle(
                                color: _selectedUsia == index
                                    ? Colors.white
                                    : Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) {
                                quantity--;
                              }
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
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Batal'),
                ),
                TextButton(
                  onPressed: () {
                    produkTanaman.addToCart(product, quantity);
                    Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Responsive(
      // Tampilan Mobile
      mobile: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: size.height, // Menggunakan ukuran lebar untuk tinggi
              width: size.width * 0.65,
              color: Colors.black,
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<List<ProdukTanaman>>(
                        future: _produkTanaman,
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
                            padding: const EdgeInsets.all(10),
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
                                    padding: const EdgeInsets.only(
                                      right: 18,
                                      left: 18,
                                      top: 15,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: product.fotoProduk != null
                                              ? Image.network(
                                                  'https://74gslzvj-8000.asse.devtunnels.ms${product.fotoProduk}',
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                )
                                              : Container(
                                                  color: Colors.grey[200],
                                                  child: Icon(
                                                    Icons.image_not_supported,
                                                  ),
                                                ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.judulProduk,
                                                style: GoogleFonts.josefinSans(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Rp. ${product.harga}',
                                                style: GoogleFonts.josefinSans(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xffFF0A0A),
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
            padding: const EdgeInsets.all(20),
            child: Container(
              height: size.height, // Menggunakan ukuran lebar untuk tinggi
              width: size.width * 0.65,
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<List<ProdukTanaman>>(
                        future: _produkTanaman,
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
                            padding: const EdgeInsets.all(10),
                            itemCount: tanaman.length,
                            itemBuilder: (context, index) {
                              final product = tanaman[index];
                              return GestureDetector(
                                onTap: () {
                                  _showQuantityDialogTablet(context, product);
                                },
                                child: Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 18,
                                      left: 18,
                                      top: 15,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: product.fotoProduk != null
                                              ? Image.network(
                                                  'https://74gslzvj-8000.asse.devtunnels.ms${product.fotoProduk}',
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                )
                                              : Container(
                                                  color: Colors.grey[200],
                                                  child: Icon(Icons
                                                      .image_not_supported),
                                                ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.judulProduk,
                                                style: GoogleFonts.josefinSans(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Rp. ${product.harga}',
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
    );
  }
}
