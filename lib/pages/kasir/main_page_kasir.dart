import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttrana_pos/pages/kasir/printer_struck_kasir.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/produk/produk_kasir.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/profile_kasir.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/permintaan.dart';
import 'package:ttrana_pos/pages/kasir/page_sidebar_kasir/status_permintaan.dart';
import 'package:ttrana_pos/pages/kasir/sidebar_kasir.dart';

class MainPageKasir extends StatefulWidget {
  final bool? pageSize;
  const MainPageKasir({
    super.key,
    this.pageSize,
  });

  @override
  _MainPageKasirState createState() => _MainPageKasirState();
}

class _MainPageKasirState extends State<MainPageKasir> {
  int _selectedIndex = 0; // Indeks untuk menyimpan halaman yang dipilih
  String _username = 'Guest'; // Default username
  num _noHp = 08;
  String _email = "Email";
  String _alamat = "Alamat";

  // Fungsi untuk mengambil username dari SharedPreferences
  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Kasir';
      _noHp = prefs.getInt('no_hp') ?? 628;
      _email = prefs.getString('email') ?? "Email";
      _alamat = prefs.getString('alamat') ?? "Alamat";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUsername(); // Panggil saat widget diinisialisasi
  }

  // Fungsi untuk meng-handle perubahan item yang dipilih
  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Daftar halaman berdasarkan item sidebar yang dipilih

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      const ProdukKasir(),
      PermintaanForm(),
      StatusPermintaan(),
      ProfileKasir(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Tampilkan halaman berdasarkan pilihan
          Expanded(
            child: _pages[_selectedIndex],
          ),
          SidebarKasir(
            onItemSelected: _onItemSelected,
            username: _username, // Gunakan username dari SharedPreferences
          ),
        ],
      ),
    );
  }
}