import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttrana_pos/pages/login.dart';

class PengeluaranFormPage extends StatefulWidget {
  @override
  _PengeluaranFormPageState createState() => _PengeluaranFormPageState();
}

class _PengeluaranFormPageState extends State<PengeluaranFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaPenjualController = TextEditingController();
  final TextEditingController _noPenjualController = TextEditingController();

  List<Map<String, dynamic>> _produkList = [];
  String? _kategoriProduk; // Variabel untuk menyimpan kategori yang dipilih

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final token = await getToken();

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Token tidak ditemukan. Harap login kembali."),
          ),
        );
        return;
      }

      final data = {
        "kategori_produk": _kategoriProduk,
        "nama_penjual": _namaPenjualController.text,
        "no_penjual": _noPenjualController.text,
        "pengeluaran": _produkList,
      };

      print("Data yang akan dikirim: $data");

      try {
        final dio = Dio();
        dio.options.headers['Authorization'] = 'Bearer $token';
        final response = await dio.post(
          'https://74gslzvj-8000.asse.devtunnels.ms/api/createPengeluaran',
          data: data,
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Data berhasil dikirim!")),
          );
        } else {
          print("Response: ${response.statusCode}, ${response.data}");
        }
      } catch (e) {
        print("Error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal mengirim data: $e")),
        );
      }
    }
  }

  void _addProdukForm() {
    setState(() {
      _produkList.add({
        "nama_produk": "",
        "harga_satuan": 0,
        "stok": 0,
        "total": 0,
        "isEditing": true,
      });
    });
  }

  void _saveProduk(int index) {
    setState(() {
      final produk = _produkList[index];
      produk["total"] = produk["harga_satuan"] * produk["stok"];
      produk["isEditing"] = false;
    });
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print("Token berhasil disimpan: $token");
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    print("Token berhasil dihapus");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pengeluaran",
          style: TextStyle(
            color: Color(0xff3F9272),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await clearToken();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Dropdown untuk kategori produk
              Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.01),
                child: DropdownButtonFormField<String>(
                  value: _kategoriProduk,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "Kategori Produk",
                    labelStyle: TextStyle(
                      color: Color(0xff3F9272),
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          BorderSide(color: Color(0xff3F9272), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          BorderSide(color: Color(0xff3F9272), width: 1),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                  ),
                  items: [
                    DropdownMenuItem(value: "tanaman", child: Text("Tanaman")),
                    DropdownMenuItem(value: "ikan", child: Text("Ikan")),
                    DropdownMenuItem(value: "burung", child: Text("Burung")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _kategoriProduk = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Kategori harus dipilih";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.01),
                child: TextFormField(
                  controller: _namaPenjualController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "Nama Penjual",
                    labelStyle: TextStyle(
                      color: Color(0xff3F9272),
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          BorderSide(color: Color(0xff3F9272), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          BorderSide(color: Color(0xff3F9272), width: 1),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nama Penjual harus diisi";
                    }
                    return null;
                  },
                ),
              ),
              TextFormField(
                controller: _noPenjualController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "No. Penjual",
                  labelStyle: TextStyle(
                    color: Color(0xff3F9272),
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Color(0xff3F9272), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Color(0xff3F9272), width: 1),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "No. Penjual harus diisi";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _produkList.length,
                  itemBuilder: (context, index) {
                    final produk = _produkList[index];
                    return produk["isEditing"]
                        ? Card(
                            color: Color(0xFFEBFFF8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: size.height * 0.01),
                                    child: TextFormField(
                                      initialValue: produk["nama_produk"],
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        labelText: "Nama Produk",
                                        labelStyle: TextStyle(
                                          color: Color(0xff3F9272),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                              color: Color(0xff3F9272),
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                              color: Color(0xff3F9272),
                                              width: 1),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        produk["nama_produk"] = value;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: size.height * 0.01),
                                    child: TextFormField(
                                      initialValue:
                                          produk["harga_satuan"].toString(),
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        labelText: "Harga Satuan",
                                        labelStyle: TextStyle(
                                          color: Color(0xff3F9272),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                              color: Color(0xff3F9272),
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                              color: Color(0xff3F9272),
                                              width: 1),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        produk["harga_satuan"] =
                                            int.tryParse(value) ?? 0;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: size.height * 0.01),
                                    child: TextFormField(
                                      initialValue: produk["stok"].toString(),
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        labelText: "Stok",
                                        labelStyle: TextStyle(
                                          color: Color(0xff3F9272),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                              color: Color(0xff3F9272),
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                              color: Color(0xff3F9272),
                                              width: 1),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        produk["stok"] =
                                            int.tryParse(value) ?? 0;
                                      },
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff3F9272),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () => _saveProduk(index),
                                    child: Text(
                                      "Simpan Produk",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Color(0xff3F9272), // Warna latar belakang
                              borderRadius:
                                  BorderRadius.circular(12.0), // Border radius
                            ),
                            child: ListTile(
                              textColor: Colors.white,
                              title: Text(produk["nama_produk"]),
                              subtitle: Text(
                                  "Harga: ${produk["harga_satuan"]}, Stok: ${produk["stok"]}, Total: ${produk["total"]}"),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    produk["isEditing"] = true;
                                  });
                                },
                              ),
                            ),
                          );
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff3F9272),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _addProdukForm,
                child: Text(
                  "Tambah Produk",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff3F9272),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _submitForm,
                child: Text(
                  "Kirim Pengeluaran",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
