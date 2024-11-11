import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermintaanForm extends StatefulWidget {
  @override
  _PermintaanFormState createState() => _PermintaanFormState();
}

class _PermintaanFormState extends State<PermintaanForm> {
  String username = '';
  String role = '';
  String? token;
  bool isLoading = true;

  final Dio _dio = Dio();
  List<Map<String, dynamic>> items = [
    {
      'nama_produk': TextEditingController(),
      'stok': TextEditingController(),
      'hargaSatuan': TextEditingController(),
      'deskripsi': TextEditingController(),
      'subtotal': 0.0,
    }
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
      role = prefs.getString('role') ?? '';
      token = prefs.getString('token');
      isLoading = false;
    });
  }

  void calculateSubtotal(int index) {
    final stok = int.tryParse(items[index]['stok'].text) ?? 0;
    final hargaSatuan =
        double.tryParse(items[index]['hargaSatuan'].text) ?? 0.0;
    setState(() {
      items[index]['subtotal'] = stok * hargaSatuan;
    });
  }

  void addItem() {
    setState(() {
      items.add({
        'nama_produk': TextEditingController(),
        'stok': TextEditingController(),
        'hargaSatuan': TextEditingController(),
        'deskripsi': TextEditingController(),
        'subtotal': 0.0,
      });
    });
  }

  void removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  Future<void> submitPermintaan() async {
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anda harus login terlebih dahulu!')),
      );
      return;
    }

    final permintaan = items.map((item) {
      return {
        "nama_produk": item['nama_produk'].text,
        "stok": int.tryParse(item['stok'].text) ?? 0,
        "hargaSatuan": double.tryParse(item['hargaSatuan'].text) ?? 0.0,
        "deskripsi": item['deskripsi'].text,
        "total": item['subtotal'],
      };
    }).toList();

    final data = {"permintaan": permintaan};

    try {
      final response = await _dio.post(
        "https://74gslzvj-8000.asse.devtunnels.ms/api/createPermintaan",
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permintaan berhasil dikirim!')),
        );
        _clearForm();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Gagal mengirim permintaan: ${response.data['message'] ?? response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan, coba lagi nanti!')),
      );
    }
  }

  void _clearForm() {
    setState(() {
      items = [
        {
          'nama_produk': TextEditingController(),
          'stok': TextEditingController(),
          'hargaSatuan': TextEditingController(),
          'deskripsi': TextEditingController(),
          'subtotal': 0.0,
        }
      ];
    });
  }

  Widget _buildItemForm(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildTextField(
                controller: items[index]['nama_produk'],
                label: 'Nama Produk',
                hintText: 'Masukkan nama produk',
                onChanged: () => calculateSubtotal(index),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildTextField(
                controller: items[index]['stok'],
                label: 'Stok',
                hintText: 'Masukkan jumlah stok',
                isNumeric: true,
                onChanged: () => calculateSubtotal(index),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildTextField(
                controller: items[index]['hargaSatuan'],
                label: 'Harga Satuan',
                hintText: 'Masukkan harga satuan',
                isNumeric: true,
                onChanged: () => calculateSubtotal(index),
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.red),
              onPressed: () => removeItem(index),
            ),
          ],
        ),
        _buildTextField(
          controller: items[index]['deskripsi'],
          label: 'Deskripsi',
          hintText: 'Masukkan deskripsi produk',
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "Subtotal: Rp ${items[index]['subtotal'].toStringAsFixed(2)}",
            style: GoogleFonts.josefinSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3F9272),
            ),
          ),
        ),
        Divider(),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool isNumeric = false,
    Function? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        if (onChanged != null) onChanged();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: items.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => _buildItemForm(index),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: addItem,
                    child: Text("Tambah Item"),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: submitPermintaan,
                    child: Text("Kirim"),
                  ),
                ],
              ),
            ),
    );
  }
}
