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
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Pengeluaran"),
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
              DropdownButtonFormField<String>(
                value: _kategoriProduk,
                decoration: InputDecoration(labelText: "Kategori Produk"),
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
              TextFormField(
                controller: _namaPenjualController,
                decoration: InputDecoration(labelText: "Nama Penjual"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama Penjual harus diisi";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _noPenjualController,
                decoration: InputDecoration(labelText: "No. Penjual"),
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    initialValue: produk["nama_produk"],
                                    decoration: InputDecoration(
                                        labelText: "Nama Produk"),
                                    onChanged: (value) {
                                      produk["nama_produk"] = value;
                                    },
                                  ),
                                  TextFormField(
                                    initialValue:
                                        produk["harga_satuan"].toString(),
                                    decoration: InputDecoration(
                                        labelText: "Harga Satuan"),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      produk["harga_satuan"] =
                                          int.tryParse(value) ?? 0;
                                    },
                                  ),
                                  TextFormField(
                                    initialValue: produk["stok"].toString(),
                                    decoration:
                                        InputDecoration(labelText: "Stok"),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      produk["stok"] = int.tryParse(value) ?? 0;
                                    },
                                  ),
                                  ElevatedButton(
                                    onPressed: () => _saveProduk(index),
                                    child: Text("Simpan Produk"),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListTile(
                            title: Text(produk["nama_produk"]),
                            subtitle: Text(
                                "Harga: ${produk["harga_satuan"]}, Stok: ${produk["stok"]}, Total: ${produk["total"]}"),
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                setState(() {
                                  produk["isEditing"] = true;
                                });
                              },
                            ),
                          );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _addProdukForm,
                child: Text("Tambah Produk"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Kirim Pengeluaran"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
