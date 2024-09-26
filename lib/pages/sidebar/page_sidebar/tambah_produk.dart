import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart'; // Import package dotted_border

class TambahProduk extends StatefulWidget {
  const TambahProduk({super.key});

  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  String _produk = 'opsi 1';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(80),
            color: Color(0xFFE2FFF5),
            width: size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(0.8),
                ),
                Container(
                  width: size.width * 0.50,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nama Produk",
                              style: GoogleFonts.josefinSans(
                                  color: Color(0xFF3F9272))),
                          Container(
                            width: size.width * 0.5,
                            child: TextField(
                              decoration: InputDecoration(
                                fillColor:
                                    Colors.white, // Warna latar belakang putih
                                filled: true, // Mengaktifkan fillColor

                                hintStyle: GoogleFonts.josefinSans(
                                  fontWeight: FontWeight.w300,
                                  fontSize: size.width * 0.015,
                                  color: const Color(0xff3F9272),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.width * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Deskripsi",
                                  style: GoogleFonts.josefinSans(
                                      color: Color(0xFF3F9272))),
                            ],
                          ),
                          Container(
                            width: size.width * 0.5,
                            child: TextField(
                              maxLines:
                                  null, // Mengizinkan TextField untuk tumbuh secara vertikal
                              decoration: InputDecoration(
                                fillColor:
                                    Colors.white, // Warna latar belakang putih
                                filled: true, // Mengaktifkan fillColor
                                hintStyle: GoogleFonts.josefinSans(
                                  fontWeight: FontWeight.w300,
                                  fontSize: size.width * 0.015,
                                  color: const Color(0xff3F9272),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical:
                                      30.0, // Tinggi padding yang lebih besar
                                  horizontal: 15.0, // Lebar padding
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.width * 0.02,
                          ),
                          Text("Detail Gambar",
                              style: GoogleFonts.josefinSans(
                                  color: Color(0xFF3F9272))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DottedBorder(
                            color:
                                Color(0xFF308967), // Warna border putus-putus
                            strokeWidth: 2, // Ketebalan garis
                            dashPattern: [
                              6,
                              3
                            ], // Pola garis putus-putus [panjang garis, jarak antar garis]
                            borderType: BorderType
                                .RRect, // Border dengan sudut melengkung
                            radius: Radius.circular(8), // Radius sudut
                            child: Container(
                              width: size.width * 0.15,
                              height: size.height * 0.25,
                              color: Colors.white, // Warna latar belakang putih
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.image_search_outlined,
                                      color: Color(0xFF308967),
                                    ),
                                  ),
                                  Text(
                                    "Upload gambar di sini",
                                    style: GoogleFonts.josefinSans(
                                      color: Color(0xFF308967),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: size.width * 0.30,
                            height: size.height * 0.30,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Pilih Kategori",
                                  style: GoogleFonts.josefinSans(
                                    fontSize: size.width * 0.016,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff3F9272),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.1,
                                ),
                                Container(
                                  width: size.width * 0.15,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                        //menggunakan widget radio untuk memilih produk
                                        value: 'kasir',
                                        groupValue: _produk,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _produk = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        "Tanaman Hias",
                                        style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.015,
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xff3F9272),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: size.width * 0.15,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                        value: 'Ikan Hias',
                                        groupValue: _produk,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _produk = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        "Ikan Hias",
                                        style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.015,
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xff3F9272),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: size.width * 0.15,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                        value: 'admin',
                                        groupValue: _produk,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _produk = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        "Burung Hias",
                                        style: GoogleFonts.josefinSans(
                                          fontSize: size.width * 0.015,
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xff3F9272),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.width * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Harga",
                              style: GoogleFonts.josefinSans(
                                  color: Color(0xFF3F9272))),
                        ],
                      ),
                      Container(
                        width: size.width * 0.5,
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor:
                                Colors.white, // Warna latar belakang putih
                            filled: true, // Mengaktifkan fillColor

                            hintStyle: GoogleFonts.josefinSans(
                              fontWeight: FontWeight.w300,
                              fontSize: size.width * 0.015,
                              color: const Color(0xff3F9272),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Kategori",
                            style: GoogleFonts.josefinSans(
                                color: Color(0xFF3F9272)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add_box_outlined,
                                color: Color(0xFF3F9272),
                              ),
                            ),
                          ),
                          Text(
                            "Nama Kategori",
                            style: GoogleFonts.josefinSans(
                                color: Color(0xFF3F9272)),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Container(
                            width: size.width * 0.15,
                            child: TextField(
                              decoration: InputDecoration(
                                fillColor:
                                    Colors.white, // Warna latar belakang putih
                                filled: true, // Mengaktifkan fillColor

                                hintStyle: GoogleFonts.josefinSans(
                                  fontWeight: FontWeight.w300,
                                  fontSize: size.width * 0.015,
                                  color: const Color(0xff3F9272),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width * 0.06,
                          ),
                          Container(
                            child: IconButton(
                              onPressed: () {},
                              icon:const Icon(
                                Icons.add_box_outlined,
                                color: Color(0xFF3F9272),
                              ),
                            ),
                          ),
                          Text(
                            "Sub Kategori",
                            style: GoogleFonts.josefinSans(
                                color: Color(0xff3F9272)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(width: size.width * 0.099),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nama Kategori",
                                style: GoogleFonts.josefinSans(
                                    color:const Color(0xFF3F9272)),
                              ),
                              Container(
                                width: size.width * 0.15,
                                child: TextField(
                                  decoration: InputDecoration(
                                    fillColor: Colors
                                        .white,
                                    filled: true, 

                                    hintStyle: GoogleFonts.josefinSans(
                                      fontWeight: FontWeight.w300,
                                      fontSize: size.width * 0.015,
                                      color: const Color(0xff3F9272),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Column(
                            children: [
                              Text(
                                "Stok",
                                style: GoogleFonts.josefinSans(
                                    color: Color(0xFF3F9272)),
                              ),
                              Container(
                                width: size.width * 0.05,
                                child: TextField(
                                  decoration: InputDecoration(
                                    fillColor: Colors
                                        .white, // Warna latar belakang putih
                                    filled: true, // Mengaktifkan fillColor

                                    hintStyle: GoogleFonts.josefinSans(
                                      fontWeight: FontWeight.w300,
                                      fontSize: size.width * 0.015,
                                      color: const Color(0xff3F9272),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ), //
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(width: size.width * 0.099),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nama Kategori",
                                style: GoogleFonts.josefinSans(
                                    color: Color(0xFF3F9272)),
                              ),
                              Container(
                                width: size.width * 0.15,
                                child: TextField(
                                  decoration: InputDecoration(
                                    fillColor: Colors
                                        .white, // Warna latar belakang putih
                                    filled: true, // Mengaktifkan fillColor

                                    hintStyle: GoogleFonts.josefinSans(
                                      fontWeight: FontWeight.w300,
                                      fontSize: size.width * 0.015,
                                      color: const Color(0xff3F9272),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Column(
                            children: [
                              Text(
                                "Stok",
                                style: GoogleFonts.josefinSans(
                                    color: const Color(0xFF3F9272)),
                              ),
                              Container(
                                width: size.width * 0.05,
                                child: TextField(
                                  decoration: InputDecoration(
                                    fillColor: Colors
                                        .white, // Warna latar belakang putih
                                    filled: true, // Mengaktifkan fillColor

                                    hintStyle: GoogleFonts.josefinSans(
                                      fontWeight: FontWeight.w300,
                                      fontSize: size.width * 0.015,
                                      color: const Color(0xff3F9272),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ), //
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(width: size.width * 0.099),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nama Kategori",
                                style: GoogleFonts.josefinSans(
                                    color: const Color(0xFF3F9272)),
                              ),
                              Container(
                                width: size.width * 0.15,
                                child: TextField(
                                  decoration: InputDecoration(
                                    fillColor: Colors
                                        .white, // Warna latar belakang putih
                                    filled: true, // Mengaktifkan fillColor

                                    hintStyle: GoogleFonts.josefinSans(
                                      fontWeight: FontWeight.w300,
                                      fontSize: size.width * 0.015,
                                      color: const Color(0xff3F9272),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Column(
                            children: [
                              Text(
                                "Stok",
                                style: GoogleFonts.josefinSans(
                                    color: Color(0xFF3F9272)),
                              ),
                              Container(
                                width: size.width * 0.05,
                                child: TextField(
                                  decoration: InputDecoration(
                                    fillColor: Colors
                                        .white, // Warna latar belakang putih
                                    filled: true, // Mengaktifkan fillColor

                                    hintStyle: GoogleFonts.josefinSans(
                                      fontWeight: FontWeight.w300,
                                      fontSize: size.width * 0.015,
                                      color: const Color(0xff3F9272),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ), //
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.30,
                          ),
                          Container(
                            width: size.width * 0.15,
                            height: size.width * 0.04,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.white, // Warna latar belakang putih
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius
                                      .zero, // Membuat tombol berbentuk kotak
                                ),
                              ),
                              child: Text(
                                "Tambah",
                                style: GoogleFonts.josefinSans(
                                  color: Color(
                                      0xFF3F9272), // Mengubah warna teks menjadi hitam untuk kontras
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
