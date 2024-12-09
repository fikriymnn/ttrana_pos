import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/pembelian.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/terima_permintaan.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/produk/produk.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/profile.dart';
import 'package:ttrana_pos/pages/admin/page_sidebar/tambah_produk/tambah_produk.dart';
import 'package:ttrana_pos/pages/admin/sidebar.dart';

class MainPage extends StatefulWidget {
  final String? username;
  const MainPage({super.key, this.username});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Indeks untuk menyimpan halaman yang dipilih
  bool _isManagementExpanded = false; // Status apakah dropdown terbuka
  String _username = 'Guest'; // Default username

  // Fungsi untuk mengambil username dari SharedPreferences
  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Admin';
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
  final List<Widget> _pages = [
    const TambahProduk(),
    AdminPermintaanPage(),
    PengeluaranFormPage(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        children: [
          Sidebar(
            onItemSelected: _onItemSelected,
            isManagementExpanded: _isManagementExpanded,
            onManagementExpandToggle: (value) {
              setState(() {
                _isManagementExpanded = value;
              });
            },
            username: _username,
          ), // Sidebar
          Expanded(
            child:
                _pages[_selectedIndex], // Tampilkan halaman berdasarkan pilihan
          ),
        ],
      ),
    );
  }
}
