import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart'; // Import package dotted_border untuk garis putus - putus di outline container Upload foto
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/tambah_produk/format_harga.dart';
import 'produk_page.dart';

class TambahProduk extends StatefulWidget {
  const TambahProduk({super.key});

  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  final _formKey = GlobalKey<FormState>();
  String judulProduk = '';
  String deskripsi = '';
  String pilihKategori = '';
  double harga = 0.0;
  File? _image;
  List<Variasi> variasiList = [];

  final List<String> kategoriOptions = ['tanaman', 'ikan', 'burung'];

  final ImagePicker _picker = ImagePicker();

  // Add this method to handle deletion
  void _deleteSubVariasi(int variasiIndex, int subVariasiIndex) {
    setState(() {
      variasiList[variasiIndex].subVariasi.removeAt(subVariasiIndex);
    });
  }

  void _deleteVariasi(int index) {
    setState(() {
      variasiList.removeAt(index);
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        // User canceled the picker
      }
    });
  }

  void _addVariasi() {
    setState(() {
      variasiList.add(Variasi(namaVariasi: '', subVariasi: []));
    });
  }

  void _addSubVariasi(int index) {
    setState(() {
      variasiList[index].subVariasi.add(SubVariasi(
            namaSubVariasi: '',
            usia: '',
            stok: 0,
            harga: 0.0,
          ));
    });
  }

  Future<void> _uploadData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        Dio dio = Dio();

        String url = 'https://74gslzvj-8000.asse.devtunnels.ms/api/produk';

        FormData formData = FormData.fromMap({
          'judul_produk': judulProduk,
          'deskripsi_produk': deskripsi,
          'kategori_produk': pilihKategori,
          'harga': harga.toString(),
          'variasi': jsonEncode(variasiList.map((e) => e.toJson()).toList()),
          if (_image != null)
            'foto_produk': await MultipartFile.fromFile(
              _image!.path,
              filename: _image!.path.split('/').last,
            ),
        });

        Response response = await dio.post(url, data: formData);

        if (response.statusCode == 200) {
          // Berhasil
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Produk berhasil diupload')),
          );
          // Reset form jika diperlukan
          _formKey.currentState!.reset();
          setState(() {
            _image = null;
            variasiList.clear();
            pilihKategori = '';
          });
        } else {
          // Gagal
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal mengupload produk')),
          );
        }
      } catch (e) {
        // Penanganan error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                              child: TextFormField(
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan judul produk';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  judulProduk = value!;
                                },
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
                              child: TextFormField(
                                maxLines:
                                    null, // Mengizinkan TextFormField untuk tumbuh secara vertikal
                                decoration: InputDecoration(
                                  fillColor: Colors
                                      .white, // Warna latar belakang putih
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Masukkan deskripsi';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  deskripsi = value!;
                                },
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
                                color:
                                    Colors.white, // Warna latar belakang putih
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _image ==
                                            null // Jika tidak ada gambar yang dipilih
                                        ? IconButton(
                                            onPressed: _pickImage,
                                            icon: Icon(
                                              Icons.image_search_outlined,
                                              color: Color(0xFF308967),
                                            ),
                                          )
                                        : Column(
                                            children: [
                                              Image.file(
                                                _image!,
                                                fit: BoxFit.cover,
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed:
                                                    _pickImage, // Tombol untuk memilih gambar lagi
                                              ),
                                            ],
                                          ),
                                    if (_image ==
                                        null) // Tampilkan teks jika tidak ada gambar
                                      Text(
                                        'No image selected.',
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          //menggunakan widget radio untuk memilih produk
                                          value: 'tanaman',
                                          groupValue: pilihKategori,
                                          onChanged: (String? value) {
                                            setState(() {
                                              pilihKategori = value!;
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'ikan',
                                          groupValue: pilihKategori,
                                          onChanged: (String? value) {
                                            setState(() {
                                              pilihKategori = value!;
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Radio(
                                          value: 'burung',
                                          groupValue: pilihKategori,
                                          onChanged: (String? value) {
                                            setState(() {
                                              pilihKategori = value!;
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
                          child: TextFormField(
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
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              CurrencyTextInputFormatter()
                            ], // Tambahkan formatter
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan harga';
                              }
                              if (double.tryParse(value
                                      .replaceAll('.', '')
                                      .replaceAll(',', '.')) ==
                                  null) {
                                return 'Masukkan angka yang valid';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              // Menghapus format sebelum menyimpan
                              harga = double.parse(value!
                                  .replaceAll('.', '')
                                  .replaceAll(',', '.'));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Variasi",
                              style: GoogleFonts.josefinSans(
                                  color: Color(0xFF3F9272), fontSize: 30),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width * 0.15,
                              height: size.width * 0.04,
                              child: ElevatedButton(
                                onPressed: _addVariasi,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .white, // Warna latar belakang putih
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius
                                        .zero, // Membuat tombol berbentuk kotak
                                  ),
                                ),
                                child: Text(
                                  "Tambah Variasi",
                                  style: GoogleFonts.josefinSans(
                                    color: Color(
                                        0xFF3F9272), // Mengubah warna teks menjadi hitam untuk kontras
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: variasiList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: IconButton(
                                          onPressed: () =>
                                              _deleteVariasi(index),
                                          icon: Icon(
                                            Icons
                                                .remove_circle_outline_outlined,
                                            color: Color(0xFF3F9272),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Nama Variasi",
                                        style: GoogleFonts.josefinSans(
                                            color: Color(0xFF3F9272)),
                                      ),
                                      SizedBox(height: 8),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintStyle: GoogleFonts.josefinSans(
                                              fontWeight: FontWeight.w300,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.015,
                                              color: const Color(0xff3F9272),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Masukkan nama variasi';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.1,
                                      ),
                                      Container(
                                        child: IconButton(
                                          onPressed: () =>
                                              _addSubVariasi(index),
                                          icon: Icon(
                                            Icons.add_circle_outline_outlined,
                                            color: Color(0xFF3F9272),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Tambah Sub Variasi',
                                        style: GoogleFonts.josefinSans(
                                            color: Color(0xFF3F9272)),
                                      ),
                                    ],
                                  ),
                                  // Nested ListView for subVariasi
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        variasiList[index].subVariasi.length,
                                    itemBuilder: (context, subIndex) {
                                      return Column(
                                        children: [
                                          Row(
                                            //////
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: size.width * 0.05,
                                              ),
                                              SizedBox(
                                                height: size.height * 0.07,
                                              ),
                                              Text(
                                                "Sub Variasi",
                                                style: GoogleFonts.josefinSans(
                                                  color: Color(0xff3F9272),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.050),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Nama Sub Variasi",
                                                    style:
                                                        GoogleFonts.josefinSans(
                                                            color: const Color(
                                                                0xFF3F9272)),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.10,
                                                    child: TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        hintStyle: GoogleFonts
                                                            .josefinSans(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.015,
                                                          color: const Color(
                                                              0xff3F9272),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        variasiList[index]
                                                                .subVariasi[
                                                                    subIndex]
                                                                .namaSubVariasi =
                                                            value;
                                                      },
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Masukkan nama sub variasi';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.009),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Usia",
                                                    style:
                                                        GoogleFonts.josefinSans(
                                                            color: const Color(
                                                                0xFF3F9272)),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.09,
                                                    child: TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        hintStyle: GoogleFonts
                                                            .josefinSans(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.015,
                                                          color: const Color(
                                                              0xff3F9272),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        variasiList[index]
                                                            .subVariasi[
                                                                subIndex]
                                                            .usia = value;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.009),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Stok",
                                                    style:
                                                        GoogleFonts.josefinSans(
                                                            color: const Color(
                                                                0xFF3F9272)),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                    child: TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        hintStyle: GoogleFonts
                                                            .josefinSans(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.015,
                                                          color: const Color(
                                                              0xff3F9272),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        if (value.isNotEmpty) {
                                                          variasiList[index]
                                                                  .subVariasi[
                                                                      subIndex]
                                                                  .stok =
                                                              int.parse(value);
                                                        }
                                                      },
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Masukkan stok';
                                                        }
                                                        if (int.tryParse(
                                                                value) ==
                                                            null) {
                                                          return 'Masukkan angka yang valid';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.009),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Harga",
                                                    style:
                                                        GoogleFonts.josefinSans(
                                                            color: const Color(
                                                                0xFF3F9272)),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.09,
                                                    child: TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        hintStyle: GoogleFonts
                                                            .josefinSans(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.015,
                                                          color: const Color(
                                                              0xff3F9272),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        if (value.isNotEmpty) {
                                                          variasiList[index]
                                                                  .subVariasi[
                                                                      subIndex]
                                                                  .harga =
                                                              double.parse(
                                                                  value);
                                                        }
                                                      },
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Masukkan harga';
                                                        }
                                                        if (double.tryParse(
                                                                value) ==
                                                            null) {
                                                          return 'Masukkan angka yang valid';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: IconButton(
                                                  onPressed: () =>
                                                      _deleteSubVariasi(
                                                          index, subIndex),
                                                  icon: const Icon(
                                                    Icons
                                                        .remove_circle_outline_outlined,
                                                    color: Color(0xFF3F9272),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.03,
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
                                onPressed: _uploadData,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .white, // Warna latar belakang putih
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
      ),
    );
  }
}
